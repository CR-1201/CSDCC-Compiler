import os
import subprocess
import glob
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed

ROOT_DIR = os.path.abspath(os.path.join(os.path.abspath(__file__), '../..'))
TEST_DIR = f'{ROOT_DIR}/tests'
CP = '../compiler.jar'
TEST_CASES = []

def init():
    subprocess.run('make build', cwd=ROOT_DIR, shell=True)
    lib_file = 'lib/libsysy.so'
    cmd = f'clang -shared -fPIC lib/sylib.c -o {lib_file}'
    print(f'Running {cmd}')
    subprocess.run(cmd, cwd=TEST_DIR, shell=True, check=True)

    # setup testcases
    dir_list = ['testcases']
    for dir in dir_list:
        testcase_dir = f'{TEST_DIR}/{dir}'
        test_files = glob.glob(os.path.join(testcase_dir, '*.sy'))
        input_files = glob.glob(os.path.join(testcase_dir, '*.in'))
        ans_files = glob.glob(os.path.join(testcase_dir, '*.out'))
        f = lambda x: [s[len(TEST_DIR) + 1:] if s.startswith(TEST_DIR) else s for s in x]
        test_files = f(test_files)
        input_files = f(input_files)
        ans_files = f(ans_files)

        for test_file in test_files:
            input_file = f'{test_file.replace(".sy", ".in")}'
            ans_file = f'{test_file.replace(".sy", ".out")}'
            if input_file in input_files and ans_file in ans_files:
                TEST_CASES.append(
                    {
                        'test_file': test_file,
                        'input_file': input_file,
                        'ans_file':  ans_file
                    }
                )

def create_folder_for(file):
    parent_dir = f'{TEST_DIR}/{os.path.dirname(file)}'
    if not os.path.exists(parent_dir):
        try:
            os.makedirs(parent_dir)
        except:
            return

def ensure_newline_at_end_of_file(file_path):
    with open(f'{TEST_DIR}/{file_path}', 'a+') as file:
        file.seek(0, os.SEEK_END)
        if file.tell() > 0:
            file.seek(-1, os.SEEK_END)
            last_char = file.read(1)
            if last_char != '\n':
                file.write('\n')

def check(stop_event, test_file, input_file, ans_file=''):
    filename = os.path.splitext(test_file)[0]
    ir_file = f'ir/{filename}.ll'
    ir_runnable = f'ir/{filename}'
    ir_std = f'ir_std/{filename}.ll'
    ir_std_runnable = f'ir_std/{filename}'
    asm_file = f'asm/{filename}.asm'
    output_file = f'output/{test_file}'

    # run compiler
    try:
        create_folder_for(ir_file)
        create_folder_for(asm_file)
        cmd = f'java -jar {CP} -f {test_file} -ll {ir_file} -o {asm_file}'
        print(f'Running: {cmd}')
        subprocess.check_output(cmd, cwd=TEST_DIR, shell=True, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f'[ERROR FILE] {test_file}')
        print(f'Error running compiler for {test_file}:\n{e.output.decode()}')
        stop_event.set()
        return False

    # link with lib.ll
    try:
        cmd = f'clang {ir_file} -L./lib -lsysy -o {ir_runnable}'
        print(f'Running: {cmd}')
        subprocess.check_output(cmd, cwd=TEST_DIR, shell=True, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f'[ERROR FILE] {test_file}')
        print(f'Error running clang for {ir_file}:\n{e.output.decode()}')
        stop_event.set()
        return False

    # run ir
    try:
        create_folder_for(output_file)
        cmd = f'./{ir_runnable} < {input_file} > {output_file}'
        print(f'Running: {cmd}')
        subprocess.check_output(cmd, cwd=TEST_DIR, shell=True, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f'[ERROR FILE] {test_file}')
        print(f'Error running {ir_runnable}:\n{e.output.decode()}')
        stop_event.set()
        return False
    
    # TODO: run asm

    # get std answer
    if not ans_file:
        ans_file = f'ans/{test_file}'
        create_folder_for(ir_std)
        subprocess.run(f'clang -x c -S -emit-llvm {test_file} -o {ir_std} -O0 2>/dev/null', cwd=TEST_DIR, shell=True)
        subprocess.run(f'clang {ir_std} -L./lib -lsysy -o {ir_std_runnable}', cwd=TEST_DIR, shell=True)
        create_folder_for(ans_file)
        subprocess.run(f'./{ir_std_runnable} < {input_file} > {ans_file}', cwd=TEST_DIR, shell=True)

    ensure_newline_at_end_of_file(output_file)
    ensure_newline_at_end_of_file(ans_file)
    r = subprocess.run(f'diff {output_file} {ans_file}', cwd=TEST_DIR, shell=True, capture_output=True, text=True, check=False)
    if r.returncode != 0:
        print(f'[ERROR FILE] {test_file}')
        print(f'{test_file} WA')
        print(r.stdout)
        stop_event.set()
        return False
    print(f'{test_file} AC')
    return True

if __name__ == '__main__':
    stop_event = threading.Event()
    init()

    with ThreadPoolExecutor(max_workers=16) as executor:
        tasks = {executor.submit(check, stop_event=stop_event, **case): case for case in TEST_CASES}
        
        for task in as_completed(tasks):
            if stop_event.is_set():
                for t in tasks:
                    if not t.done():
                        t.cancel()
                exit(1)
            try:
                if not task.result():
                    case = tasks[task]
                    print(f'Stopping due to error in processing {case}')
                    stop_event.set()
                    exit(1)
            except Exception as e:
                print(f'Exception: {e}')
                stop_event.set()
                exit(1)

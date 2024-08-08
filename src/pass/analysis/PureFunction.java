package pass.analysis;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import static pass.analysis.AliasAnalysis.searchRoot;

public class PureFunction {

    private final Module module = Module.getModule();

    public HashMap<Function, Boolean> is_pure = new HashMap<>();
    public HashMap<Function, HashSet<Value>> global_var_store_effects = new HashMap<>();

    /**
     * 判断函数是否是纯函数, 维护 is_pure 表
     * 非纯函数: 有对全局变量或传入数组的 store, 或者调用了非纯函数
     * 这里不考虑 MMIO 等 load 导致的非纯函数情形
     */
    public void markPure(){
        is_pure.clear();
        global_var_store_effects.clear();
        ArrayList<Function> functions = module.getFunctionsArray();
        ArrayList<Function> work_list = new ArrayList<>();

        for(Function function : functions){
            // 忽略库函数
            if( function.getIsBuiltIn() ) {
                is_pure.put(function, false);
                work_list.add(function);
                continue;
            }
            is_pure.put(function, makePureInside(function));

            if( !is_pure.get(function) || !(global_var_store_effects.containsKey(function) && global_var_store_effects.get(function).isEmpty()) ){
                work_list.add(function);
            }
        }

        for( int i = 0; i < work_list.size(); i++ ){
            Function callee_function = work_list.get(i);
            for( User user : callee_function.getUsers()){
//                System.out.println(user);
                if( !(user instanceof Call call) ){
                    continue;
                }
                Function caller_function = call.getParent().getParent();
                boolean influenced = false;
                if( global_var_store_effects.containsKey(callee_function)){
                    for( Value value : global_var_store_effects.get(callee_function) ){
                        if( !(global_var_store_effects.containsKey(caller_function) && global_var_store_effects.get(caller_function).contains(value))){
                            if( global_var_store_effects.containsKey(caller_function) ){
                                global_var_store_effects.get(caller_function).add(value);
                            } else {
                                global_var_store_effects.put(caller_function, new HashSet<>());
                                global_var_store_effects.get(caller_function).add(value);
                            }
                            influenced = true;
                        }
                    }
                }

                if( is_pure.get(caller_function) != null && is_pure.get(caller_function) ){
                    is_pure.put(caller_function,false);
                    influenced = true;
                }

                if(influenced){
                    work_list.add(caller_function);
                }
            }
        }
    }

    /**
     * 不考虑函数内部调用其他函数,判断纯函数,用于第一遍生成 worklist
     * true 不考虑函数调用, f 是纯函数
     * false 不考虑函数调用, f 也不是纯函数
     */
    private boolean makePureInside(Function function){
        boolean pure = true;
        ArrayList<BasicBlock> basicBlocks = function.getBasicBlocksArray();
        for(BasicBlock basicBlock : basicBlocks){
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for(Instruction instruction : instructions){
                // store 指令,且无法找到 alloca 作为左值, 说明非局部变量;
                if( instruction instanceof Store store && store_to_alloca(store) == null ){
                    if( searchRoot(store.getAddr()) instanceof GlobalVariable globalVariable ){
                        if( global_var_store_effects.containsKey(function) ){
                            global_var_store_effects.get(function).add(globalVariable);
                        } else {
                            global_var_store_effects.put(function, new HashSet<>());
                            global_var_store_effects.get(function).add(globalVariable);
                        }
                    }
                    pure = false; // 也可能是传入数组的store
                } else if( instruction instanceof Load load && load_to_alloca(load) == null ){
                    if( searchRoot(load.getAddr()) instanceof GlobalVariable globalVariable ){
                        if( global_var_store_effects.containsKey(function) ){
                            global_var_store_effects.get(function).add(globalVariable);
                        } else {
                            global_var_store_effects.put(function, new HashSet<>());
                            global_var_store_effects.get(function).add(globalVariable);
                        }
                        pure = false; // 只有加载全局变量的值才会 pure = false
                    }
                }

            }
        }
        return pure;
    }

    /**
     * 试图还原 store 到 左值 (alloca 指令)
     * 用于判断是否具有副作用
     */
    Alloca store_to_alloca(Store store){
        // lval 无法转换为 alloca 指令说明是非局部的, 有副作用
        Value lval_runner = store.getAddr();
        while( lval_runner instanceof GEP){
            lval_runner = ((GEP)lval_runner).getBase();
        }
        if( lval_runner instanceof Alloca alloca){
            return alloca;
        } else return null;
    }

    Alloca load_to_alloca(Load load){
        // lval 无法转换为 alloca 指令说明是非局部的, 有副作用
        Value lval_runner = load.getAddr();
        while( lval_runner instanceof GEP){
            lval_runner = ((GEP)lval_runner).getBase();
        }
        if( lval_runner instanceof Alloca alloca){
            return alloca;
        } else return null;
    }
}

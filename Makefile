build:
	javac -d ./classes -encoding UTF-8 `find ./src -name "*.java"`
	cd ./classes && jar cmvf ../MANIFEST.MF ../compiler.jar .
	rm -rf ./classes

test-ir:
	$(MAKE) -C ./tests test-ir

test-asm:
	$(MAKE) -C ./tests test-asm

clean:
	rm -rf compiler.jar output.txt llvm_ir.txt error.txt
	$(MAKE) -C ./tests clean

.PHONY: clean

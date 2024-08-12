package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import pass.Pass;

import java.util.ArrayList;

/*
i32* %a = getelementptr &([1 * i32]* %x)[i32 0][i32 %i1];
i32 %i2 = add i32 %i1, i32 1;
i32* %b = getelementptr &([1 * i32]* %x)[i32 0][i32 %i2];
-->
i32* %a = getelementptr &([1 * i32]* %x)[i32 0][i32 %i1];
i32* %b = getelementptr &([1 * i32]* %a)[i32 1];
*/

public class LoopGEPCombine implements Pass {

    private final Module module = Module.getModule();

    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            runOnFunction(function);
        }
    }

    private void runOnFunction(Function function) {
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            runOnBasicBlock(block);
        }
    }

    private void runOnBasicBlock(BasicBlock block) {

    }
}

package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import pass.Pass;
import utils.Pair;

import java.util.ArrayList;

public class runSimplifyInst implements Pass {
    private final Module module = Module.getModule();
    @Override
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn())  {
                ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
                for(BasicBlock basicBlock : blocks){
                    ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
                    for(Instruction instruction : instructions){
                        Value value = SimplifyInst.simplify(instruction);
                        if( !value.equals(instruction) ){
                            instruction.replaceAllUsesWith(value);
                            instruction.eraseFromParent();
                        }
                    }
                }
            }
        }
    }
}

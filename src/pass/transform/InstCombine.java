package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import pass.Pass;

import java.util.ArrayList;

public class InstCombine implements Pass {
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {

            }
        }
    }
    private void runInstCombine(Function function) {
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> insts = block.getInstructionsArray();
            for (Instruction inst : insts) {
                if (inst instanceof BinaryInstruction bi) {

                }
            }
        }
    }
}

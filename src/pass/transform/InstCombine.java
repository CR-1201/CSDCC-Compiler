package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
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

    /**
     * a = b + 1;
     * b = c + 1;
     * => a = c + 2;
     * @param src 原指令
     * @param tgt 合并的目标指令
     */
    private void instCombineAddSub(BinaryInstruction src, BinaryInstruction tgt) {
        Value leftSrc = src.getOp1();
        Value leftTgt = tgt.getOp1();
        Value rightSrc = src.getOp2();
        Value rightTgt = tgt.getOp2();
    }
}

package pass.utility;

import ir.BasicBlock;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;

import java.util.ArrayList;

public class BlockUtil {
    public ArrayList<Phi> getAllPhisIn(ArrayList<BasicBlock> blocks) {
        ArrayList<Phi> phis = new ArrayList<>();
        for (BasicBlock block : blocks) {
            for (Instruction inst : block.getInstructionsArray()) {
                if (inst instanceof Phi phi) {
                    phis.add(phi);
                }
                else break;
            }
        }
        return phis;
    }
}

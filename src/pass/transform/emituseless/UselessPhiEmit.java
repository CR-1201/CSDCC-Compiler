package pass.transform.emituseless;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import pass.Pass;

import java.util.ArrayList;

public class UselessPhiEmit implements Pass {
    public void run() {
        for (Function func : Module.getModule().getFunctionsArray()) {
            if (!func.getIsBuiltIn()) {
                emit(func);
            }
        }
    }

    /**
     * 不动点
     * @param func
     */
    private void emit(Function func) {
        boolean flag = true;
        while (flag) {
            flag = false;
            ArrayList<BasicBlock> blocks = new ArrayList<>(func.getBasicBlocksArray());
            for (BasicBlock bb : blocks) {
                ArrayList<Instruction> insts = new ArrayList<>(bb.getInstructionsArray());
                for (int i = 0; i < insts.size(); i++) {
                    Instruction inst = insts.get(i);
                    if (inst instanceof Phi phi) {
                        Value only = phi.getOperator(0);
                        boolean isOnly = true;
                        for (int j = 0; j < phi.getPrecursorNum(); j++) {
                            if (only != phi.getOperator(j)) {
                                isOnly = false;
                            }
                        }
                        if (isOnly) {
                            flag = true;
                            phi.replaceAllUsesWith(only);
                            phi.removeSelf();
                            continue;
                        }
                        Instruction next = i < insts.size() - 1 ? insts.get(i + 1) : null;
                        if (next != null && next instanceof Phi nph) {
                            if (phi.getPrecursorNum() != nph.getPrecursorNum()) {
                                continue;
                            }
                            boolean isSame = true;
                            for (int j = 0; j < phi.getPrecursorNum(); j++) {
                                if (phi.getOperator(j) != nph.getOperator(j)) {
                                    isSame = false;
                                }
                            }
                            if (isSame) {
                                flag = true;
                                phi.replaceAllUsesWith(nph);
                                phi.removeSelf();
                            }
                        }
                    }
                }
            }
        }
    }
}

package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import pass.Pass;
import pass.analysis.CFG;

import java.util.ArrayList;

public class MergeRedundantBr implements Pass {
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                process(function);
            }
        }
    }

    private void process(Function function) {
        CFG.deleteUnreachableBlock(function);
        BasicBlock entry = function.getFirstBlock();
        boolean flag = true;
        while (flag) {
            flag = false;
            ArrayList<BasicBlock> blocks = new ArrayList<>(function.getBasicBlocksArray());
            for (BasicBlock block : blocks) {
                if (block == entry) {
                    continue;
                }
                if (block.getUselessBr() != null) {
                    Br br = block.getUselessBr();
                    BasicBlock target = (BasicBlock) br.getOperator(0);
                    // 先 Check 一下有没有 Phi 用到这个块，用到的话就删掉
                    if (!block.getPhiUsers().isEmpty()) {
                        if (target.getUselessBr() != null) {
                            // 保证当前块是无条件跳转块，且下一个块也是，才能删，不然有可能下一个直接就是target
                            ArrayList<Phi> phis = block.getPhiUsers();
                            for (Phi phi : phis) {
                                phi.removeUsedBlock(block);
                            }
                            ArrayList<BasicBlock> precs = new ArrayList<>(block.getPrecursors());
                            for (BasicBlock prec : precs) {
                                Br tmp = (Br) prec.getTailInstruction();
                                tmp.setOperator(tmp.getOperators().indexOf(block), target);
                                block.removeSelf();
                            }
                            flag = true;
                        }
                    } else {
                        ArrayList<BasicBlock> precs = new ArrayList<>(block.getPrecursors());
                        for (BasicBlock prec : precs) {
                            Br tmp = (Br) prec.getTailInstruction();
                            tmp.setOperator(tmp.getOperators().indexOf(block), target);
                            target.removeUser(br);
                            block.removeSelf();
                        }
                        flag = true;
                    }
                }
            }
        }
    }
}

package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import pass.Pass;
import pass.analysis.CFG;

import java.util.ArrayList;

public class MergeBlocks implements Pass {
    private CFG cfg = new CFG();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                cond2br(function);
                mergeBlock(function);
//                process(function);
            }
        }
    }

    /**
     *  删掉一个块，会导致某一个phi突然之间少了一个入口
     * @param function
     */
    private void cond2br(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            Instruction tail = block.getTailInstruction();
            if (tail instanceof Br br && br.getHasCondition()) {
                if (br.getOperator(0) instanceof ConstInt cond) {
                    // br i1 1 b1, b2
                    BasicBlock target = null;
                    BasicBlock useless = null;
                    if (cond.getValue() == 1) {
                        target = (BasicBlock) br.getOperator(1);
                        useless = (BasicBlock) br.getOperator(2);
                        handlePhiLoss(block, useless);
                    } else {
                        useless = (BasicBlock) br.getOperator(1);
                        target = (BasicBlock) br.getOperator(2);
                        handlePhiLoss(block, useless);
                    }
                    br.removeSelf();
                    IrBuilder.getIrBuilder().buildBr(block, target);
                }
            }
        }
    }

    private void handlePhiLoss(BasicBlock source, BasicBlock useless) {
        ArrayList<Phi> phis = useless.getPhis();
        for (Phi phi : phis) {
            if (phi.getOperators().contains(source)) {
                phi.removeUsedBlock(source);
                if (phi.getOperators().isEmpty()) {
                    phi.removeSelf();
                }
            }
        }
    }

    private void mergeBlock(Function func) {
        cfg.buildCFG(func);
        boolean flag = true;
        while (flag) {
            flag = false;
            ArrayList<BasicBlock> blocks = func.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                if (canMerge(block)) {
                    Br br = (Br) block.getTailInstruction();
                    BasicBlock to = (BasicBlock) br.getOperator(0);
                    ArrayList<Phi> phis = block.getPhis();
                    for (Phi phi : phis) {
                        Value value = phi.getOperator(0);
                        phi.replaceAllUsesWith(value);
                        phi.removeSelf();
                    }
                    block.removeLastInst();
                    ArrayList<Instruction> insts = to.getInstructionsArray();
                    for (Instruction inst : insts) {
                        inst.move2Block(block);
                    }
                    to.replaceAllUsesWith(block);
                    to.removeSelf();
                    flag = true;
                }
            }
        }
    }

    private Boolean canMerge(BasicBlock block) {
        // 无条件跳转已经说明是只有一个后继了
        if (!block.getInstructions().isEmpty() && block.getTailInstruction() instanceof Br br && !br.getHasCondition()) {
            BasicBlock target = (BasicBlock) br.getOperator(0);
            return target.getPrecursors().size() == 1;
        }
        return false;
    }

    private void process(Function function) {
        cfg.buildCFG(function);
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
                                if (phi.getOperators().isEmpty()) {
                                    phi.removeSelf();
                                }
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

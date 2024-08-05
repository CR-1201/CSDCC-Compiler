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
    private final CFG cfg = new CFG();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                cond2br(function);
                mergeBlock(function);
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
                    // 线性单块
                    Br br = (Br) block.getTailInstruction();
                    BasicBlock to = (BasicBlock) br.getOperator(0);
                    ArrayList<Phi> phis = to.getPhis();
                    for (Phi phi : phis) {
                        Value value = phi.getOperator(0);
                        phi.replaceAllUsesWith(value);
                        phi.removeSelf();
                    }
                    br.removeSelf();
                    ArrayList<BasicBlock> succs = new ArrayList<>(to.getSuccessors());
                    for (BasicBlock succ : succs) {
                        block.addSuccessor(succ);
                        succ.replacePrecursor(to, block);
                    }
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
        if (block.getSuccessors().size() != 1) {
            return false;
        } else if (!block.getInstructionsArray().isEmpty() && block.getTailInstruction() instanceof Br br && !br.getHasCondition()) {
            BasicBlock target = (BasicBlock) br.getOperator(0);
            return target.getPrecursors().size() == 1 && target.getPrecursors().iterator().next() == block;
        }
        return false;
    }
}

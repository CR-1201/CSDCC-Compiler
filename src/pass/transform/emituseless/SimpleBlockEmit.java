package pass.transform.emituseless;


import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import pass.Pass;
import pass.analysis.CFG;
import utils.Logger;

import java.util.ArrayList;
import java.util.HashSet;

/**
 * 对于下面的块：
 * b1:
 *    br b2;
 * 块中只有一条语句，并且是一条简单语句的块，我们需要删掉
 * 对于：
 * A/D - B - C
 * 想要删除 Simple Block：B，需要进行下面的步骤
 * 1、找到 B 的所有前驱和唯一后继。
 * 2、将所有前驱的后继 B 替换为 C，将 C 的前驱 B 替换为 B 的前驱。
 * 替换前驱后继时，可能会遇到重复的情况（就是本身就已经遇到这个前驱了），需要在再进行处理
 * 【如果有 C 前有 Phi 指令，还需要删除 B 对应的 incoming，添加 A/D 对应的 incomings，但 Value 保持不变】
 * 3、删掉 B 块
 */
public class SimpleBlockEmit implements Pass {
    private final CFG cfg = new CFG();
    private final HashSet<BasicBlock> simpleBlocks = new HashSet<>();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                emitSimpleBlock(function);
//                Logger.log(Logger.cfg(function));
            }
        }
    }

    private void emitSimpleBlock(Function function) {
        cfg.buildCFG(function);
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            if (block != function.getFirstBlock() && canEmit(block)) {
                handleEmit(block);
            }
        }
    }

    private void handleEmit(BasicBlock block) {
        HashSet<BasicBlock> precs = new HashSet<>(block.getPrecursors());
        BasicBlock succ = block.getSuccessors().iterator().next();
        for (BasicBlock prec : precs) {
            prec.replaceSuccessor(block, succ);
        }
        for (Instruction inst : succ.getInstructions()) {
            if (inst instanceof Phi phi) {
                Value value = phi.getIncomingFrom(block);
                if (value != null) {
                    phi.removeUsedBlock(block);
                    for (BasicBlock prec : precs) {
                        if (phi.getIncomingFrom(prec) != null) {
                            continue;
                        }
                        phi.addIncoming(value, prec);
                    }
                }
            }
        }
        block.replaceAllUsesWith(succ);
        block.removeSelf();
    }

    private Boolean canEmit(BasicBlock block) {
        if (!block.isSimpleBlock()) {
            return false;
        }
        HashSet<BasicBlock> precs = new HashSet<>(block.getPrecursors());
        BasicBlock target = block.getSuccessors().iterator().next();
        for (Instruction inst : target.getInstructions()) {
            if (inst instanceof Phi phi) {
                Value incoming  = phi.getIncomingFrom(block);
                // 替换前驱之后，要求不能有来自同一个块但是对应的 incoming 的值不一样
                for (BasicBlock prec : precs) {
                    Value value = phi.getIncomingFrom(prec);
                    if (value != null && value != incoming) {
                        return false;
                    }
                }
            } else {
                break;
            }
        }
        return true;
    }
}

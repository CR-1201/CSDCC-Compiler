package pass.transform.emituseless;


import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import pass.Pass;
import pass.analysis.CFG;

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
 * 3、删掉 B 块
 * 要求 C 块中没有 Phi 指令
 */
public class SimpleBlockEmit implements Pass {
    private final CFG cfg = new CFG();
    private final IrBuilder irBuilder = new IrBuilder();
    private final HashSet<BasicBlock> simpleBlocks = new HashSet<>();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                emitSimpleBlock(function);
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
            Br br = (Br) prec.getTailInstruction();
            if (br.getHasCondition()) {
                BasicBlock trueBlock = br.getTrueBlock();
                BasicBlock falseBlock = br.getFalseBlock();
                if (trueBlock == falseBlock) {
                    br.removeSelf();
                    irBuilder.buildBr(prec, trueBlock);
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
        BasicBlock target = block.getSuccessors().iterator().next();
        for (Instruction inst : target.getInstructionsArray()) {
            if (inst instanceof Phi) {
                return false;
            }
        }
        return true;
    }
}

package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.User;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashSet;

/**
 * CFG: 控制流图，是每一个函数内部的，每一个函数内都有一个CFG
 */
public class CFG implements Pass {
    private final Module module = Module.getModule();
    // 用来记录在dfs建立CFG时，标记访问过的基本块
    private HashSet<BasicBlock> visited = new HashSet<>();
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                // 针对每一个函数去新建CFG
                buildCFG(function);
                deleteUnreachableBlock(function);
            }
        }
    }

    public void buildCFG(Function function) {
        deleteCFG(function);
        BasicBlock entry = function.getFirstBlock();
        if (entry != null) {
            visited.clear();
            setCFG(entry);
        }
    }

    private void deleteCFG(Function function) {
        for (BasicBlock basicBlock : function.getBasicBlocksArray()) {
            basicBlock.getPrecursors().clear();
            basicBlock.getSuccessors().clear();
        }
    }

    private void setCFG(BasicBlock entry) {
        visited.add(entry);
        // 基本块的最后一条指令一定是终结指令
        Instruction tail = entry.getTailInstruction();
        if (tail instanceof Br br) {
            if (!br.getHasCondition()) {
                BasicBlock target = (BasicBlock) br.getOperator(0);
                entry.addSuccessor(target);
                target.addPrecursor(entry);
                if (!visited.contains(target)) {
                    setCFG(target);
                }
            } else {
                BasicBlock trueBlock = (BasicBlock) br.getOperator(1);
                entry.addSuccessor(trueBlock);
                trueBlock.addPrecursor(entry);
                if (!visited.contains(trueBlock)) {
                    setCFG(trueBlock);
                }
                BasicBlock falseBlock = (BasicBlock) br.getOperator(2);
                entry.addSuccessor(falseBlock);
                falseBlock.addPrecursor(entry);
                if (!visited.contains(falseBlock)) {
                    setCFG(falseBlock);
                }
            }
        }
    }

    public static void deleteUnreachableBlock(Function function) {
        BasicBlock entry = function.getFirstBlock();
        boolean flag = true;
        while(flag) {
            flag = false;
            ArrayList<BasicBlock> blocks = new ArrayList<>(function.getBasicBlocksArray());
            for (BasicBlock block : blocks) {
                if (block.getPrecursors().isEmpty() && block != entry) {
                    ArrayList<Phi> phis = block.getPhiUsers();
                    for (Phi phi : phis) {
                        phi.removeUsedBlock(block);
                    }
                    block.removeSelf();
                    flag = true;
                }
            }
        }
    }
}

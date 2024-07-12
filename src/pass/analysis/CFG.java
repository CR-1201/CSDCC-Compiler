package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import pass.Pass;

/**
 * CFG: 控制流图，是每一个函数内部的，每一个函数内都有一个CFG
 */
public class CFG implements Pass {
    private Module module = Module.getModule();
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                // 针对每一个函数去新建CFG
                printCFG(function);
            }
        }
    }

    private void buildCFG(Function function) {
        //
    }

    private void printCFG(Function curFunction)
    {
        for (BasicBlock basicBlock : curFunction.getBasicBlocksArray())
        {
            System.out.println("blockName: " + basicBlock.getName());
            System.out.println("pred: ");
            for (BasicBlock predecessor : basicBlock.getPrecursors())
            {
                System.out.println("\t" + predecessor.getName());
            }
            System.out.println("succ: ");
            for (BasicBlock successor : basicBlock.getSuccessors())
            {
                System.out.println("\t" + successor.getName());
            }
        }
    }
}

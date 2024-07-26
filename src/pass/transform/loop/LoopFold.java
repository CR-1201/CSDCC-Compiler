package pass.transform.loop;

import ir.BasicBlock;
import ir.Function;
import ir.IrBuilder;
import ir.Module;
import pass.Pass;
import pass.analysis.Loop;
import pass.analysis.LoopAnalysis;
import pass.analysis.LoopVarAnalysis;

/**
 * 把重复计算的循环给进行折叠
 */
public class LoopFold implements Pass {
    private final IrBuilder irBuilder = IrBuilder.getIrBuilder();
    private final LoopAnalysis loopAnalysis = new LoopAnalysis();
    private final LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {

            }
        }
    }
    private void loopFold(Function function) {
        loopAnalysis.analyzeLoopInfo(function);
        loopVarAnalysis.loopVarAnalysis(function);
        for (Loop loop : function.getTopLoops()) {
            handleFold(loop);
        }
    }
    private void handleFold(Loop loop) {
        for (Loop child : loop.getChildren()) {
            handleFold(child);
        }

    }

    private Boolean isFoldingLoop(Loop loop) {
        BasicBlock exit = null;
        if (!loop.isSimpleLoop() || !loop.getIsSetInductorVar()) {
            return false;
        }
        return null;
    }
}

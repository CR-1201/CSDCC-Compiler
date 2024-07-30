package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import pass.Pass;
import pass.analysis.Loop;
import pass.analysis.LoopAnalysis;
import pass.analysis.LoopVarAnalysis;
import utils.IOFunc;

import java.util.HashSet;

/**
 * 把重复计算的循环给进行折叠
 * while (i < n) {
 *     var = var + k; (这里的变量会进行重复的计算)
 *     i = i + 1;
 * }
 */
public class LoopFold implements Pass {
    private final IrBuilder irBuilder = IrBuilder.getIrBuilder();
    private final LoopAnalysis loopAnalysis = new LoopAnalysis();
    private final LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                loopFold(function);
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

    /**
     * 判断循环是否满足折叠的条件
     * @param loop 循环
     * @return true/false
     */
    private Boolean isFoldingLoop(Loop loop) {
        BasicBlock exit = null, latch = null;
        if (!loop.isSimpleLoop() || !loop.getIsSetInductorVar()) {
            return false;
        }
        if (!(loop.getIdcStep() instanceof ConstInt step && step.getValue() == 1)) {
            return false;
        }
        if (!(loop.getIdcInit() instanceof ConstInt init && init.getValue() == 0)) {
            return false;
        }
        exit = loop.getExits().iterator().next();
        latch = loop.getLatches().iterator().next();
        HashSet<Value> idcInsts = new HashSet<>();
        idcInsts.add(loop.getIdcVar());
        idcInsts.add(loop.getCond());
        idcInsts.add(loop.getIdcAlu());
        idcInsts.add(loop.getHeader().getTailInstruction());
        idcInsts.add(latch.getTailInstruction());
        return null;
    }
}

package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Store;
import pass.Pass;
import pass.analysis.Loop;
import pass.analysis.LoopAnalysis;

/**
 * while (i < n) {
 *     arr[i] = const;
 *     i = i + 1;
 * }
 * 还未完成
 */
public class LoopMemset implements Pass {
    private LoopAnalysis loopAnalysis = new LoopAnalysis();
    private IrBuilder irBuilder = new IrBuilder();
    private GEP gepInst = null;
    private Store storeInst = null;
    private Value loopSize;
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                loopAnalysis.analyzeLoopInfo(function);
            }
        }
    }
    private void runLoopMemset(Loop loop) {
        if (!loop.getChildren().isEmpty()) {
            for (Loop child : loop.getChildren()) {
                runLoopMemset(child);
            }
        }
        if (isMemsetableLoop(loop)) {
            BasicBlock preHeader = loop.getEnterings().iterator().next();
            Instruction br = preHeader.getTailInstruction();
            Value gepPtr = gepInst.getBase();
//            BinaryInstruction bi = irBuilder.buildMul(, loopSize.getValueType(), loopSize, new ConstInt(4));
        }
    }

    private Boolean isMemsetableLoop(Loop loop) {
        if (!(loop.isSimpleLoop() && loop.isInductorVarSet())) {
            return false;
        }
        if (!(loop.getIdcInit() instanceof ConstInt init && init.getValue() == 0)) {
            return false;
        }
        if (loop.getAllBlocks().size() != 2) {
            return false;
        }
        BasicBlock header = loop.getHeader();
        BasicBlock latch = loop.getLatches().iterator().next();
        int gepCount = 0;
        int storeCount = 0;
        for (BasicBlock block : loop.getAllBlocks()) {
            for (Instruction inst : block.getInstructions()) {
                if (inst instanceof GEP gep) {
                    gepCount++;
                    gepInst = gep;
                } else if (inst instanceof Store store) {
                    storeCount++;
                    storeInst = store;
                }
            }
        }
        if (gepCount * storeCount != 1) {
            return false;
        }
        if (!(storeInst.getValue() instanceof ConstInt storeValue)) {
            return false;
        }
        if (storeInst.getAddr() != gepInst) {
            return false;
        }
        loopSize = loop.getIdcEnd();
        return true;
    }
}

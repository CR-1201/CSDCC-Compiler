package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import pass.Pass;
import pass.analysis.Loop;
import pass.analysis.LoopAnalysis;
import pass.analysis.LoopVarAnalysis;

import java.util.HashSet;

/**
 * 把重复计算的循环给进行折叠
 */
public class LoopFold implements Pass {
    private final LoopAnalysis loopAnalysis = new LoopAnalysis();
    private final LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
    private final HashSet<Loop> loops = new HashSet<>();
    /**
     * 被折叠的 loops: foldedLoops
     */
    private final HashSet<Loop> foldedLoops = new HashSet<>();
    private final HashSet<Loop> foldingLoops = new HashSet<>();

    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                loopFold(function);
            }
        }
    }

    private void loopFold(Function function) {
        clear();
        loopAnalysis.analyzeLoopInfo(function);
        loopVarAnalysis.loopVarAnalysis(function);
        for (Loop loop : function.getAllLoops()) {
            findFoldingLoop(loop);
        }
        for (Loop loop : foldingLoops) {
            if (!foldedLoops.contains(loop)) {
                findFoldedLoop(loop);
            }
        }
        handleFold();
    }

    private void clear() {
        foldedLoops.clear();
        foldingLoops.clear();
    }

    private void handleFold() {
        for (Loop loop : foldedLoops) {
            BasicBlock entering = loop.getEnterings().iterator().next();
            BasicBlock exit = loop.getExits().iterator().next();
            if (entering.getTailInstruction() instanceof Br br) {
                int idx = br.getOperators().indexOf(loop.getHeader());
                br.setOperator(idx, exit);
                for (Instruction inst : loop.getHeader().getInstructionsArray()) {
                    if (inst instanceof Phi phi) {
                        phi.removeUsedBlock(entering);
                    } else {
                        break;
                    }
                }
            }
            loop.removeSelf();
        }
    }

    private void findFoldedLoop(Loop loop) {
        BasicBlock exit = loop.getExits().iterator().next();
//        System.out.println(exit.getName());
        if (exit.getSuccessors().size() != 1) {
            return;
        }
        BasicBlock exitSucc = exit.getSuccessors().iterator().next();
        if (!exitSucc.isLoopHeader()) {
            return;
        }
        Loop nextLoop = exitSucc.getLoop();
        if (!nextLoop.isComputeInfoSet()) {
            return;
        }
        if (nextLoop.getEnterings().size() != 1) {
            return;
        }
        if (!loop.getIdcInit().equals(nextLoop.getIdcInit()) || !loop.getIdcStep().equals(nextLoop.getIdcStep()) || !loop.getIdcEnd().equals(nextLoop.getIdcEnd())) {
            return;
        }

        if (loop.getCond().getCondition() != nextLoop.getCond().getCondition()) {
            return;
        }

        BinaryInstruction preCptAlu = (BinaryInstruction) loop.getCptAlu();
        Phi preCptPhi = (Phi) loop.getCptPhi();
        Value preCptInit = loop.getCptInit();
        int preCptIdx = loop.getAluIdx();
        BinaryInstruction nextCptAlu = (BinaryInstruction) nextLoop.getCptAlu();
        Phi nextCptPhi = (Phi) nextLoop.getCptPhi();
        Value nextCptInit = nextLoop.getCptInit();
        int nextCptIdx = nextLoop.getAluIdx();
        if (!preCptInit.equals(nextCptInit)) {
            return;
        }
        int preAluValue = ((ConstInt) preCptAlu.getOperator(preCptIdx)).getValue();
        int nextAluValue = ((ConstInt) nextCptAlu.getOperator(nextCptIdx)).getValue();
        if (!(BinaryInstruction.isSameOp(preCptAlu, nextCptAlu) && preAluValue == nextAluValue && preCptIdx == nextCptIdx)) {
            return;
        }
        nextCptPhi.replaceAllUsesWith(preCptPhi);
        foldedLoops.add(nextLoop);
    }

    private void findFoldingLoop(Loop loop) {
        loop.clearComputeInfo();
        BasicBlock latch = null, entering = null;
        BasicBlock header = loop.getHeader();
        if (!loop.getChildren().isEmpty()) {
            return;
        }
        if (!loop.isSimpleLoop() || !loop.isInductorVarSet()) {
            return;
        }
        latch = loop.getLatches().iterator().next();
        HashSet<Instruction> idcInsts = new HashSet<>();
        BinaryInstruction alu = null;
        Phi phi = null;
        int aluCount = 0;
        int phiCount = 0;
        idcInsts.add((Instruction) loop.getIdcVar());
        idcInsts.add(loop.getCond());
        idcInsts.add((Instruction) loop.getIdcAlu());
        idcInsts.add(header.getTailInstruction());
        idcInsts.add(latch.getTailInstruction());
        for (Instruction inst : idcInsts) {
            if (inst.isUsedOutside(loop)) {
                return;
            }
        }
        for (BasicBlock block : loop.getAllBlocks()) {
            for (Instruction inst : block.getInstructionsArray()) {
                if (!idcInsts.contains(inst)) {
                    if (inst instanceof BinaryInstruction bi) {
                        alu = bi;
                        aluCount++;
                    } else if (inst instanceof Phi pi) {
                        phi = pi;
                        phiCount++;
                    } else {
                        return;
                    }
                }
            }
        }
        if (aluCount * phiCount != 1) {
            return;
        }
        if (alu.isUsedOutside(loop) || !phi.isUsedOutside(loop)) {
            return;
        }
        entering = loop.getEnterings().iterator().next();
        int idx = phi.getOperators().indexOf(latch);
        if (phi.getOperator(idx - phi.getPrecursorNum()) != alu) {
            return;
        }
        if (!alu.getOperators().contains(phi)) {
            return;
        }
        int aluNumberIdx = 1 - alu.getOperators().indexOf(phi);
        if (!(alu.getOperator(aluNumberIdx) instanceof ConstInt)) {
            return;
        }
        Value aluPhiEnterValue = phi.getOperator(phi.getOperators().indexOf(entering) - phi.getPrecursorNum());
        loop.setComputeInfo(aluPhiEnterValue, alu, phi, aluNumberIdx);
        foldingLoops.add(loop);
    }
}

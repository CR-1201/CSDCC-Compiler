package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.Value;
import ir.instructions.binaryInstructions.*;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;

/**
 * 循环归纳变量分析
 */
public class LoopVarAnalysis {

    public void loopVarAnalysis(Function func) {
        for (Loop loop : func.getAllLoops()) {
            analyzeInductionVar(loop);
        }
    }
    private void analyzeInductionVar(Loop loop) {
        if (!loop.isSimpleLoop()) {
            return;
        }
        BasicBlock header = loop.getHeader();
        if (!(header.getTailInstruction() instanceof Br)) {
            return;
        }
        Br headBr = (Br) header.getTailInstruction();
        Icmp cond = (Icmp) headBr.getCond();
        Phi idcVar = null;
        Value idcEnd = null;
        Value idcAlu = null, idcInit = null;
        if(cond.getOperator(0) instanceof Phi phi) {
            idcVar = phi;
            idcEnd = cond.getOperator(1);
        }
        else if (cond.getOperator(1) instanceof Phi phi) {
            idcVar = phi;
            idcEnd = cond.getOperator(0);
        } else {
            return;
        }
        if (idcVar.getParent() != header) {
            return;
        }
        BasicBlock latch = loop.getLatches().iterator().next();
        for (BasicBlock prec : header.getPrecursors()) {
            if (prec == latch) {
                int index = idcVar.getOperators().indexOf(prec) - idcVar.getPrecursorNum();
                if (index == 0) {
                    idcAlu = idcVar.getOperator(0);
                    idcInit = idcVar.getOperator(1);
                } else {
                    idcAlu = idcVar.getOperator(1);
                    idcInit = idcVar.getOperator(0);
                }
            }
        }
        if (idcAlu instanceof BinaryInstruction alu) {
            Value idcStep = null;
            if (alu.getOperator(0) == idcVar) {
                idcStep = alu.getOperator(1);
            } else if (alu.getOperator(1) == idcVar) {
                idcStep = alu.getOperator(0);
            } else {
                return;
            }
            if (alu instanceof Add || alu instanceof Sub || alu instanceof Mul) {
                loop.setInductorVar(idcVar, idcEnd, idcInit, idcAlu, idcStep, cond);
            }
        }
    }
}

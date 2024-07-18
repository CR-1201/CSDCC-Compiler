package backend.instruction;

import backend.operand.ObjOperand;

public class ObjMove extends ObjInstruction implements hasVFP {
    private ObjOperand dst;
    private ObjOperand rhs;
    private boolean isV;

    private boolean hasImm;

    public ObjMove(ObjOperand dst, ObjOperand rhs, boolean isV, boolean hasImm) {
        this.dst = dst;
        this.rhs = rhs;
        this.isV = isV;
        this.hasImm = hasImm;
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(rhs, true);
    }
    @Override
    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        super.updateReg(oldOp, newOp, isUse);
        if (oldOp.equals(dst)) dst = newOp;
        if (oldOp.equals(rhs)) rhs = newOp;
    }
    public ObjOperand getDst() {
        return dst;
    }

    public void setDst(ObjOperand dst) {
        this.dst = dst;
    }

    public ObjOperand getRhs() {
        return rhs;
    }

    public void setRhs(ObjOperand rhs) {
        this.rhs = rhs;
    }

    public boolean isHasImm() {
        return hasImm;
    }

    @Override
    public String toString()
    {
        if (isV)
            return "\tvmov" + getCond() + (hasImm ? ".f32" : "") + "\t" + dst + ",\t" + rhs + "\n";
        else
            return "\tmov" + (hasImm ? "32" : "") + getCond()  + "\t" + dst + ",\t" + rhs + "\n";

    }

    @Override
    public boolean isVFP() {
        return isV;
    }
}

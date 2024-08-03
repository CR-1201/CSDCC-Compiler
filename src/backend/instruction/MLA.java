package backend.instruction;

import backend.operand.ObjOperand;

public class MLA extends ObjInstruction{
    private ObjOperand dst;
    private ObjOperand lhs;
    private ObjOperand mhs;
    private ObjOperand rhs;

    public MLA(ObjOperand dst, ObjOperand lhs, ObjOperand mhs, ObjOperand rhs) {
        this.dst = dst;
        this.lhs = lhs;
        this.mhs = mhs;
        this.rhs = rhs;
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(lhs, true);
        tryAddUseOrDefReg(mhs, true);
        tryAddUseOrDefReg(rhs, true);
    }

    @Override
    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        super.updateReg(oldOp, newOp, isUse);
        if (oldOp.equals(dst)) dst = newOp;
        if (oldOp.equals(lhs)) lhs = newOp;
        if (oldOp.equals(rhs)) rhs = newOp;
        if (oldOp.equals(mhs)) mhs = newOp;
    }

    public ObjOperand getDst() {
        return dst;
    }

    public void setDst(ObjOperand dst) {
        this.dst = dst;
    }

    public ObjOperand getLhs() {
        return lhs;
    }

    public void setLhs(ObjOperand lhs) {
        this.lhs = lhs;
    }

    public ObjOperand getMhs() {
        return mhs;
    }

    public void setMhs(ObjOperand mhs) {
        this.mhs = mhs;
    }

    public ObjOperand getRhs() {
        return rhs;
    }

    public void setRhs(ObjOperand rhs) {
        this.rhs = rhs;
    }

    @Override
    public String toString() {
        return "\tmla" + getCond() + "\t" + dst + ",\t" +
                lhs + ",\t" + mhs + ",\t" + rhs + "\n";
    }
}

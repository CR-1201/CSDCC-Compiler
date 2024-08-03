package backend.instruction;

import backend.operand.ObjOperand;

public class ObjCompare extends ObjInstruction implements hasVFP{
    private ObjOperand lhs;
    private ObjOperand rhs;
    private boolean isV;

    public ObjCompare(ObjOperand lhs, ObjOperand rhs) {
        this.lhs = lhs;
        this.rhs = rhs;
        tryAddUseOrDefReg(lhs, true);
        tryAddUseOrDefReg(rhs, true);
    }

    public ObjCompare(ObjOperand lhs, ObjOperand rhs, boolean isV) {
        this.lhs = lhs;
        this.rhs = rhs;
        this.isV = isV;
        tryAddUseOrDefReg(lhs, true);
        tryAddUseOrDefReg(rhs, true);
    }
    @Override
    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        super.updateReg(oldOp, newOp, isUse);
        if (oldOp.equals(lhs)) lhs = newOp;
        if (oldOp.equals(rhs)) rhs = newOp;
    }

    public ObjOperand getLhs() {
        return lhs;
    }

    public void setLhs(ObjOperand lhs) {
        this.lhs = lhs;
    }

    public ObjOperand getRhs() {
        return rhs;
    }

    public void setRhs(ObjOperand rhs) {
        this.rhs = rhs;
    }

    public String toString() {
        if (isV)
            return "\tvcmp.f32\t" + lhs + ",\t" + (rhs == null ? "0.0" : rhs)  + "\n" +
                    "\tvmrs\tAPSR_nzcv, fpscr\n";
        return  "\tcmp\t" + lhs + ",\t" + rhs + "\n";
    }

    @Override
    public boolean isVFP() {
        return isV;
    }
}

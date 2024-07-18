package backend.instruction;

import backend.operand.ObjLabel;
import backend.operand.ObjOperand;
import backend.operand.ObjRegister;

public class ObjLoad extends ObjInstruction implements hasVFP {
    private ObjOperand dst;
    private ObjOperand add;

    private ObjLabel label;
    private ObjOperand off;
    boolean isV = false;

    public ObjLoad(ObjOperand dst, ObjOperand add, ObjOperand off, boolean isV) {
        this.dst = dst;
        this.add = add;
        this.off = off;
        this.isV = isV;
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(add, true);
        tryAddUseOrDefReg(off, true);
    }

    public ObjLoad(ObjOperand dst, ObjLabel label, boolean isV) {    // label
        this.dst = dst;
        this.label = label;
        this.isV = isV;
    }
    @Override
    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        super.updateReg(oldOp, newOp, isUse);
        if (oldOp.equals(dst)) dst = newOp;
        if (oldOp.equals(add)) add = newOp;
        if (oldOp.equals(off)) off = newOp;
    }
    public ObjOperand getDst() {
        return dst;
    }

    public void setDst(ObjOperand dst) {
        this.dst = dst;
    }

    public ObjOperand getAdd() {
        return add;
    }

    public void setAdd(ObjOperand add) {
        this.add = add;
    }

    public ObjOperand getOff() {
        return off;
    }

    public void setOff(ObjOperand off) {
        this.off = off;
    }

    @Override
    public String toString() {
        if (label != null) {
            return "\t" + (isV ? "v" : "") + "ldr" + getCond() + "\t" +
                    dst + ",\t" + label + "\n";
        } else if (off == null) {
            return "\t" + (isV ? "v" : "") + "ldr" + getCond() + "\t" +
                    dst + ",\t[" + add + "]\n";
        } else {
            return "\t" + (isV ? "v" : "") + "ldr" + getCond() + "\t" +
                    dst + ",\t[" + add + ",\t" + off + "]\n";
        }
    }

    @Override
    public boolean isVFP() {
        return isV;
    }
}

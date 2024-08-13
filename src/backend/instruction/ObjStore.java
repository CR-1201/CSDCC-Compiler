package backend.instruction;

import backend.operand.ObjOperand;

public class ObjStore extends ObjInstruction implements hasVFP {
    private ObjOperand add;
    private ObjOperand off;
    private ObjOperand src;

    private boolean isV;

    public ObjStore(ObjOperand add, ObjOperand src, ObjOperand off,boolean isV) {
        this.add = add;
        this.off = off;
        this.src = src;
        this.isV = isV;
        tryAddUseOrDefReg(add, true);
        tryAddUseOrDefReg(src, true);
        tryAddUseOrDefReg(off, true);
    }

    public ObjStore(ObjOperand add, ObjOperand src, boolean isV) {
        this.add = add;
        this.src = src;
        this.isV = isV;
        tryAddUseOrDefReg(add, true);
        tryAddUseOrDefReg(src, true);
    }
    @Override
    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        super.updateReg(oldOp, newOp, isUse);
        if (oldOp.equals(add)) add = newOp;
        if (oldOp.equals(src)) src = newOp;
        if (oldOp.equals(off)) off = newOp;
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

    public ObjOperand getSrc() {
        return src;
    }

    public void setSrc(ObjOperand src) {
        this.src = src;
    }

    @Override
    public String toString() {
        if (off != null)
            return "\t" + (isV ? "v" : "") + "str" + getCond() + "\t" + src
                + ",\t[" + add + ",\t" + off + "]\n";
        return "\t" + (isV ? "v" : "") + "str" + getCond() + "\t" + src
                + ",\t[" + add + "]\n";
    }

    @Override
    public boolean isVFP() {
        return isV;
    }
}

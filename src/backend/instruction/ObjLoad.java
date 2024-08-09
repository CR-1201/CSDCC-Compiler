package backend.instruction;

import backend.operand.ObjImmediate;
import backend.operand.ObjLabel;
import backend.operand.ObjOperand;
import backend.operand.ObjRegister;

public class ObjLoad extends ObjInstruction implements hasVFP {
    private ObjOperand dst;
    private ObjOperand add;

    private ObjOperand off;
    boolean isV = false;

    private ObjMove immMove;

    public ObjLoad(ObjOperand dst, ObjOperand add, ObjOperand off, boolean isV) {
        this.dst = dst;
        this.add = add;
        this.off = off;
        this.isV = isV;
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(add, true);
        tryAddUseOrDefReg(off, true);
    }

    public ObjLoad(ObjOperand dst, ObjOperand add, ObjOperand off, boolean isV, ObjMove immMove) {
        this.dst = dst;
        this.add = add;
        this.off = off;
        this.isV = isV;
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(add, true);
        tryAddUseOrDefReg(off, true);
        this.immMove = immMove;
    }

    public ObjLoad(ObjOperand dst, ObjOperand add, boolean isV) {    // label
        this.dst = dst;
        this.add = add;
        this.isV = isV;
        this.off = new ObjImmediate(0);
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(add, true);
    }

    public ObjMove getImmMove() {
        return immMove;
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

    public void replaceOff(ObjOperand off) {
        getUse().remove(this.off);
        addUse((ObjRegister) off);
        this.off = off;
    }
    public void replaceAdd(ObjOperand add) {
        getUse().remove(this.add);
        addUse((ObjRegister) add);
        this.add = add;
    }

    @Override
    public String toString() {
        if (off instanceof ObjImmediate imm && imm.getImmediate() == 0) {
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

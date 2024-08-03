package backend.instruction;

import backend.operand.ObjOperand;
import backend.operand.ObjRegister;

public class VLoad extends ObjInstruction {
    private ObjOperand dst;
    private ObjOperand add;
    private ObjOperand off;

    public VLoad(ObjOperand dst, ObjOperand add, ObjOperand off) {
        this.dst = dst;
        this.add = add;
        this.off = off;
    }

    public VLoad(ObjOperand dst, ObjOperand add) {  // label
        this.dst = dst;
        this.add = add;
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
        if (off == null) {
            return "\tvldr" + getCond() + "\t" +
                    dst + ",\t" + add + "\n";
        } else {
            return "\tvldr" + getCond() + "\t" + dst +
                    ",\t[" + add + ",\t" + off + "]\n";
        }
    }
}

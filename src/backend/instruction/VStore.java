package backend.instruction;

import backend.operand.ObjOperand;

public class VStore extends ObjInstruction{
    private ObjOperand add;
    private ObjOperand off;
    private ObjOperand src;

    public VStore(ObjOperand add, ObjOperand off, ObjOperand src) {
        this.add = add;
        this.off = off;
        this.src = src;
    }

    public ObjOperand getAddress() {
        return add;
    }

    public void setAddress(ObjOperand add) {
        this.add = add;
    }

    public ObjOperand getOffset() {
        return off;
    }

    public void setOffset(ObjOperand off) {
        this.off = off;
    }

    public ObjOperand getSrcData() {
        return src;
    }

    public void setSrcData(ObjOperand src) {
        this.src = src;
    }

    @Override
    public String toString() {
        return "\tvstr" + getCond() + "\t" + src + ",\t[" + add +
                ",\t" + off + "]\n";
    }
}

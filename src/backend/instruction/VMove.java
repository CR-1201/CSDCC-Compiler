package backend.instruction;

import backend.operand.ObjOperand;

public class VMove extends ObjInstruction{

    ObjOperand dst;
    ObjOperand src;

    public VMove(ObjOperand dst, ObjOperand src) {
        this.dst = dst;
        this.src = src;
    }

    public ObjOperand getDst() {
        return dst;
    }

    public void setDst(ObjOperand dst) {
        this.dst = dst;
    }

    public ObjOperand getSrc() {
        return src;
    }

    public void setSrc(ObjOperand src) {
        this.src = src;
    }

    @Override
    public String toString() {
        /*
         * 可编码浮点立即数->s0
         * r0->s0
         * s0->r0
         *
         * */
        return "\tvmov" + getCond() + "\t" + dst + ",\t" + src + "\n";
    }
}

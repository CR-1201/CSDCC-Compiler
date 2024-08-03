package backend.instruction;

import backend.operand.ObjOperand;

public class VCompare extends ObjInstruction{
    private ObjOperand lS;
    private ObjOperand rS;

    public VCompare(ObjOperand lS, ObjOperand rS) {
        this.lS = lS;
        this.rS = rS;
    }

    public ObjOperand getlS() {
        return lS;
    }

    public void setlS(ObjOperand lS) {
        this.lS = lS;
    }

    public ObjOperand getrS() {
        return rS;
    }

    public void setrS(ObjOperand rS) {
        this.rS = rS;
    }

    @Override
    public String toString() {
        return "\tvcmp.f32\t" + lS + ",\t" + (rS == null ? "0.0" : rS)  + "\n" +
                "\tvmrs\tAPSR_nzcv, fpscr\n";
    }
}

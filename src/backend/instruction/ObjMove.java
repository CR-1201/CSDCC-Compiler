package backend.instruction;

import backend.Utils.ImmediateUtils;
import backend.operand.ObjFloatImmediate;
import backend.operand.ObjImmediate;
import backend.operand.ObjLabel;
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
    public String toString() {
        // vmov.f32 好像很多不支持
        if (isV) {
            if (hasImm) {
                int bits = Float.floatToIntBits(((ObjFloatImmediate) rhs).getImmediate());
                String hex = "0x" + Integer.toHexString(bits).toUpperCase();
                return "\tvldr" + getCond() + "\t" + dst + ",\t=" + hex + "\n";
            } else
                return "\tvmov" + getCond() + "\t" + dst + ",\t" + rhs + "\n";
        } else {
            if (hasImm) {
                int imm = ((ObjImmediate) getRhs()).getImmediate();
                if (ImmediateUtils.checkEncodeImm(~imm)) {
                    return "\tmvn" + getCond() + "\t" + dst + ",\t" + rhs + "\n";
                } else if (ImmediateUtils.checkEncodeImm(imm)) {
                    return "\tmov" + getCond() + "\t" + dst + ",\t" + rhs + "\n";
                } else {
                    final var high = imm >>> 16;
                    final var low = (imm << 16) >>> 16;
                    String ret = "\tmovw" + getCond() + "\t" + dst + ",\t#" + low + "\n";
                    if (high != 0) {
                        ret += "\tmovt" + getCond() + "\t" + dst + ",\t#" + high + "\n";
                    }
                    return ret;
                }
            } else if (rhs instanceof ObjLabel)
                return "\tmovw" + getCond() + "\t" + dst + ",\t:lower16:" + rhs + "\n" +
                        "\tmovt" + getCond() + "\t" + dst + ",\t:upper16:" + rhs + "\n";
            return "\tmov" + getCond() + "\t" + dst + ",\t" + rhs + "\n";

        }

    }
    public boolean hasLabel() {
        return rhs instanceof ObjLabel;
    }
    @Override
    public boolean isVFP() {
        return isV;
    }


}

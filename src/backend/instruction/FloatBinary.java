package backend.instruction;

import backend.operand.ObjOperand;
import ir.instructions.binaryInstructions.*;

public class FloatBinary extends ObjInstruction {

    public enum FloatBinaryType {
        VADD("vadd"),
        VSUB("vsub"),
        VMUL("vmul"),
        VDIV("vdiv"),
        VMOD("vmod"),
        NONE("none");

        public String name;

        FloatBinaryType(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }

        @Override
        public String toString() {
            return name;
        }
        public static FloatBinaryType switchIrToObj(BinaryInstruction binaryInstruction) {
            if (binaryInstruction instanceof Add) {
                return FloatBinaryType.VADD;
            } else if (binaryInstruction instanceof Sub) {
                return FloatBinaryType.VSUB;
            } else if (binaryInstruction instanceof Mul) {
                return FloatBinaryType.VMUL;
            } else if (binaryInstruction instanceof Sdiv) {
                return FloatBinaryType.VDIV;
            } else if (binaryInstruction instanceof Srem) {
                return FloatBinaryType.VMOD;
            } return FloatBinaryType.NONE;
        }
    }

    private ObjOperand dst;

    private ObjOperand lhs;
    private ObjOperand rhs;
    private FloatBinaryType type;

    public FloatBinary(ObjOperand dst, ObjOperand lhs, ObjOperand rhs, FloatBinaryType type) {
        this.dst = dst;
        this.lhs = lhs;
        this.rhs = rhs;
        this.type = type;
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(lhs, true);
        tryAddUseOrDefReg(rhs, true);
    }
    @Override
    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        super.updateReg(oldOp, newOp, isUse);
        if (oldOp.equals(dst)) dst = newOp;
        if (oldOp.equals(lhs)) lhs = newOp;
        if (oldOp.equals(rhs)) rhs = newOp;
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

    public ObjOperand getRhs() {
        return rhs;
    }

    public void setRhs(ObjOperand rhs) {
        this.rhs = rhs;
    }

    public FloatBinaryType getType() {
        return type;
    }

    public void setType(FloatBinaryType type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "\t" + type + getCond() + ".f32\t" + dst + ",\t" + lhs + ",\t" + rhs + "\n";
    }

}

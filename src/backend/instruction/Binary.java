package backend.instruction;

import backend.operand.ObjOperand;
import ir.instructions.binaryInstructions.*;

public class Binary extends ObjInstruction {
    public enum BinaryType {
        add("add"),
        sub("sub"),
        rsb("rsb"),
        mul("mul"),
        sdiv("sdiv"),
        and("and"),
        or("orr"),
        asr("asr"),
        sl("lsl"),
        lsr("lsr"),
        nothing("nothing");

        public String name;

        BinaryType(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }

        @Override
        public String toString() {
            return name;
        }

        public static BinaryType switchIrToObj(BinaryInstruction binaryInstruction) {
            if (binaryInstruction instanceof Add) {
                return BinaryType.add;
            } else if (binaryInstruction instanceof Sub) {
                return BinaryType.sub;
            } else if (binaryInstruction instanceof Mul) {
                return BinaryType.mul;
            } else if (binaryInstruction instanceof Sdiv) {
                return BinaryType.sdiv;
            }
            return BinaryType.nothing;
        }
    }

    private ObjOperand dst;
    private ObjOperand lhs;
    private ObjOperand rhs;
    private BinaryType type;


    public Binary(ObjOperand dst, ObjOperand lhs, ObjOperand rhs, BinaryType type) {
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

    public BinaryType getType() {
        return type;
    }

    public void setType(BinaryType type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "\t" + getType().toString() + getCond() + "\t" + dst + ",\t" +
                lhs + ",\t" + rhs + getShift() + "\n";
    }
}

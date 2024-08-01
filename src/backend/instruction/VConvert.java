package backend.instruction;

import backend.operand.ObjOperand;


/**
 * VCVT{cond}.F32.S32 Sd, Dm
 *  后面的寄存器（存i32）转 浮点数 存入Sd
 * */
public class VConvert extends ObjInstruction{
    public enum vcvtType {
        s("s"),
        f("f");
        private String name;
        vcvtType(String name) {
            this.name = name;
        }
        public String getName() {
            return name;
        }
    }
    private vcvtType fromType;
    private vcvtType toType;
    private ObjOperand src;
    private ObjOperand dst;

    public VConvert(vcvtType fromType, vcvtType toType, ObjOperand src, ObjOperand dst) {
        this.fromType = fromType;
        this.toType = toType;
        this.src = src;
        this.dst = dst;
        tryAddUseOrDefReg(dst, false);
        tryAddUseOrDefReg(src, true);
    }
    @Override
    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        super.updateReg(oldOp, newOp, isUse);
        if (oldOp.equals(dst)) dst = newOp;
        if (oldOp.equals(src)) src = newOp;
    }
    @Override
    public String toString() {
        return "\tvcvt." + toType.getName() + "32." + fromType.getName() +
                "32\t" + dst + ",\t" + src + "\n";
    }
}

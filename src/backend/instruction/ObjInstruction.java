package backend.instruction;

import backend.module.ObjBlock;
import backend.operand.ObjFloatImmediate;
import backend.operand.ObjOperand;
import backend.operand.ObjRegister;
import ir.instructions.binaryInstructions.Icmp;

import java.util.Collection;
import java.util.HashSet;

public class ObjInstruction {
    public HashSet<ObjRegister> getRegs() {
        HashSet<ObjRegister> regs = new HashSet<>(def);
        regs.addAll(use);
        return regs;
    }

    public boolean needLtorg() {
        return this instanceof ObjMove && ((ObjMove)this).getRhs() instanceof ObjFloatImmediate;
    }

    public boolean haveLtorg() {
        return  (this instanceof ObjJump && getCond().equals(ObjCond.any))
                || (this instanceof LiteralPoolPlacement);
    }


    public enum ObjCond {
        any(""), // 无条件执行
        noway(""), // 一定不执行, 仅仅做个标记
        eq("eq"),  // ==
        ne("ne"),  // !=
        slt("lt"),  // <  s->signed 有符号
        sle("le"),  // <=
        sgt("gt"),  // >
        sge("ge");   // >=

        public String name;

        ObjCond(String name) {
            this.name = name;
        }

        public static ObjCond switchIr2ObjOpp(Icmp.Condition cond) {
            switch (cond) {
//                EQ, LE, LT, GE, GT, NE;
                case EQ:
                    return ObjCond.ne;
                case NE:
                    return ObjCond.eq;
                case LT:
                    return ObjCond.sge;
                case LE:
                    return ObjCond.sgt;
                case GT:
                    return ObjCond.sle;
                case GE:
                    return ObjCond.slt;
                default:
                    return ObjCond.any;
            }
        }

        public String getName() {
            return name;
        }


        @Override
        public String toString() {
            return name;
        }

        public static ObjCond switchIr2Obj(Icmp.Condition cond) {
            switch (cond) {
//                EQ, LE, LT, GE, GT, NE;
                case EQ:
                    return ObjCond.eq;
                case NE:
                    return ObjCond.ne;
                case LT:
                    return ObjCond.slt;
                case LE:
                    return ObjCond.sle;
                case GT:
                    return ObjCond.sgt;
                case GE:
                    return ObjCond.sge;
                default:
                    return ObjCond.any;
            }
        }
    }

    private String name;
    private ObjCond cond;

    private Shift shift;

    private HashSet<ObjRegister> def = new HashSet<>();
    private HashSet<ObjRegister> use = new HashSet<>();

    public void addDef(ObjRegister objRegister) {
        if (objRegister != null)
            def.add(objRegister);
    }

    public void addUse(ObjRegister objRegister) {
        if (objRegister != null)
            use.add(objRegister);
    }

    public void tryAddUseOrDefReg(ObjOperand op, boolean isUse) {
        if (op instanceof ObjRegister) {
            if (isUse) {
                addUse((ObjRegister) op);
            } else {
                addDef((ObjRegister) op);
            }
        }
    }

    public void updateReg(ObjOperand oldOp, ObjOperand newOp, boolean isUse) {
        if (oldOp == null) {
            // 对象刚 new出来的时候调构造函数
            tryAddUseOrDefReg(newOp, isUse);
            return;
        }
        if (oldOp instanceof ObjRegister) { // old是寄存器的话, 在add之前要先将旧的remove
            if (isUse) {
                use.remove((ObjRegister) oldOp);
            } else {
                def.remove((ObjRegister) oldOp);
            }
        }
        tryAddUseOrDefReg(newOp, isUse); // remove掉之后仍然要加新的
    }

    public HashSet<ObjRegister> getDef() {
        return def;
    }

    public HashSet<ObjRegister> getUse() {
        return use;
    }

    public String getShift() {
        return shift != null ? shift.toString() : "";
    }

    public void setShift(Shift shift) {
        this.shift = shift;
    }

    public ObjInstruction(ObjCond cond) {
        this.cond = cond;
    }

    public ObjInstruction() {
        this.cond = ObjCond.any;
    }

    public ObjCond getCond() {
        return cond != null ? cond : ObjCond.any;
    }

    public void setCond(ObjCond cond) {
        this.cond = cond;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}

package ir.instructions.binaryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.FloatType;
import ir.types.IntType;

/**
 @author Conroy
 <result> = icmp <cond> <ty> <op1>, <op2>
 */
public class Icmp extends BinaryInstruction {
    /**
     * @param condition 判断类型
     * @param op1       第一个操作数
     * @param op2       第二个操作数
     */
    public Icmp(int nameNum, BasicBlock parent, Condition condition, Value op1, Value op2){
        super(nameNum, new IntType(1), parent, op1, op2);
        this.condition = condition;
    }

    public enum Condition{
        EQ, LE, LT, GE, GT, NE;
    }

    // icmp 的类型
    private final Condition condition;

    public Condition getCondition(){
        return condition;
    }

    private String getConditionString(boolean flag,Condition condition){
        if( flag ){
            return switch (condition) {
                case EQ -> "oeq";
                case GE -> "oge";
                case GT -> "ogt";
                case LE -> "ole";
                case LT -> "olt";
                default -> "one";
            };
        } else {
            return switch (condition) {
                case EQ -> "eq";
                case GE -> "sge";
                case GT -> "sgt";
                case LE -> "sle";
                case LT -> "slt";
                default -> "ne";
            };
        }
    }

    @Override
    public boolean isCommutative(){
        // 只有等于和不等于才能交换操作数
        return condition.equals(Condition.NE) || condition.equals(Condition.EQ);
    }

    @Override
    public String toString(){
        boolean flag = (getValue(0).getValueType() instanceof FloatType);
        return getName() + " = "+ ( flag ? "f" : "i") +  "cmp " + getConditionString(flag,condition) + " " +
                getValue(0).getValueType() + " " + getValue(0).getName() + ", " + getValue(1).getName();
    }
}

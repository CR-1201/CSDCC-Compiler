package ir.instructions.binaryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.FloatType;
import ir.types.IntType;

/**
 @author Conroy
 */
public class Icmp extends BinaryInstruction {

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

    public String getConditionString(boolean flag,Condition condition){
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

    public String getOpString() {
        boolean flag = (getOperator(0).getValueType() instanceof FloatType);
        return getConditionString(flag, condition);
    }

    @Override
    public String toString(){
        boolean flag = (getOperator(0).getValueType() instanceof FloatType);
        return getName() + " = "+ ( flag ? "f" : "i") +  "cmp " + getConditionString(flag,condition) + " " +
                getOperator(0).getValueType() + " " + getOperator(0).getName() + ", " + getOperator(1).getName();
    }
}

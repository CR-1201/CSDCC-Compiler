package ir.instructions.binaryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.DataType;

/**
 @author Conroy
 <result> = srem <ty> <op1>, <op2>
 */
public class Srem extends BinaryInstruction{
    // 只有 op1 && op2 都为 IntType 时, Srem 的 dataType 为 IntType;
    // 否则在调用 Srem 建立函数之前就应该保证 op1 和 op2 都是 FloatType
    public Srem(int nameNum, DataType dataType, BasicBlock parent, Value op1, Value op2){
        super(nameNum, dataType, parent, op1, op2);
    }

    @Override
    public boolean isCommutative(){
        return false;
    }

    @Override
    public String toString(){
        return getName() + " = srem " + getValueType() + " " + getOperator(0).getName() + ", " + getOperator(1).getName();
    }
}

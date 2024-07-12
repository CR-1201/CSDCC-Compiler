package ir.instructions.binaryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.DataType;
import ir.types.FloatType;

/**
 @author Conroy
 <result> = add <ty> <op1>, <op2>
 */
public class Add extends BinaryInstruction{
    // 只有 op1 && op2 都为 IntType 时, Add 的 dataType 为 IntType;
    // 否则在调用 Add 建立函数之前就应该保证 op1 和 op2 都是 FloatType
    public Add(int nameNum, DataType dataType, BasicBlock parent, Value op1, Value op2){
        super(nameNum, dataType, parent, op1, op2);
    }

    @Override
    public boolean isCommutative(){
        return true;
    }

    @Override
    public String toString(){
        return getName() + " = "+ ((getValueType() instanceof FloatType) ? "f" : "") +  "add " + getValueType() + " " + getValue(0).getName() + ", " + getValue(1).getName();
    }
}

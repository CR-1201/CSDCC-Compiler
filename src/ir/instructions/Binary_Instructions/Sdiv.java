package ir.instructions.Binary_Instructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.DataType;
import ir.types.IntType;

/**
 @author Conroy
 <result> = sdiv <ty> <op1>, <op2>
 */
public class Sdiv extends BinaryInstruction {
    // 只有 op1 && op2 都为 IntType 时, Sdiv 的 dataType 为 IntType;
    // 否则在调用 Sdiv 建立函数之前就应该保证 op1 和 op2 都是 FloatType
    public Sdiv(int nameNum, DataType dataType, BasicBlock parent, Value op1, Value op2){
        super(nameNum, dataType, parent, op1, op2);
    }

    @Override
    public boolean isCommutative(){
        return false;
    }

    @Override
    public String toString(){
        return getName() + " = sdiv " + getValueType() + " " + getValue(0).getName() + ", " + getValue(1).getName();
    }
}

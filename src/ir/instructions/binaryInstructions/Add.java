package ir.instructions.binaryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.DataType;
import ir.types.FloatType;

/**
 @author Conroy
 */
public class Add extends BinaryInstruction{
    public Add(int nameNum, DataType dataType, BasicBlock parent, Value op1, Value op2){
        super(nameNum, dataType, parent, op1, op2);
    }

    @Override
    public boolean isCommutative(){
        return true;
    }
    public String getOpString() {
        return ((getValueType() instanceof FloatType) ? "f" : "") +  "add";
    }
    @Override
    public String toString(){
        return getName() + " = "+ ((getValueType() instanceof FloatType) ? "f" : "") +  "add " + getValueType() + " " + getOperator(0).getName() + ", " + getOperator(1).getName();
    }
}

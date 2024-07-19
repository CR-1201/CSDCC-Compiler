package ir.instructions.otherInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;

/**
 @author Conroy
 <result> = bitcast <ty> <value> to <ty2>
 %2 = bitcast float* %1 to i32*
 */
public class BitCast extends Instruction {
    private Value value;
    /**
     * @param parent 基本块
     * @param dataType  ty2
     * @param value  被转变的值
     */
    public BitCast(int nameNum, DataType dataType, BasicBlock parent, Value value){
        super("%v" + nameNum, dataType, parent, new ArrayList<>(){{
            add(value);
        }});
        this.value = value;
    }

    public Value getConversionValue(){
        return getOperator(0);
    }



    @Override
    public String toString(){
        return this.getName() + " = bitcast "+ value.getValueType()+ " " + getOperator(0).getName() + " to " + getValueType();
    }
}

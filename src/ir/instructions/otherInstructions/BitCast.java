package ir.instructions.otherInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;

/**
 @author Conroy
 */
public class BitCast extends Instruction {
    private Value value;
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

    public String getHashNumbering() {
        return "bitcast "+ value.getValueType()+ " " + getOperator(0).getName() + " to " + getValueType();
    }
}

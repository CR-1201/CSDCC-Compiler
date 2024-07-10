package ir.instructions.Other_Instructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;
/**
 @author Conroy
 <result> = fptosi <ty> <value> to <ty2>
 %7 = fptosi float %6 to i32
 <result> = sitofp <ty> <value> to <ty2>
 %7 = sitofp i32 %6 to float
 */
public class Conversion extends Instruction {
    private String type;
    /**
     * @param parent 基本块
     * @param value  被转变的值
     */
    public Conversion(int nameNum, String type, DataType dataType, BasicBlock parent, Value value){
        super("%v" + nameNum, dataType, parent, new ArrayList<>(){{
            add(value);
        }});
        this.type = type;
    }

    public Value getConversionValue(){
        return getValue(0);
    }

    @Override
    public String toString(){
        if(this.type.equals("fptosi")){
            return this.getName() + " = fptosi float " + getValue(0).getName() + " to i32";
        } else {
            return this.getName() + " = sitofp i32 " + getValue(0).getName() + " to float";
        }
    }
}

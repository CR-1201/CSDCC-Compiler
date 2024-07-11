package ir.instructions.Other_Instructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.IntType;

import java.util.ArrayList;

/**
 @author Conroy
 <result> = zext <ty> <value> to <ty2>
 %7 = zext i1 %6 to i32
 */
public class Zext extends Instruction {
    /**
     * @param parent 基本块
     * @param value  被转变的值
     */
    public Zext(int nameNum, BasicBlock parent, Value value){
        super("%v" + nameNum, new IntType(32), parent, new ArrayList<>(){{
            add(value);
        }});
    }

    public Value getConversionValue(){
        return getValue(0);
    }

    @Override
    public String toString(){
        return this.getName() + " = zext i1 " + getValue(0).getName() + " to i32";
    }
}

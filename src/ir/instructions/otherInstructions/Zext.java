package ir.instructions.otherInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.IntType;

import java.util.ArrayList;

/**
 @author Conroy
 */
public class Zext extends Instruction {

    public Zext(int nameNum, BasicBlock parent, Value value){
        super("%v" + nameNum, new IntType(32), parent, new ArrayList<>(){{
            add(value);
        }});
    }

    public Value getConversionValue(){
        return getOperator(0);
    }

    @Override
    public String toString(){
        return this.getName() + " = zext i1 " + getOperator(0).getName() + " to i32";
    }

    public String getHashNumbering(){
        return "zext i1 " + getOperator(0).getName() + " to i32";
    }
}

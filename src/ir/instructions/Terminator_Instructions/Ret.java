package ir.instructions.Terminator_Instructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.DataType;
import ir.types.VoidType;

import java.util.ArrayList;

/**
 @author Conroy
 ret <type> <value> ,ret void
 */
public class Ret extends TerInstruction{
    // 返回值为void
    public Ret(BasicBlock parent){
        super(new VoidType(), parent, new ArrayList<>());
    }


    // 返回值不为void,返回值为 FloatType 或 IntType
    public Ret(BasicBlock parent, Value retValue){
        super((DataType) retValue.getValueType(), parent, new ArrayList<>(){{
            add(retValue);
        }});
    }

    public Value getRetValue(){
        if (getValueType() instanceof VoidType){
            return null;
        }else return getValue(0);
    }

    @Override
    public String toString(){
        if (getValueType() instanceof VoidType){
            return "ret void";
        }else{
            return "ret " + getValue(0).getValueType() + " " + getValue(0).getName();
        }
    }
}

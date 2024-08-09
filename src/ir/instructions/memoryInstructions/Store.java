package ir.instructions.memoryInstructions;

import com.sun.jdi.IntegerType;
import ir.BasicBlock;
import ir.Value;
import ir.types.FloatType;
import ir.types.IntType;
import ir.types.PointerType;
import ir.types.VoidType;

import java.util.ArrayList;

/**
 @author Conroy
 */
public class Store extends MemoryInstruction{

    public Store(BasicBlock parent, Value value, Value addr){
        super("", new VoidType(), parent, new ArrayList<>(){{
            add(value);add(addr);
        }});
    }

    public Value getValue(){
        return getOperator(0);
    }

    public Value getAddr(){
        return getOperator(1);
    }

    @Override
    public String toString(){
        return "store " + getOperator(0).getValueType() + " " + getOperator(0).getName() + ", " +
                getOperator(1).getValueType() + " " + getOperator(1).getName();
    }
}

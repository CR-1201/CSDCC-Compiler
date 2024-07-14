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
 store <ty> <value>, <ty>* <pointer>
 */
public class Store extends MemoryInstruction{
    /**
     * 因为 Store 没有返回值,所以连名字也不配拥有
     * @param value     第一个操作数,写入内存的值,valueType 为 IntType 或 FloatType
     * @param addr      第二个操作数,写入内存的地址,valueType 为 PointerType,只能指向 IntType 或 FloatType 或 PointerType
     */
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

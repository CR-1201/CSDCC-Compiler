package ir.instructions.memoryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.DataType;
import ir.types.PointerType;

import java.util.ArrayList;

/**
 @author Conroy
 <result> = load <ty>, <ty>* <pointer>
 */
public class Load extends MemoryInstruction{
    // 从内存中取出来的值类型,只能为 PointerType、IntType 或 FloatType
    private final DataType dataType;

    /**
     * @param addr 唯一的操作数,内存地址,其 ValueType 为 PointerType,
     *             只能指向 IntType 或 FloatType 或 PointerType
     */
    public Load(int nameNum, BasicBlock parent, Value addr){
        super("%v" + nameNum, (DataType) ((PointerType) addr.getValueType()).getPointeeType(), parent, new ArrayList<>() {{
            add(addr);
        }});
        this.dataType = (DataType) ((PointerType) addr.getValueType()).getPointeeType();
    }

    public Value getAddr(){
        return getOperator(0);
    }

    @Override
    public String toString(){
        return getName() + " = load " + getValueType() + ", " + getOperator(0).getValueType() + " " + getOperator(0).getName();
    }

    public String getHashNumbering(){
        return "load " + getValueType() + ", " + getOperator(0).getValueType() + " " + getOperator(0).getName();
    }
}

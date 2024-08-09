package ir.instructions.memoryInstructions;

import ir.BasicBlock;
import ir.User;
import ir.Value;
import ir.constants.ConstArray;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.types.ArrayType;
import ir.types.PointerType;
import ir.types.ValueType;

import java.util.ArrayList;

/**
 @author Conroy
 */
public class Alloca extends MemoryInstruction{
    private final ConstArray initVal;

    ArrayList<Value> initValues = null;

    public ArrayList<Instruction> initInstructions = null;
    public BasicBlock parentBlock = null;

    public Alloca(int nameNum, ValueType allocatedType, BasicBlock parent){
        // 指针 没有初始化
        super("%v" + nameNum, new PointerType(allocatedType), parent,new ArrayList<>());
        this.initVal = null;
    }

    public Alloca(int nameNum, ValueType allocatedType, BasicBlock parent, ConstArray initVal){
        // 指针 有初始化
        super("%v" + nameNum, new PointerType(allocatedType), parent,new ArrayList<>());
        this.initVal = initVal;
    }

    public Alloca(String name, ValueType allocatedType, BasicBlock parent){
        // 指针 有初始化
        super(name, new PointerType(allocatedType), parent,new ArrayList<>());
        this.initVal = null;
    }

    public ValueType getAllocatedType(){
        PointerType pointer =  (PointerType) getValueType();
        return pointer.getPointeeType();
    }

    public ConstArray getInitVal(){
        return initVal;
    }

    public void setInitValues(ArrayList<Value> initValues){
        this.initValues = initValues;
    }

    public ArrayList<Value> getInitValues(){
        return this.initValues;
    }

    public ArrayList<Constant> getInitValsList(){
        if(initVal == null){
            return new ArrayList<>();
        }
        return initVal.getElements();
    }

    public boolean isPromotable(){
        return !isArray();
    }

    public Boolean isArray() {
        return getAllocatedType() instanceof ArrayType;
    }

    @Override
    public String toString(){
        return getName() + " = alloca " + getAllocatedType();
    }
}

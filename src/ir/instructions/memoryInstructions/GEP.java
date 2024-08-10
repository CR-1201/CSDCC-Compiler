package ir.instructions.memoryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.ArrayType;
import ir.types.DataType;
import ir.types.PointerType;
import ir.types.ValueType;
import java.util.ArrayList;

/**
 @author Conroy
 */

public class GEP extends MemoryInstruction{
    private ValueType baseType;

    public GEP(int nameNum, BasicBlock parent, Value base, Value firstIndex){
        super("%v" + nameNum, (PointerType) base.getValueType(), parent,new ArrayList<>(){{
            add(base);add(firstIndex);
        }});
        this.baseType = ((PointerType) base.getValueType()).getPointeeType();
    }

    public GEP(int nameNum, BasicBlock parent, Value base, Value firstIndex, Value secondIndex){
        super("%v" + nameNum, new PointerType(((ArrayType) ((PointerType) base.getValueType()).getPointeeType()).getElementType()),
                parent, new ArrayList<>(){{
                    add(base);add(firstIndex);add(secondIndex);
                }});
        this.baseType = ((PointerType) base.getValueType()).getPointeeType();
    }

    public GEP(int nameNum, BasicBlock parent, DataType dataType, Value base, ArrayList<Value> indexes){
        super("%v" + nameNum, dataType, parent, new ArrayList<>(){{
                    add(base);addAll(indexes);
                }});
        this.baseType = ((PointerType) base.getValueType()).getPointeeType();
    }

    public Value getBase(){
        return getOperator(0);
    }

    public ValueType getBaseType(){
        return baseType;
    }

    public void setBaseType(ValueType baseType){
        this.baseType = baseType;
    }

    public ArrayList<Value> getIndex(){
        ArrayList<Value> result = new ArrayList<>();
        for (int i = 1; i < getNumOfOps(); i++){
            result.add(getOperator(i));
        }
        return result;
    }

    public void modifyTarget(Value target){
        this.setOperator(0, target);
        this.setBaseType(((PointerType) target.getValueType()).getPointeeType());
    }

    public void modifyIndexes(ArrayList<Value> indexes){
        ArrayList<Value> tmpOperands = new ArrayList<>(getOperators());
        for(int i = 1; i < tmpOperands.size(); i++){
            Value operand = tmpOperands.get(i);
            operand.removeUser(this);
            removeOperator(operand);
        }
        for(Value idxValue : indexes){
            this.addOperator(idxValue);
            if (!idxValue.getUsers().contains(this)) {
                idxValue.addUser(this);
            }
        }

    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder(getName() + " = getelementptr inbounds " + baseType + ", ");
        int n = getNumOfOps();
        for (int i = 0; i < n; i++){
            s.append(getOperator(i).getValueType()).append(" ").append(getOperator(i).getName());
            if( i+1 < n )s.append(", ");
        }
//        s.delete(s.length() - 2, s.length());
        return s.toString();
    }
}

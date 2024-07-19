package ir.instructions.otherInstructions;

import ir.BasicBlock;
import ir.User;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;
import java.util.Arrays;

public class Phi extends Instruction {
    private int precursorNum;

    public Phi(int nameNum, DataType dataType, BasicBlock parent, int precursorNum) {
        super("%p" + nameNum, dataType, parent, new ArrayList<>(Arrays.asList(new Value[precursorNum * 2])));
        this.precursorNum = precursorNum;
    }

    public int getPrecursorNum(){
        return precursorNum;
    }

    public void addIncoming(Value value, BasicBlock block) {
        if (getValueType() == null) {
            setValueType(value.getValueType());
        }
        int i = 0;
        while (i < precursorNum && getOperator(i) != null) {
            i++;
        }
        if (i < precursorNum) {
            setOperator(i, value);
            setOperator(i + precursorNum, block);
        } else {
            getOperators().add(precursorNum, value);
            precursorNum++;
            getOperators().add(block);
            value.addUser(this);
            block.addUser(this);
        }
    }

    public void removeUsedBlock(BasicBlock block) {
        int idx = getOperators().indexOf(block);
        Value value = getOperator(idx - precursorNum);
        block.removeUser(this);
        value.removeUser(this);
        removeOperator(idx);
        removeOperator(idx - precursorNum);
        precursorNum --;
    }

    public Value getInputVal(BasicBlock block) {
        for (int i = 0; i < precursorNum; i++) {
            if (getOperator(i + precursorNum) == block) {
                return getOperator(i);
            }
        }
        throw new AssertionError("block not found for phi!");
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder(getName() + " = phi ").append(getValueType());
        for (int i = 0; i < precursorNum; i++){
            if (getOperator(i) == null) break;
            s.append(" [ ").append(getOperator(i).getName()).append(", ")
                    .append(getOperator(i + precursorNum).getName()).append(" ]");
            if( i+1 < precursorNum )s.append(", ");
        }
        return s.toString();
    }
}

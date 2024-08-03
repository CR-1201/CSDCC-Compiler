package ir.instructions.otherInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

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

    public void removeUsedValue(Value value) {
        int idx = getOperators().indexOf(value);
        BasicBlock block = (BasicBlock) getOperator(idx + precursorNum);
        block.removeUser(this);
        value.removeUser(this);
        removeOperator(idx + precursorNum);
        removeOperator(idx);
        precursorNum --;
    }

    public Value getIncomingFrom(BasicBlock block) {
        for (int i = 0; i < precursorNum; i++) {
            if (getOperator(i + precursorNum) == block) {
                return getOperator(i);
            }
        }
        return null;
    }

    public ArrayList<Value> getIncomingsFrom(BasicBlock block) {
        ArrayList<Value> ans = new ArrayList<>();
        for (int i = 0; i < precursorNum; i++) {
            if (getOperator(i + precursorNum) == block) {
                ans.add(getOperator(i));
            }
        }
        return ans;
    }


    public ArrayList<Map.Entry<Value, BasicBlock>> getEntry() {
        ArrayList<Map.Entry<Value, BasicBlock>> entryPairs = new ArrayList<>();
        for (int i = 0; i < precursorNum; i++) {
            if (getOperator(i) == null) break;
            entryPairs.add(new AbstractMap.SimpleEntry<>(getOperator(i), (BasicBlock) getOperator(i + precursorNum)));
        }
        return entryPairs;
    }
    public void removeIfRedundant(boolean f) {
        if (getUsers().isEmpty()) {
            removeAllOperators();
            eraseFromParent();
            return;
        }
        if (precursorNum == 0) {
            throw new AssertionError(this + "'s predecessorNum = 0!");
        }
        Value commonValue = getOperator(0);
        for (int i = 1; i < precursorNum; i++)
        {
            if (commonValue != getOperator(i))
            {
                return;
            }
        }
        if (!f && commonValue instanceof Instruction)
        {
            return;
        }
        replaceAllUsesWith(commonValue);
        removeAllOperators();
        eraseFromParent();
    }

    public void replaceOperator(Value oldValue, Value newValue, BasicBlock newBlock) {
        int index = getOperators().indexOf(oldValue);
        setOperator(index, newValue);
        setOperator(index + precursorNum, newBlock);
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

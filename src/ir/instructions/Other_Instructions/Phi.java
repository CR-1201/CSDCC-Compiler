package ir.instructions.Other_Instructions;

import ir.BasicBlock;
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

    public Value getInputVal(BasicBlock block) {
        for (int i = 0; i < precursorNum; i++) {
            if (getValue(i + precursorNum) == block) {
                return getValue(i);
            }
        }
        throw new AssertionError("block not found for phi!");
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder(getName() + " = phi ").append(getValueType());
        for (int i = 0; i < precursorNum; i++){
            if (getValue(i) == null) break;
            s.append(" [ ").append(getValue(i).getName()).append(", ")
                    .append(getValue(i + precursorNum).getName()).append(" ]");
            if( i+1 < precursorNum )s.append(", ");
        }
        return s.toString();
    }
}

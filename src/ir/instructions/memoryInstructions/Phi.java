package ir.instructions.memoryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.DataType;

import java.util.ArrayList;

public class Phi extends MemoryInstruction {
    private int precursorNum;

    public Phi(int nameNum, DataType dataType, BasicBlock parent, int precursorNum) {
        super("%p" + nameNum, dataType, parent, new ArrayList<>(precursorNum * 2));
        this.precursorNum = precursorNum;
    }

    public void addIncoming(Value value, BasicBlock block) {
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
        }
        value.addUser(this);
        block.addUser(this);
    }
}

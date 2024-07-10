package ir.instructions.Terminator_Instructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;

public class TerInstruction extends Instruction {
    public TerInstruction(DataType dataType, BasicBlock parent, ArrayList<Value> ops){
        super("", dataType, parent, ops);
    }
}

package ir.instructions.memoryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;

/**
 @author Conroy
 */
public class MemoryInstruction extends Instruction {
    MemoryInstruction(String name, DataType dataType, BasicBlock parent, ArrayList<Value> ops){
        super(name, dataType, parent, ops);
    }
}

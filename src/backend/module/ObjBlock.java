package backend.module;

import backend.instruction.ObjInstruction;

import java.util.LinkedList;

public class ObjBlock {
    private String name;
    private LinkedList<ObjInstruction> instructions = new LinkedList<>();

    public ObjBlock(String name) {
        this.name = name.substring(1);
    }

    public String getName() {
        return name;
    }
    public void addInstruction(ObjInstruction instruction) {
        instructions.add(instruction);
    }

    public void addInstructionToHead(ObjInstruction instruction) {
        instructions.addFirst(instruction);
    }

    public LinkedList<ObjInstruction> getInstructions() {
        return instructions;
    }
    public void addInstructionBefore(ObjInstruction index, ObjInstruction objInstruction) {
        instructions.add(instructions.indexOf(index), objInstruction);
    }

    public void addInstructionAfter(ObjInstruction index, ObjInstruction objInstruction) {
        instructions.add(instructions.indexOf(index) + 1, objInstruction);
    }
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(name).append(":\n");
        instructions.forEach(instruction -> sb.append(instruction.toString()));
        return sb.toString();
    }
}

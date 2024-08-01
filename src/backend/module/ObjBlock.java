package backend.module;

import backend.ObjBuilder;
import backend.instruction.ObjInstruction;
import backend.instruction.ObjMove;

import java.util.ArrayList;
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

    private ArrayList<ObjInstruction> phiMoveInstructions = new ArrayList<>();

    public void addPhiMove(ObjInstruction objMove) {
        phiMoveInstructions.add(objMove);
    }

    public void fixPhiMove() {
        for (ObjInstruction phi : phiMoveInstructions) {
            int size = instructions.size();
            ObjBlock[] succ = ObjBuilder.getSucc(getName());
            if (succ[0] == null) {
                break;
            } else if (succ[1] == null) {
                instructions.add(size - 1, phi);
            } else {
                instructions.add(size - 2, phi);
            }
        }
    }

    public void removeInstruction(ObjInstruction instruction) {
        instructions.remove(instruction);
    }
}

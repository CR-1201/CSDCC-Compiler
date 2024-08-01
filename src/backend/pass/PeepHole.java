package backend.pass;

import backend.ObjBuilder;
import backend.instruction.ObjInstruction;
import backend.instruction.ObjMove;
import backend.module.ObjBlock;
import backend.module.ObjFunction;
import backend.module.ObjModule;

import java.util.ArrayList;
import java.util.LinkedList;

public class PeepHole implements ObjPass {
    ObjModule module;

    public PeepHole() {
        module = ObjModule.getModule();
    }

    @Override
    public void run() {
        for (ObjFunction function : module.getFunctions()) {
            for (ObjBlock block : function.getBlocks()) {
                LinkedList<ObjInstruction> instructions = new LinkedList<>(block.getInstructions());
                for (ObjInstruction instruction : instructions) {
                    if (instruction instanceof ObjMove move) {
                        if (move.getRhs().equals(move.getDst())) {
                            block.removeInstruction(move);
                        }
                    }
                }
            }
        }
    }
}

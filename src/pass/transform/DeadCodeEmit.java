package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import pass.Pass;
import ir.Module;

import java.util.ArrayList;

public class DeadCodeEmit implements Pass {

    private final Module irModule = Module.getModule();

    private final ArrayList<Instruction> usefulInstructions = new ArrayList<>();

    @Override
    public void run() {
        ArrayList<Function> functions = irModule.getFunctionsArray();
        for (Function func : functions) {
            if (!func.getIsBuiltIn()) {
                deleteUselessInstructions(func);
            }
        }
    }

    private void deleteUselessInstructions(Function func) {
        usefulInstructions.clear();

        for (BasicBlock bs : func.getBasicBlocksArray()) {
            for (Instruction instr : bs.getInstructionsArray()) {
                if (instr instanceof Br || instr instanceof Ret || instr instanceof Store ||
                        (instr instanceof Call && ((Call)instr).getFunction().getSideEffect())) {
                    findClosure(instr);
                }
            }
        }

        for (BasicBlock bs : func.getBasicBlocksArray()) {
            for (Instruction instr : bs.getInstructionsArray()) {
                instr.removeAllOperators();
                instr.eraseFromParent();
            }
        }
    }

    private void findClosure(Instruction instr) {
        if (!usefulInstructions.contains(instr)) {
            usefulInstructions.add(instr);
            for (Value operand : instr.getOperators()) {
                if (operand instanceof Instruction) {
                    findClosure((Instruction) operand);
                }
            }
        }
    }

}

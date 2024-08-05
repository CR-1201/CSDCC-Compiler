package pass.transform;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import pass.Pass;
import pass.analysis.*;

import java.util.*;

public class ADCE implements Pass {

    private final Module irModule = Module.getModule();

    private final HashSet<Instruction> usefulInstructions = new HashSet<>();

    private final HashSet<BasicBlock> usefulBlocks = new HashSet<>();

    private final HashSet<Loop> toBeRemovedLoop = new HashSet<>();

    private boolean changed;

    @Override
    public void run() {
        new CDG().run();
        new SideEffect().run();
        new LoopAnalysis().run();

        for (Function function : irModule.getFunctionsArray()) {
            if (function.getIsBuiltIn()) {
                continue;
            }

            usefulBlocks.clear();
            usefulInstructions.clear();

            changed = true;
            while(changed) {
                mark(function);
            }

            for (BasicBlock block : function.getBasicBlocksArray()) {
                if (usefulBlocks.contains(block))
                    continue;
                if (block.getLoop() == null)
                    continue;
                if (!ifRemoveLoop(block.getLoop()))
                    continue;

                toBeRemovedLoop.add(block.getLoop());
            }
        }

        for (Loop loop : toBeRemovedLoop) {
            BasicBlock preHeader = getPreHeader(loop);
            BasicBlock exit = new ArrayList<>(loop.getExits()).get(0);

            if (preHeader == null || exit == null) {
                continue;
            }

            Br preHeadBrInstr = (Br) preHeader.getTailInstruction();
            preHeadBrInstr.setOperator(0, exit);

            for (BasicBlock block : loop.getAllBlocks()) {
                block.removeSelf();
            }
        }

        new CFG().run();
        new Dom().run();
        new SideEffect().run();
    }

    private BasicBlock getPreHeader(Loop loop) {
        for (BasicBlock block : loop.getHeader().getPrecursors()) {
            if (!loop.getAllBlocks().contains(block)) {
                return block;
            }
        }
        return null;
    }

    private boolean ifRemoveLoop(Loop loop) {
        for (BasicBlock block : loop.getAllBlocks()) {
            if (usefulBlocks.contains(block)) {
                return false;
            }
        }

        for (BasicBlock block : loop.getAllBlocks()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                for (User user : instruction.getUsers()) {
                    if (!loop.getAllBlocks().contains((BasicBlock) user.getParent())) {
                        return false;
                    }
                }
            }
        }

        return true;
    }

    private void mark(Function function) {
        changed = false;
        ArrayList<BasicBlock> blockList = function.getBasicBlocksArray();
        Collections.reverse(blockList);
        for (BasicBlock block : blockList) {
            ArrayList<Instruction> instrList = block.getInstructionsArray();
            Collections.reverse(instrList);
            for (Instruction instruction : instrList) {
                if (isUsefulInstr(instruction)) {
                    findClosure(instruction);
                }
            }
        }
    }

    private void findClosure(Instruction instruction) {
        if (!usefulInstructions.contains(instruction)) {
            add(instruction);

            for (Value operand : instruction.getOperators()) {
                if (operand instanceof Instruction && !usefulInstructions.contains(operand)) {
                    findClosure((Instruction) operand);
                }
            }
        }
    }

    private boolean isUsefulInstr(Instruction instr) {
        return instr instanceof Store ||
                instr instanceof Ret ||
                (instr instanceof Call callInstr && callInstr.getFunction().getSideEffect()) ||
                instr instanceof Br brInstr && isUsefulBr(brInstr);
    }

    private boolean isUsefulBr(Br brInstr) {
        if (!brInstr.getHasCondition()) {
            return usefulBlocks.contains((BasicBlock) brInstr.getOperator(0));
        }
        BasicBlock brBlock = brInstr.getParent();
        for (BasicBlock postBlock : usefulBlocks) {
            if (brBlock.getControls().contains(postBlock)) {
                return true;
            }
        }
        return false;
    }

    private void add(Instruction instruction) {
        usefulInstructions.add(instruction);
        usefulBlocks.add(instruction.getParent());
        changed = true;
    }

}

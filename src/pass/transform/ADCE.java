package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import pass.Pass;
import pass.analysis.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;

public class ADCE implements Pass {

    private final Module irModule = Module.getModule();

    private final HashSet<Instruction> usefulInstructions = new HashSet<>();

    private final HashSet<BasicBlock> usefulBlocks = new HashSet<>();

    private final Queue<Instruction> workList = new LinkedList<>();

    private final HashSet<Loop> toBeRemovedLoop = new HashSet<>();

    @Override
    public void run() {
        new CDG().run();
//        new SideEffect().run();
//        new LoopAnalysis().run();

//        for (Function function : irModule.getFunctionsArray()) {
//            if (function.getIsBuiltIn()) {
//                continue;
//            }
//
//            usefulBlocks.clear();
//            usefulInstructions.clear();
//            workList.clear();
//
//            markBase(function);
//            while (!workList.isEmpty()) {
//                Instruction curInstr = workList.poll();
//                findClosure(curInstr);
//            }
//
//            for (BasicBlock block : function.getBasicBlocksArray()) {
//                if (usefulBlocks.contains(block))
//                    continue;
//                if (block.getLoop() == null)
//                    continue;
//                if (!ifRemoveLoop(block.getLoop()))
//                    continue;
//
//                toBeRemovedLoop.add(block.getLoop());
//            }
//        }
//
//        for (Loop loop : toBeRemovedLoop) {
//            BasicBlock preHeader = getPreHeader(loop);
//            BasicBlock exit = new ArrayList<>(loop.getExits()).get(0);
//
//            assert preHeader != null;
//            assert exit != null;
////            Br preHeadBrInstr = (Br) preHeader.getTailInstruction();
////            preHeadBrInstr.setOperator(0, exit);
//
//            for (BasicBlock block : loop.getAllBlocks()) {
////                block.removeSelf();
//            }
//        }

//        new CFG().run();
//        new Dom().run();
//        new SideEffect().run();
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
        return true;
    }

    private void findClosure(Instruction instr) {
        if (!usefulInstructions.contains(instr)) {
            usefulInstructions.add(instr);
            usefulBlocks.add(instr.getParent());
            workList.add(instr);

            for (Value operand : instr.getOperators()) {
                if (operand instanceof Instruction instruction && !usefulInstructions.contains(instruction)) {
                    findClosure(instruction);
                }
            }
        }
    }

    private void markBase(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instr : block.getInstructionsArray()) {
                if (isUsefulInstr(instr)) {
                    usefulInstructions.add(instr);
                    usefulBlocks.add(instr.getParent());
                    workList.add(instr);
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

}

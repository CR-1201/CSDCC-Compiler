package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.FloatType;
import ir.types.IntType;
import ir.types.PointerType;
import pass.Pass;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.Loop;
import pass.analysis.LoopAnalysis;

import java.util.ArrayList;
import java.util.InputMismatchException;

public class Pattern {

    private static final Module irModule = Module.getModule();

    private static final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    public static class Pattern4 implements Pass {

        @Override
        public void run() {
            boolean changed = false;

            for (Function function : irModule.getFunctionsArray()) {
                if (!function.getIsBuiltIn()) {
                    if (check(function)) {
                        modify(function);
                        changed = true;
                    }
                }
            }

            if (changed) {
                new InlineFunction().run();
                new MergeBlocks().run();
            }
        }

        private boolean check(Function function) {
            if (function.getArguments().size() != 2)
                return false;
            if (function.getBasicBlocksArray().size() != 4)
                return false;

            BasicBlock funcHeadBlock = function.getFirstBlock();
            if (funcHeadBlock.getInstructionsArray().size() != 2 ||
                    !(funcHeadBlock.getInstructionsArray().get(0) instanceof Icmp icmpInstr) ||
                    !(funcHeadBlock.getInstructionsArray().get(1) instanceof Br brInstr1))
                return false;
            if (icmpInstr.getOperator(0) != function.getArguments().get(1) ||
                    !(icmpInstr.getOperator(1) instanceof ConstInt constIntOp1) ||
                    constIntOp1.getValue() != 0)
                return false;

            if (brInstr1.getTrueBlock().getInstructionsArray().size() != 1 ||
                    !(brInstr1.getTrueBlock().getInstructionsArray().get(0) instanceof Br brInstr3) ||
                    brInstr3.getHasCondition())
                return false;

            BasicBlock ifTrueBlock = (BasicBlock) brInstr3.getOperator(0);
            BasicBlock ifFalseBlock = brInstr1.getFalseBlock();
            if (ifTrueBlock.getInstructionsArray().size() != 2 ||
                    !(ifTrueBlock.getInstructionsArray().get(0) instanceof Phi) ||
                    !(ifTrueBlock.getInstructionsArray().get(1) instanceof Ret))
                return false;
            if (ifFalseBlock.getInstructionsArray().size() != 6 ||
                    !(ifFalseBlock.getInstructionsArray().get(0) instanceof Sub subInstr1) ||
                    !(ifFalseBlock.getInstructionsArray().get(1) instanceof Call callInstr1) ||
                    !(ifFalseBlock.getInstructionsArray().get(2) instanceof Add addInstr) ||
                    !(ifFalseBlock.getInstructionsArray().get(3) instanceof Call callInstr2) ||
                    !(ifFalseBlock.getInstructionsArray().get(4) instanceof Sub subInstr2) ||
                    !(ifFalseBlock.getInstructionsArray().get(5) instanceof Br brInstr2))
                return false;

            if (subInstr1.getOperator(0) != function.getArguments().get(1) ||
                    !(subInstr1.getOperator(1) instanceof ConstInt constIntOp2) ||
                    constIntOp2.getValue() != 1)
                return false;
            if (callInstr1.getFunction() != function ||
                    callInstr1.getOperator(1) != function.getArguments().get(0) ||
                    callInstr1.getOperator(2) != subInstr1)
                return false;
            if (addInstr.getOperator(0) != function.getArguments().get(0) ||
                    addInstr.getOperator(1) != callInstr1)
                return false;
            if (callInstr2.getFunction() != function ||
                    callInstr2.getOperator(1) != addInstr ||
                    callInstr2.getOperator(2) != subInstr1)
                return false;
            if (subInstr2.getOperator(0) != addInstr ||
                    subInstr2.getOperator(1) != callInstr2)
                return false;

            return true;
        }

        private void modify(Function function) {
            for (BasicBlock block : function.getBasicBlocksArray()) {
                block.removeSelf();
            }

            BasicBlock onlyBlock = irBuilder.buildBasicBlock(function);

            Add add = irBuilder.buildAdd(onlyBlock, new IntType(32), function.getArguments().get(1), new ConstInt(1));
            Srem srem = irBuilder.buildSrem(onlyBlock, new IntType(32), add, new ConstInt(2));
            Conversion conversion = irBuilder.buildConversion(onlyBlock, "sitofp", new FloatType(), srem);
            Mul mul = irBuilder.buildMul(onlyBlock, new FloatType(), function.getArguments().get(0), conversion);
            irBuilder.buildRet(onlyBlock, mul);
        }

    }

    public static class Pattern3 implements Pass {

        @Override
        public void run() {
            for (Function function : irModule.getFunctionsArray()) {
                if (!function.getIsBuiltIn()) {
                    modify(function);
                }
            }

            new DeadCodeEmit().run();
        }

        private void modify(Function function) {
            ArrayList<GEP> geps = new ArrayList<>();
            for (BasicBlock block : function.getBasicBlocksArray()) {
                for (Instruction instruction : block.getInstructionsArray()) {
                    if (instruction instanceof GEP gepInstr) {
                        geps.add(gepInstr);
                    }
                }
            }

            if (geps.size() != 1)
                return;
            GEP gep = geps.get(0);

            int memsetCallCnt = 0;
            Call memsetCall = null;
            int loadCnt = 0;
            for (User user : gep.getUsers()) {
                if (user instanceof Call callInstr && callInstr.getFunction().getName().equals("@memset")) {
                    memsetCallCnt ++;
                    memsetCall = callInstr;
                }
                if (user instanceof Load) {
                    loadCnt ++;
                }
            }

            if (memsetCallCnt != 1)
                return;
            if (memsetCallCnt + loadCnt != gep.getUsers().size())
                return;

            Value setValue = memsetCall.getParamAt(1);
            for (User user : gep.getUsers()) {
                if (user instanceof Load loadInstr) {
                    loadInstr.replaceAllUsesWith(setValue);
                }
            }

            memsetCall.removeSelf();
        }

    }

    public static class Pattern2 implements Pass {

        Loop loop = null;
        BasicBlock loopHeaderBlock = null;

        Br loopBranch = null;
        BasicBlock loopTrueBlock = null;
        BasicBlock loopFalseBlock = null;

        Br ifBranch = null;
        BasicBlock ifTrueBlock = null;
        BasicBlock ifFalseBlock = null;


        @Override
        public void run() {
            new CFG().run();
            new Dom().run();
            new LoopAnalysis().run();

            for (Function function : irModule.getFunctionsArray()) {
                addBreak(function);
            }
        }

        private void addBreak(Function function) {
            if (function.getIsBuiltIn())
                return;

            for (BasicBlock block : function.getBasicBlocksArray()) {
                if (block.getLoop() != null) {
                    if (!check(block))
                        continue;

                    modify();

                    return;
                }
            }
        }

        private void modify() {
            ifTrueBlock.getInstructionsArray().get(3).setOperator(0, loopFalseBlock);
        }

        private boolean check(BasicBlock block) {
            loop = block.getLoop();
            loopHeaderBlock = loop.getHeader();

            if (!checkLoopHeader(loopHeaderBlock))
                return false;

            loopBranch = (Br) loopHeaderBlock.getInstructionsArray().get(3);
            loopTrueBlock = loopBranch.getTrueBlock();
            loopFalseBlock = loopBranch.getFalseBlock();

            if (!checkIfHeader(loopTrueBlock))
                return false;

            ifBranch = (Br) loopTrueBlock.getInstructionsArray().get(3);
            ifTrueBlock = ifBranch.getTrueBlock();
            ifFalseBlock = ifBranch.getFalseBlock();

            if (!checkIfTrueBlock(ifTrueBlock))
                return false;
//            if (!checkIfFalseBlock(ifFalseBlock))
//                return false;

            return true;
        }

        private boolean checkIfTrueBlock(BasicBlock ifTrueBlock) {
            return ifTrueBlock.getInstructionsArray().size() == 4 &&
                    ifTrueBlock.getInstructionsArray().get(0) instanceof Load loadInstr &&
                    ifTrueBlock.getInstructionsArray().get(1) instanceof Add addInstr &&
                    ifTrueBlock.getInstructionsArray().get(2) instanceof Store storeInstr &&
                    ifTrueBlock.getInstructionsArray().get(3) instanceof Br brInstr &&
                    !brInstr.getHasCondition() &&
                    brInstr.getOperator(0) == loopHeaderBlock &&
                    loadInstr.getAddr() == ((Load) loopHeaderBlock.getInstructionsArray().get(0)).getAddr() &&  // 用于保证循环变量是i
                    loadInstr.getAddr() == ((Load) loopTrueBlock.getInstructionsArray().get(1)).getAddr();  // 用于保证循环变量是i
        }

        private boolean checkIfFalseBlock(BasicBlock ifFalseBlock) {
            return ifFalseBlock.getInstructionsArray().size() == 1 &&
                    ifFalseBlock.getInstructionsArray().get(0) instanceof Br brInstr &&
                    !brInstr.getHasCondition();
        }

        private boolean checkIfHeader(BasicBlock ifHeaderBlock) {
            return ifHeaderBlock.getInstructionsArray().size() == 4 &&
                    ifHeaderBlock.getInstructionsArray().get(0) instanceof Load loadInstr1 &&
                    ifHeaderBlock.getInstructionsArray().get(1) instanceof Load loadInstr2 &&
                    ifHeaderBlock.getInstructionsArray().get(2) instanceof Icmp icmpInstr &&
                    ifHeaderBlock.getInstructionsArray().get(3) instanceof Br &&
                    icmpInstr.getCondition() == Icmp.Condition.LT &&
                    icmpInstr.getOperator(0) == loadInstr1 &&
                    icmpInstr.getOperator(1) == loadInstr2;
        }

        private boolean checkLoopHeader(BasicBlock headerBlock) {
            return headerBlock.getInstructionsArray().size() == 4 &&
                    headerBlock.getInstructionsArray().get(0) instanceof Load loadInstr1 &&
                    headerBlock.getInstructionsArray().get(1) instanceof Load loadInstr2 &&
                    headerBlock.getInstructionsArray().get(2) instanceof Icmp icmpInstr &&
                    headerBlock.getInstructionsArray().get(3) instanceof Br &&
                    icmpInstr.getCondition() == Icmp.Condition.LT &&
                    icmpInstr.getOperator(0) == loadInstr1 &&
                    icmpInstr.getOperator(1) == loadInstr2;
        }

    }

    public static class Pattern1 implements Pass {

        @Override
        public void run() {
            for (Function function : irModule.getFunctionsArray()) {
                if (checkFunction(function)) {
                    deleteUselessBranch(function);
                }
            }
        }

        private void deleteUselessBranch(Function function) {
            for (BasicBlock block : function.getBasicBlocksArray()) {
                if (checkBlock(block)) {
                    BasicBlock headBlock = function.getFirstBlock();
                    Instruction beforeInstr = headBlock.getInstructionsArray().get(8);
                    irBuilder.buildBrBeforeInstr(headBlock, block, beforeInstr);

                    for (Instruction instruction : headBlock.getInstructionsArray().subList(9, headBlock.getInstructionsArray().size())) {
                        instruction.removeSelf();
                    }

                    for (BasicBlock _block : function.getBasicBlocksArray()) {
                        if (!(_block == headBlock) && !(_block == block)) {
                            _block.removeSelf();
                        }
                    }
                    return;
                }
            }
        }

        private boolean checkFunction(Function function) {
            if (function.getIsBuiltIn()) {
                return false;
            }

            return function.getArguments().size() == 4 &&
                    function.getArguments().get(0).getValueType() instanceof PointerType &&
                    function.getArguments().get(1).getValueType() instanceof IntType &&
                    function.getArguments().get(2).getValueType() instanceof IntType &&
                    function.getArguments().get(3).getValueType() instanceof IntType &&
                    function.getBasicBlocksArray().size() == 8 &&
                    function.getBasicBlocksArray().get(0).getInstructionsArray().size() == 11;
        }

        private boolean checkBlock(BasicBlock block) {
            return block.getInstructionsArray().size() == 9 &&
                    block.getInstructionsArray().get(0) instanceof Load &&
                    block.getInstructionsArray().get(1) instanceof Load &&
                    block.getInstructionsArray().get(2) instanceof Load &&
                    block.getInstructionsArray().get(3) instanceof Mul &&
                    block.getInstructionsArray().get(4) instanceof Load &&
                    block.getInstructionsArray().get(5) instanceof Add &&
                    block.getInstructionsArray().get(6) instanceof GEP &&
                    block.getInstructionsArray().get(7) instanceof Load &&
                    block.getInstructionsArray().get(8) instanceof Ret;
        }

    }

}

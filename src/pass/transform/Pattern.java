package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.IrBuilder;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Add;
import ir.instructions.binaryInstructions.Icmp;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.IntType;
import ir.types.PointerType;
import pass.Pass;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.Loop;
import pass.analysis.LoopAnalysis;

public class Pattern {

    private static final Module irModule = Module.getModule();

    private static final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    public static class Pattern3 implements Pass{
        public void run() {
            new LoopAnalysis().run();

            for (Function function : irModule.getFunctionsArray()) {
                if( !function.getIsBuiltIn() ){
                    search(function);
                }
            }
        }

        private void search(Function function) {

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

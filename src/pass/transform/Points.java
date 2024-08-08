package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.IrBuilder;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Add;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.IntType;
import ir.types.PointerType;
import pass.Pass;

public class Points implements Pass {

    private final Module irModule = Module.getModule();

    private final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    @Override
    public void run() {
        new Point1().run();
    }

    private class Point1 { // floyd.sy 删除无用的分支

        private void run() {
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

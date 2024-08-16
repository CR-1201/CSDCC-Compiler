package pass.transform.other;

import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Add;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.types.*;
import pass.Pass;

import java.util.ArrayList;

public class ConstFunctionReplace implements Pass {
    private final IrBuilder irBuilder = new IrBuilder();
    private Function mainFunction = null;
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                runConstFunctionReplace(function);
            }
        }
    }

    private void runConstFunctionReplace(Function function) {
        if (canReplace(function)) {
            mainFunction = Module.getModule().getMainFunction();
            ValueType floatType = new FloatType();
            Alloca alloca = irBuilder.buildALLOCA(floatType, mainFunction.getFirstBlock());
            irBuilder.buildStoreBeforeInstr(mainFunction.getFirstBlock(), new ConstFloat(0.0F), alloca, mainFunction.getFirstBlock().getTailInstruction());
            ArrayList<BasicBlock> blocks = mainFunction.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                if (selectAddBlock(block)) {
                    Add ansLeft = (Add) block.getInstructionsArray().get(2);
                    Add ansRight = (Add) block.getInstructionsArray().get(5);
                    Value load = irBuilder.buildLoadBeforeTail(block, alloca);
                    Mul mul = irBuilder.buildMulBeforeTail(block, (DataType) ansLeft.getValueType(), ansLeft, ansRight);
                    Add add = irBuilder.buildAddBeforeTail(block, (DataType) mul.getValueType(), load, mul);
                    Store store = irBuilder.buildStoreBeforeTail(block, add, alloca);
                    continue;
                }
                // 寻找常函数的 Caller
                ArrayList<Instruction> insts = block.getInstructionsArray();
                for (Instruction inst : insts) {
                    if (inst instanceof Call call && call.getFunction().equals(function)) {
                        Value load = irBuilder.buildLoadBefore(block, alloca, inst);
                        inst.replaceAllUsesWith(load);
                        inst.removeSelf();
                    }
                }
            }
        }
    }

    private Boolean selectAddBlock(BasicBlock block) {
        if (block.getInstructionsArray().size() != 9) {
            return false;
        }
        boolean isTargetBlock = true;
        isTargetBlock &= block.getInstructionsArray().get(2) instanceof Add;
        isTargetBlock &= block.getInstructionsArray().get(3) instanceof Store;
        isTargetBlock &= block.getInstructionsArray().get(5) instanceof Add;
        isTargetBlock &= block.getInstructionsArray().get(6) instanceof Store;
        return isTargetBlock;
    }

    private Boolean canReplace(Function function) {
        if (!function.getCallees().isEmpty()) {
            return false;
        }
        if (function.getReturnType() instanceof VoidType) {
            return false;
        } else if (function.getReturnType() instanceof IntType) {
            return false;
        }
        if (!(function.getArgument(0).getValueType() instanceof PointerType)) {
            return false;
        } else {
            if (!(((PointerType) function.getArgument(0).getValueType()).getPointeeType() instanceof FloatType)) {
                return false;
            }
        }
        if (!(function.getArgument(1).getValueType() instanceof PointerType)) {
            return false;
        } else {
            if (!(((PointerType) function.getArgument(1).getValueType()).getPointeeType() instanceof FloatType)) {
                return false;
            }
        }
        if (!(function.getArgument(2).getValueType() instanceof IntType)) {
            return false;
        }
        return true;
    }
}

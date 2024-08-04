package pass.transform;

import ast.CompUnit;
import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.FloatType;
import ir.types.IntType;
import ir.types.ValueType;
import ir.types.VoidType;
import pass.Pass;
import pass.utiles.FunctionClone;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import utils.IOFunc;

import java.util.ArrayList;
import java.util.HashMap;

public class InlineFunction implements Pass {

    private final Module irModule = Module.getModule();

    private final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    private boolean modified = true;

    private final HashMap<Function, ArrayList<Function>> calleeFunctions = new HashMap<>();

    private final HashMap<Function, ArrayList<Function>> callerFunctions = new HashMap<>();

    private final ArrayList<Function> toBeInlinedFunctions = new ArrayList<>();

    @Override
    public void run() {
        while (modified) {
            modified = false;

            buildCallGraph();

            for (Function callerFunc : irModule.getFunctionsArray()) {
                boolean canBeInlined = true;

                if (!callerFunc.getIsBuiltIn() && !callerFunc.getName().equals("@main")) {
                    for (Function calleeFunc : calleeFunctions.get(callerFunc)) {
                        if (!calleeFunc.getIsBuiltIn()) {
                            canBeInlined = false;
                            break;
                        }
                    }
                    if (isRecursive(callerFunc)) {
                        canBeInlined = false;
                    }

                    if (canBeInlined) {
                        toBeInlinedFunctions.add(callerFunc);
                    }
                }
            }

            for (Function func : toBeInlinedFunctions) {
                inline(func);
            }

            toBeInlinedFunctions.clear();
        }
        buildCallGraph();
        emitUselessFunctions();

//        for (Function f : irModule.getFunctionsArray()) {
//            for (BasicBlock b : f.getBasicBlocksArray()) {
//                if (b.getInstructionsArray().isEmpty()) {
//                    b.removeSelf();
//                }
//            }
//        }

        for (Function function : irModule.getFunctionsArray()) {
            int index = 0;
            BasicBlock firstBasicBlock= null;
            for (BasicBlock basicBlock : function.getBasicBlocksArray()) {
                index ++;
                if (index == 1) {
                    firstBasicBlock = basicBlock;
                    continue;
                }
                for (Instruction instruction : basicBlock.getInstructionsArray()) {
                    if (instruction instanceof Alloca alloca) {
                        Alloca newAlloca = irBuilder.buildALLOCA(alloca, firstBasicBlock);
                        alloca.replaceAllUsesWith(newAlloca);
                        alloca.removeSelf();
                    }
                }
            }
        }
    }

    private void buildCallGraph() {
        calleeFunctions.clear();
        callerFunctions.clear();

        for (Function func : irModule.getFunctionsArray()) {
            if (func.getIsBuiltIn()) {
                continue;
            }

            if (!calleeFunctions.containsKey(func)) {
                calleeFunctions.put(func, new ArrayList<>());
            }

            for (BasicBlock basicBlock : func.getBasicBlocksArray()) {
                for (Instruction instr : basicBlock.getInstructionsArray()) {
                    if (instr instanceof Call curCall) {
                        Function callee = curCall.getFunction();

                        if (!callee.getIsBuiltIn()) {
                            if (!callerFunctions.containsKey(callee)) {
                                callerFunctions.put(callee, new ArrayList<>());
                            }

                            if (!calleeFunctions.get(func).contains(callee)) {
                                calleeFunctions.get(func).add(callee);
                            }

                            if (!callerFunctions.get(callee).contains(func)) {
                                callerFunctions.get(callee).add(func);
                            }
                        }
                    }
                }
            }
        }
    }

    private boolean isRecursive(Function func) {
        return calleeFunctions.containsKey(func) && calleeFunctions.get(func).contains(func);
    }

    private void inline(Function inliningFunc) {
        ArrayList<Call> toBeReplacedCallInstructions = new ArrayList<>();

        if (callerFunctions.containsKey(inliningFunc) && callerFunctions.get(inliningFunc).size() != 0) {
            modified = true;

            for (Function caller : callerFunctions.get(inliningFunc)) {
                for (BasicBlock basicBlock : caller.getBasicBlocksArray()) {
                    for (Instruction instr : basicBlock.getInstructionsArray()) {
                        if (instr instanceof Call callInstr) {
                            if (callInstr.getFunction().getName().equals(inliningFunc.getName())) {
                                toBeReplacedCallInstructions.add(callInstr);
                            }
                        }
                    }
                }
            }

            for (Call call : toBeReplacedCallInstructions) {
                replaceCall(call);
            }

            for (Function caller : callerFunctions.get(inliningFunc)) {
                calleeFunctions.get(caller).remove(inliningFunc);
                calleeFunctions.get(caller).addAll(calleeFunctions.get(inliningFunc));
            }
        }
    }

    private void emitUselessFunctions() {
        for (Function func : irModule.getFunctionsArray()) {
            if (!func.getIsBuiltIn()) {
                if (!callerFunctions.containsKey(func) && !func.getName().equals("@main")) {
                    func.removeSelf();
                }
            }
        }
    }

    private void replaceCall(Call call) {
        BasicBlock curBasicBlock = call.getParent();
        Function curFunction = call.getParent().getParent();
        Function calleeFunction = call.getFunction();
        ValueType retType = calleeFunction.getReturnType();

        BasicBlock nextBlock = irBuilder.buildBasicBLockAfter(curFunction, curBasicBlock);

        boolean backInstr = false;
        for (Instruction instr : curBasicBlock.getInstructionsArray()) {
            if (!backInstr && instr.equals(call)) {
                backInstr = true;
                continue;
            }
            if (backInstr) {
                instr.eraseFromParent();
                nextBlock.insertTail(instr);
                instr.setParent(nextBlock);
            }
        }

        for (BasicBlock successor : curBasicBlock.getSuccessors()) {
            for (Instruction successorInstruction : successor.getInstructionsArray()) {
                if (successorInstruction instanceof Phi &&
                    successorInstruction.getOperators().contains(curBasicBlock)) {
                    successorInstruction.getOperators().set(successorInstruction.getOperators().indexOf(curBasicBlock), nextBlock);
                    nextBlock.addUser(successorInstruction);
                    curBasicBlock.getUsers().remove(successorInstruction);
                }
            }
        }

        nextBlock.getSuccessors().addAll(curBasicBlock.getSuccessors());

        for (BasicBlock successor : curBasicBlock.getSuccessors()) {
            ArrayList<BasicBlock> preBlocks = new ArrayList<>(successor.getPrecursors());
            for (BasicBlock preBlock : preBlocks) {
                if (preBlock.equals(curBasicBlock)) {
                    successor.getPrecursors().remove(curBasicBlock);
                    successor.getPrecursors().add(nextBlock);
                }
            }
        }

        curBasicBlock.getSuccessors().clear();

        // curBlock -> ??? -> nextBlock

        FunctionClone functionCloner = new FunctionClone();
        Function copyFunction = functionCloner.copyFunction(calleeFunction);

//        System.out.println(copyFunction);

        for (int i = 0; i < copyFunction.getNumArgs(); i++) {
            Value curArg = copyFunction.getArguments().get(i);
            Value callArg = call.getOperator(i + 1);

            if (callArg.getValueType() instanceof IntType || callArg.getValueType() instanceof FloatType) {
                curArg.replaceAllUsesWith(callArg);
            } else {
                ArrayList<User> users = new ArrayList<>(curArg.getUsers());
                for (User user : users) {
                    if (user instanceof Store store) {
                        if (store.getOperator(1) instanceof Alloca allocaInst) {
                            allocaInst.eraseFromParent();
                            for (User user1 : allocaInst.getUsers()) {
                                if (user1 instanceof Load) {
                                    user1.replaceAllUsesWith(callArg);
                                }
                                ((Instruction) user1).eraseFromParent();
                            }
                            allocaInst.removeAllOperators();
                        }
                    } else {
                        curArg.replaceAllUsesWith(callArg);
                    }
                }
            }
        }

        Br toFunc = irBuilder.buildBr(curBasicBlock, copyFunction.getFirstBlock());
//        toFunc.eraseFromParent();
//        curBasicBlock.insertTail(toFunc);
//        toFunc.setParent(curBasicBlock);

        ArrayList<Ret> retList = new ArrayList<>();
        int predecessorNum = 0;
        for (BasicBlock bb : copyFunction.getBasicBlocksArray()) {
            for (Instruction inst : bb.getInstructionsArray()) {
                if (inst instanceof Ret) {
                    retList.add((Ret) inst);
                    predecessorNum++;
                }
            }
        }
        if (retType instanceof IntType) {
            Phi phi = irBuilder.buildPhi((IntType) retType, nextBlock, predecessorNum);
            for (Ret ret : retList) {
                phi.addIncoming(ret.getRetValue(), ret.getParent());

                ret.getParent().getSuccessors().remove(nextBlock);
                nextBlock.getPrecursors().remove(ret.getParent());

                irBuilder.buildBrBeforeInstr(ret.getParent(), nextBlock, ret);

                ret.removeAllOperators();
                ret.eraseFromParent();
            }
            call.replaceAllUsesWith(phi);
        } else if (retType instanceof FloatType) {
            Phi phi = irBuilder.buildPhi((FloatType) retType, nextBlock, predecessorNum);
            for (Ret ret : retList) {
                phi.addIncoming(ret.getRetValue(), ret.getParent());

                ret.getParent().getSuccessors().remove(nextBlock);
                nextBlock.getPrecursors().remove(ret.getParent());

                irBuilder.buildBrBeforeInstr(ret.getParent(), nextBlock, ret);

                ret.removeAllOperators();
                ret.eraseFromParent();
            }
            call.replaceAllUsesWith(phi);
        } else if (retType instanceof VoidType) {
            for (Ret retInst : retList) {
                retInst.getParent().getSuccessors().remove(nextBlock);
                nextBlock.getPrecursors().remove(retInst.getParent());

                irBuilder.buildBrBeforeInstr(retInst.getParent(), nextBlock, retInst);

                retInst.removeAllOperators();
                retInst.eraseFromParent();
            }
        }

        for (BasicBlock block : copyFunction.getBasicBlocksArray()) {
            block.removeFromParent();
            curFunction.insertBefore(block, nextBlock);
            block.setParent(curFunction);
        }

        // block(Call) -> curBlock -> .... -> nextBlock

        call.removeAllOperators();
        call.eraseFromParent();
        nextBlock.reducePhi(true);
    }

}

package pass.transform;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.VoidType;
import pass.Pass;
import pass.utility.CloneUtil;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;


import static ast.Node.builder;

public class TailRecursionElimination implements Pass {

    private final Module module = Module.getModule();

    private final CloneUtil cloneUtil = new CloneUtil();
    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( !function.getIsBuiltIn() ){
                runOnFunction(function);
            }
        }
    }

    private void runOnFunction(Function function){
        if( !hasTailRecursion(function) ){
            return;
        }
        BasicBlock entry = function.getFirstBlock(), phiBlock;
        if( !(entry.getInstructionsArray().size() == 1 && entry.getTailInstruction() instanceof Br br && !br.getHasCondition()) ){
            phiBlock = builder.buildBasicBlockAfter(function, entry);

            ArrayList<Instruction> instructions = entry.getInstructionsArray();

            for( Instruction instruction : instructions ){
//                System.out.println(instruction);
                Instruction instr = cloneUtil.cloneInst(phiBlock,instruction);
                instruction.replaceAllUsesWith(instr);
                instruction.removeSelf();
            }

            entry.setPrecursors(new HashSet<>());
            entry.setSuccessors(new HashSet<>());

            entry.replaceAllUsesWith(phiBlock);
            builder.buildBr(entry,phiBlock);
        } else {
            if( !(br.getOperator(0) instanceof BasicBlock block) )return;
            phiBlock = block;
        }

        HashMap<Argument, Phi> phiHashMap = new HashMap<>();
        for( Instruction instruction : phiBlock.getInstructionsArray() ){
            if( instruction instanceof Phi phi ){
                if( phi.getOperators().contains(entry) ){
                    int index = phi.getOperators().indexOf(entry)-phi.getPrecursorNum();
                    Value value = phi.getOperator(index);
                    if( value instanceof Argument argument ){
                        phiHashMap.put(argument,phi);
                    }
                }
            }
        }

        for( Argument argument : function.getArguments() ){
            if( !phiHashMap.containsKey(argument) ){
                Phi phi = builder.buildPhi(phiBlock);
                argument.replaceAllUsesWith(phi);
                for( BasicBlock pre : phiBlock.getPrecursors() ){
                    if( pre.equals(entry) ){
                        phi.addIncoming(argument, entry);
                    } else {
                        phi.addIncoming(phi, entry);
                    }
                }
                phiHashMap.put(argument,phi);
            }
        }

        // 执行尾递归消除
        ArrayList<BasicBlock> basicBlocks = function.getBasicBlocksArray();
        for( BasicBlock block : basicBlocks ){
            if( !isTailRecursionBlock(function,block) ){
                continue;
            }
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            if( instructions.size() == 1 )continue;
            Instruction tail = block.getTailInstruction();
            Call call = (Call) instructions.get(instructions.size()-2);
            int size = function.getNumArgs();

            // 替换终止指令
            Br br = builder.buildBr(block, phiBlock);
            // FIXME ret存在user吗
//            tail.replaceAllUsesWith(br);
            tail.removeSelf();
            for( int i = 0 ; i < size ; i++ ){
                Argument funcArgument = function.getArguments().get(i);
                Value callArgument = call.getArgs().get(i);
                if( phiHashMap.containsKey(funcArgument) ){
                    Phi phi = phiHashMap.get(funcArgument);
                    phi.addIncoming(callArgument,block);
                } else {
                    System.out.println("Error Tail Recursion Elimination!");
                }
            }

            // 将call指令移除
            call.removeSelf();
        }

    }

    private boolean hasTailRecursion(Function function){
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            if( isTailRecursionBlock(function,block) ){
                return true;
            }
        }
        return false;
    }

    private static boolean isTailRecursionBlock(Function function, BasicBlock basicBlock){
        if( !(basicBlock.getTailInstruction() instanceof Ret ret ) ){
            return false;
        }
        ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
        if( instructions.size() <= 1 )return false;
        Instruction tail = instructions.get(instructions.size()-2);
        if( !(tail instanceof Call call && call.getFunction().equals(function)) ){
            return false;
        }
        if( !(function.getReturnType() instanceof VoidType) ){
            return ret.getRetValue().equals(call);
        }
        return true;
    }
}

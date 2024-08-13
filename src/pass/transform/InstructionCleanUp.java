package pass.transform;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.MemoryInstruction;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import pass.Pass;
import pass.analysis.PureFunction;

import java.util.ArrayList;
import java.util.HashMap;

import static pass.analysis.AliasAnalysis.searchRoot;

/**
 @author Conroy
 this pass used after pure function mark
*/

public class InstructionCleanUp implements Pass {
    private final Module module = Module.getModule();

    private HashMap<Function, Boolean> is_pure = new HashMap<>();

    private HashMap<Function, Boolean> funcUsedFlag = new HashMap<>();
    private HashMap<GlobalVariable,Boolean> globalUsedFlag = new HashMap<>();
    private Function mainFunction = null;
    @Override
    public void run() {
        PureFunction pureFunction = new PureFunction();
        pureFunction.markPure();
        this.is_pure = pureFunction.isPure;

        cleanUp();

        globalCleanUp(); // 没有被使用过的函数 可以被删除
    }

    private void globalCleanUp() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            funcUsedFlag.put(function, false);
            if( function.getName().equals("@main") ){
                mainFunction = function;
                funcUsedFlag.put(function, true);
            }
        }

        ArrayList<Function> work_list = new ArrayList<>();
        work_list.add(mainFunction);
        int i = 0;
        while( i < work_list.size() ){
            Function function = work_list.get(i++);
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock basicBlock : blocks) {
                ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof Call call ){
                        Function callFunction = call.getFunction();
                        if( !funcUsedFlag.get(callFunction) ){ // 避免递归 出现死循环
                            funcUsedFlag.put(callFunction, true);
                            work_list.add(callFunction);
                        }
                    }
                }
            }
        }

        for (Function function : functions) {
            if( !funcUsedFlag.get(function) ){
                function.removeSelf();
            }
        }
    }


    private void cleanUp() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() ) continue;

            HashMap<Integer,Integer> memoryMap = new HashMap<>();
            ArrayList<Instruction> criticalInstructions = new ArrayList<>();
            ArrayList<Instruction> usefulInstructions = new ArrayList<>();

            // 第一阶段: 初始化critical_inst
            ArrayList<BasicBlock> basicBlocks = function.getBasicBlocksArray();
            for (BasicBlock basicBlock : basicBlocks) {
                ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof Ret ){
                        criticalInstructions.add(instruction);
                    } else if( instruction instanceof Call call){
                        if( !(is_pure.containsKey(call.getFunction()) && is_pure.get(call.getFunction())) || call.getFunction().getIsBuiltIn() ){
                            criticalInstructions.add(instruction);
                        }
                    } else if( instruction instanceof Store){
                        criticalInstructions.add(instruction);
                    } else if( instruction instanceof Br){
                        criticalInstructions.add(instruction);
                    } else if( instruction instanceof MemoryInstruction ){
                        criticalInstructions.add(instruction);
                    }
                }
            }

            // 第二阶段: mark所有的有用的指令
            int i = 0;
            while(i < criticalInstructions.size()){
                Instruction instruction = criticalInstructions.get(i);
                usefulInstructions.add(instruction);

                for(Value value : instruction.getOperators()){
                    if( value instanceof Instruction inst ){
                        if( !criticalInstructions.contains(inst) ){
                            criticalInstructions.add(inst);
                        }
                    }
                }
                i++;
            }

            // 第三阶段: 删除所有没有mark的指令
            for( BasicBlock basicBlock : basicBlocks ){
                ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
                for( Instruction instruction : instructions ){
                    if( !usefulInstructions.contains(instruction) ){
                        instruction.removeSelf();
                    }
                }
            }
        }
    }
}

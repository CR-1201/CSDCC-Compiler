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

/**
 @author Conroy
 this pass used after pure function mark
 该pass思想:找到所有的critical inst,然后根据def和use反推所有有用的指令,没有用的指令全部删除
 什么是critical inst?
 (1) 输入输出算critical inst,这里也就是call lib function
 (2) 函数 return
 (3) mem store,该mem值的是外界mem,既非本函数栈帧的空间,比如全局变量,全局数组,数组函数参数
 (4) 对于call 方法,如果该函数不是pure,则算effective inst
 (5) Branch指令,Jump指令
*/

public class InstructionCleanUp implements Pass {
    private final Module module = Module.getModule();

    private HashMap<Function, Boolean> is_pure = new HashMap<>();
    @Override
    public void run() {
        PureFunction pureFunction = new PureFunction();
        pureFunction.markPure();
        this.is_pure = pureFunction.isPure;

        cleanUp();
    }

    // 对于内存修改, 因为删除不仅影响函数内部, 还影响外部函数
    // 比如a在内存写了一个1, b函数load出来然后输出了, 所以内存写入都不能删除
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

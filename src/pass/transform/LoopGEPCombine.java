package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import pass.Pass;
import utils.Pair;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import static ast.Node.builder;
import static utils.IOFunc.output;

/*
i32* %a = getelementptr &([1 * i32]* %x)[i32 0][i32 %i1];
i32 %i2 = add i32 %i1, i32 1;
i32* %b = getelementptr &([1 * i32]* %x)[i32 0][i32 %i2];
-->
i32* %a = getelementptr &([1 * i32]* %x)[i32 0][i32 %i1];
i32* %b = getelementptr &([1 * i32]* %a)[i32 1];
*/

public class LoopGEPCombine implements Pass {
    // 循环展开后,连续下标的GEP肯定在一个块内
    private final Module module = Module.getModule();

    // 便于有序遍历,  GEP->curGEP | Value->base | Integer->offset
    private LinkedHashMap<GEP, Pair<Value,Integer>> GEPCombineMap = new LinkedHashMap<>();
    // String->part hash | Value->prevGEP | Integer->last offset
    private HashMap<String, Pair<Value,Integer>> prevGEP = new HashMap<>();

    private ArrayList<GEP> deleteList = new ArrayList<>();
    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            runOnFunction(function);
        }
    }

    private void runOnFunction(Function function) {
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            runOnBasicBlock(block);
        }
    }

    private void runOnBasicBlock(BasicBlock block) {
        GEPCombineMap.clear();
        prevGEP.clear();
        deleteList.clear();
        ArrayList<Instruction> instructions = block.getInstructionsArray();
        for (Instruction instruction : instructions) {
            if (instruction instanceof GEP gep) {
                int n = gep.getNumOfOps();
                Value value = gep.getOperator(n-1);
                if( value instanceof ConstInt constInt){
                    String hash = setGEPHash(gep);
                    if(!prevGEP.containsKey(hash)){
                        prevGEP.put(hash, new Pair<>(gep,constInt.getValue()));
                    } else {
                        Value prevGep = prevGEP.get(hash).getFirst();
                        int offset = prevGEP.get(hash).getSecond();
                        prevGEP.put(hash, new Pair<>(gep,constInt.getValue()));
                        GEPCombineMap.put(gep, new Pair<>(prevGep,constInt.getValue()-offset));
                    }
                }
            }
        }

        List<GEP> keysList = new ArrayList<>(GEPCombineMap.keySet());
        for( int i = keysList.size()-1; i >= 0; i--){
            GEP gep = keysList.get(i);

            Value base = GEPCombineMap.get(gep).getFirst();
            int offset = GEPCombineMap.get(gep).getSecond();
            ArrayList<Value> indexes = new ArrayList<>();
            indexes.add(new ConstInt(offset));
            GEP newGEP = builder.buildGEPBeforeInst(gep.getParent(),base,indexes,gep);

            gep.replaceAllUsesWith(newGEP);
            deleteList.add(gep);
        }

        for (GEP gep : deleteList) {
            gep.removeSelf();
        }

    }

    public String setGEPHash(GEP gep){
        StringBuilder s = new StringBuilder("getelementptr inbounds " + gep.getBaseType() + ", ");
        int n = gep.getNumOfOps();
        for (int i = 0; i < n-1; i++){
            s.append(gep.getOperator(i).getValueType()).append(" ").append(gep.getOperator(i).getName());
            if( i+1 < n-1 )s.append(", ");
        }
        return s.toString();
    }
}

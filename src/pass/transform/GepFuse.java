package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import pass.Pass;

import java.util.ArrayList;

/**
 @author Conroy
 GepFuse后的每个gepInst都应该是针对数组进行gep
 */
public class GepFuse implements Pass{
    private final Module module = Module.getModule();
    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( !function.getIsBuiltIn() ){
                runGepFuse(function);
            }
        }
    }

    private void runGepFuse(Function function){
        //  删除%x = gep target 0的情况
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( instruction instanceof GEP gep && checkGep(gep) ){
                    gep.replaceAllUsesWith(gep.getBase());
                    gep.removeSelf();
                }
            }
        }

        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( instruction instanceof GEP gep && gep.getBase() instanceof GEP preGep ){
                    if( canFuse(preGep,gep) ){
                        fuse(preGep,gep);
                    } else if( canValueFuse(preGep,gep) ){
                        valueFuse(preGep,gep);
                    }
                }
            }
        }
    }

    private void valueFuse(GEP preGep,GEP gep){
        gep.modifyTarget(preGep.getBase());

        ArrayList<Value> preIndexes = preGep.getIndex();
        ArrayList<Value> nowIndexes = gep.getIndex();

        ArrayList<Value> indexes = new ArrayList<>();

        for (int i = 0; i < preIndexes.size() - 1; i++) {
            indexes.add(preIndexes.get(i));
        }

        Value preValue = preIndexes.get(preIndexes.size() - 1);
        Value nowValue = nowIndexes.get(0);

        if( nowValue instanceof ConstInt ){
            int nowConst = ((ConstInt) nowIndexes.get(0)).getValue();
            // 只考虑now gep 的第一维是0的情况
            if( nowConst == 0 ){
                indexes.add(preValue);
            }
        } else if( preValue instanceof ConstInt ){
            int preConst = ((ConstInt) preValue).getValue();
            if( preConst == 0 ){
                indexes.add(nowValue);
            }
        } else return;

        for(int i = 1; i < nowIndexes.size(); i++){
            indexes.add(nowIndexes.get(i));
        }

        gep.modifyIndexes(indexes);

        if( preGep.getUsers().isEmpty() ){
            preGep.removeSelf();
        }
    }

    private void fuse(GEP preGep,GEP gep){
        gep.modifyTarget(preGep.getBase());

        ArrayList<Value> preIndexes = preGep.getIndex();
        ArrayList<Value> nowIndexes = gep.getIndex();

        ArrayList<Value> indexes = new ArrayList<>();

        for (int i = 0; i < preIndexes.size() - 1; i++) {
            indexes.add(preIndexes.get(i));
        }

        int preConst = ((ConstInt) preIndexes.get(preIndexes.size()-1)).getValue();
        int nowConst = ((ConstInt) nowIndexes.get(0)).getValue();

        indexes.add(new ConstInt(preConst + nowConst));

        for(int i = 1; i < nowIndexes.size(); i++){
            indexes.add(nowIndexes.get(i));
        }

        gep.modifyIndexes(indexes);

        if( preGep.getUsers().isEmpty() ){
            preGep.removeSelf();
        }
    }

    private boolean checkGep(GEP gep){
        if( gep.getIndex().size() > 1 )return false;

        Value value = gep.getIndex().get(0);
        return value instanceof ConstInt constInt && constInt.getValue() == 0;
    }

    private boolean canFuse(GEP preGep, GEP gep){
        Value preLastValue = preGep.getIndex().get(preGep.getIndex().size() - 1);
        Value nowFirstValue = gep.getIndex().get(0);

        return preLastValue instanceof Constant && nowFirstValue instanceof Constant;
    }

    private boolean canValueFuse(GEP preGep, GEP gep){
        Value preLastValue = preGep.getIndex().get(preGep.getIndex().size() - 1);
        Value nowFirstValue = gep.getIndex().get(0);

        return preLastValue instanceof Constant || nowFirstValue instanceof Constant;
    }
}

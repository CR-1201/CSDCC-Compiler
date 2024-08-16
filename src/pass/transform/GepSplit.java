package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import pass.Pass;

import java.util.ArrayList;

import static ast.Node.builder;

public class GepSplit implements Pass {

    private final Module module = Module.getModule();
    private ArrayList<GEP> Geps = new ArrayList<>();

    @Override
    public void run() {
        GepSpill();
        removeUselessGEP();
    }

    private void GepSpill() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof GEP gep && gep.getIndex().size() > 2 ){
                        Geps.add(gep);
                    }
                }
            }
        }
        if( Geps.size() <= 700 ){
            for (GEP gep : Geps) {
                split(gep);
            }
        }
    }

    private void split(GEP gep) {
        ArrayList<Value> indexes = new ArrayList<>(gep.getIndex().subList(2, gep.getIndex().size()));
        Value ptr = gep.getBase();
        Instruction pos = gep;
        ArrayList<Value> preIndexes = new ArrayList<>();
        preIndexes.add(gep.getIndex().get(0));
        preIndexes.add(gep.getIndex().get(1));

        Instruction preOffset = builder.buildGEPAfterInst(pos.getParent(),ptr,preIndexes,pos);

        pos = preOffset;
        ptr = preOffset;
        for(Value index : indexes){
            ArrayList<Value> tempIndexes = new ArrayList<>();
            tempIndexes.add(new ConstInt(0));
            tempIndexes.add(index);
            GEP tempGep = builder.buildGEPAfterInst(pos.getParent(),ptr,tempIndexes,pos);
            pos = tempGep;
            ptr = tempGep;
        }

        gep.replaceAllUsesWith(pos);
        // FIXME 这里需要加吗
        gep.removeSelf();
    }


    private void removeUselessGEP() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof GEP gep && canRemove(gep) ){
                        gep.replaceAllUsesWith(gep.getBase());
                        gep.removeSelf();
                    }
                }
            }
        }
    }

    private boolean canRemove(GEP gep){
        if( gep.getIndex().size() > 1 ){
            return false;
        }

        Value value = gep.getIndex().get(0);
        return value instanceof ConstInt constInt && constInt.getValue() == 0 ;
    }


}

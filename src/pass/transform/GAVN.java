package pass.transform;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import pass.Pass;
import pass.analysis.Dom;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

/**
 @author Conroy
 Global Array Value Numbering: 将数组的load进行GVN(其实不是GVN,实际作用LVN< this < SVN < GVN)
 */
public class GAVN implements Pass {
    private final Module module = Module.getModule();
    // 记录指针与其loadInst的映射关系
    HashMap<Value, Value> GAVNMap = new HashMap<>();
    HashSet<GEP> canGAVN = new HashSet<>();
    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for(Function function :  functions){
            Dom dom = new Dom();
            dom.buildDom(function);

            // 针对指针没有store的情况
            simpleGVN(function);

            arrayGVN(function);
        }
    }

    private void simpleGVN(Function function) {
        GAVNMap.clear();
        canGAVN.clear();
        initCanGAVN(function);
        RPOSearch(function.getFirstBlock());
    }

    private void arrayGVN(Function function) {
        ArrayList<BasicBlock> basicBlocks = function.getBasicBlocksArray();
        for(BasicBlock basicBlock : basicBlocks){
            GAVNMap.clear();
            addLoad(basicBlock);
            for( BasicBlock son : basicBlock.getIdoms()){
                if( basicBlock.getSuccessors().contains(son)){
                    replaceLoad(son);
                    for( BasicBlock sonSon : son.getIdoms()){
                        if( son.getSuccessors().contains(sonSon)){
                            replaceLoad(sonSon);
                        }
                    }
                }
            }
        }
    }

    private void addLoad(BasicBlock basicBlock) {
        ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
        for(Instruction instruction : instructions){
            if(instruction instanceof Load load){
                if( GAVNMap.containsKey(load.getAddr()) ){
                    load.replaceAllUsesWith(GAVNMap.get(load.getAddr()));
                } else {
                    GAVNMap.put(load.getAddr(), load);
                }
            } else if( instruction instanceof Store store){
                GAVNMap.remove(store.getAddr());
            }
        }
    }

    private void replaceLoad(BasicBlock basicBlock) {
        HashMap<Value,Value> tempRemoves = new HashMap<>();
        ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
        for( Instruction instruction : instructions){
            if( instruction instanceof Load load && GAVNMap.containsKey(load.getAddr()) ){
                load.replaceAllUsesWith(GAVNMap.get(load.getAddr()));
                load.eraseFromParent();
            } else if( instruction instanceof Store store ){
                Value key = store.getAddr();
                if( GAVNMap.containsKey(key) ){
                    Value value = GAVNMap.get(key);
                    tempRemoves.put(key, value);
                    GAVNMap.remove(key);
                }
            }
        }

        for(Value key : tempRemoves.keySet()){
            GAVNMap.put(key, tempRemoves.get(key));
        }
    }

    private void initCanGAVN(Function function) {
        ArrayList<GEP> geps = new ArrayList<>();
        ArrayList<BasicBlock> basicBlocks = function.getBasicBlocksArray();

        for( BasicBlock basicBlock : basicBlocks ){
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for( Instruction instruction : instructions ){
                if( instruction instanceof GEP gep){
                    geps.add(gep);
                }
            }
        }

        for( GEP gep : geps ){
            boolean storeFlag = false;
            for( User user : gep.getUsers() ){
                if( user instanceof Store store){
                    storeFlag = true;
                    break;
                }
            }
            if( storeFlag ){
                canGAVN.add(gep);
            }
        }
    }

    private void RPOSearch(BasicBlock basicBlock) {
        ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
        HashSet<Load> numberedInstructions = new HashSet<>();

        for( Instruction instruction : instructions ){
            if( instruction instanceof Load load && load.getAddr() instanceof GEP gep && canGAVN.contains(gep) ){
                boolean isNumbered = loadGAVN(load);
                if( isNumbered ){
                    numberedInstructions.add(load);
                }
            }
        }

        for( BasicBlock idom : basicBlock.getIdoms() ){
            RPOSearch(idom);
        }

        for( Load load : numberedInstructions ){
            GAVNMap.remove(load.getAddr());
        }
    }

    private boolean loadGAVN(Load load) {
        if( GAVNMap.containsKey(load.getAddr()) ){
            load.replaceAllUsesWith(GAVNMap.get(load.getAddr()));
            load.eraseFromParent();
            return false;
        }

        GAVNMap.put(load.getAddr(), load);
        return true;
    }
}

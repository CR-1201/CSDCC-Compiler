package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import pass.Pass;
import pass.analysis.PureFunction;

import java.util.ArrayList;
import java.util.HashMap;

public class Peephole implements Pass {

    private final Module module = Module.getModule();

    // storeAddr-storeInst Map
    private final HashMap<Value,Value> addr2store = new HashMap<>();
    private HashMap<String, GEP> GEPMap = new HashMap<>();
    private HashMap<Function, Boolean> is_pure = new HashMap<>();

    private Load finalLoad = null;
    private ArrayList<Store> stores = new ArrayList<>();
    @Override
    public void run() {
        PureFunction pureFunction = new PureFunction();
        pureFunction.markPure();
        this.is_pure = pureFunction.isPure;
        // store后紧接着的load,可以消掉load
        Peephole1();

        // store的值如果和load出来的值一样,且路径上没有对该地址load,可以删除路径上所有对该地址的store
        Peephole2();
    }

    private void Peephole2(){
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            runPeephole2OnFunction(function);
        }
    }

    private void runPeephole2OnFunction(Function function){
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock basicBlock : blocks) {
            stores.clear();
            finalLoad = null;
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( instruction instanceof Load load ){
                    finalLoad = load;
                    stores.clear();
                } else if( instruction instanceof Store store ){
                    if( finalLoad == null ){
                        continue;
                    }
                    if( store.getAddr().equals(finalLoad.getAddr()) ){
                        stores.add(store);
                    }
                    if( store.getValue().equals(finalLoad) ){
                        deleteStore();
                    }
                }
            }
        }
    }
    private void deleteStore(){
        for(Store store : stores){
            store.removeSelf();
        }
        stores.clear();
    }

    private void Peephole1() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            BasicBlock entry = function.getFirstBlock();
            RPOSearch(entry);
        }
    }

    private void RPOSearch(BasicBlock block) {
        GEPMap.clear();
        addr2store.clear();
        ArrayList<Instruction> instructions = block.getInstructionsArray();
        for (Instruction instruction : instructions) {
            if( instruction instanceof Store store ){
                if( mysteriousStore(store.getAddr()) ){
                    addr2store.clear();
                } else addr2store.put(store.getAddr(), store);
            } else if( instruction instanceof Load load ){
                if( addr2store.containsKey(load.getAddr()) ){
                    Store store = (Store) addr2store.get(load.getAddr());
                    load.replaceAllUsesWith(store.getValue());
                    load.removeSelf();
                }
            } else if( instruction instanceof Call call && !(is_pure.containsKey(call.getFunction()) && is_pure.get(call.getFunction()))){
                //保守起见 碰到call非纯函数就清空
                addr2store.clear();
            } else if( instruction instanceof GEP gep){
                String hash = setHashValue(gep);
                if( GEPMap.containsKey(hash) ){
                    gep.replaceAllUsesWith(GEPMap.get(hash));
                    gep.removeSelf();
                } else GEPMap.put(hash, gep);
            }
        }

        for(BasicBlock idom : block.getIdoms()){
            RPOSearch(idom);
        }

    }

    private ArrayList<BasicBlock> getBlocksRank(Function function) {
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        ArrayList<BasicBlock> blocksRank = new ArrayList<>();
        for (BasicBlock block : blocks) {
            if( block.getSuccessors().isEmpty() ){
                blocksRank.add(block);
            }
        }
        for( int i = 0; i < blocksRank.size(); i++ ){
            for( BasicBlock pre : blocksRank.get(i).getPrecursors() ){
                if( !blocksRank.contains(pre) ){
                    blocksRank.add(pre);
                }
            }
        }
        return blocksRank;
    }

    private boolean mysteriousStore(Value pointer) {
        if( pointer instanceof GEP gep ){
            for( Value value : gep.getIndex() ){
                if( !(value instanceof ConstInt) ){
                    return true;
                }
            }
        }
        return false;
    }

    private String setHashValue(Instruction inst){
        if(inst instanceof GEP gepInst){
            StringBuilder hashBuilder = new StringBuilder(gepInst.getBase().getName());
            ArrayList<Value> indexs = gepInst.getIndex();
            for (Value index : indexs) {
                hashBuilder.append("[").append(index.getName()).append("]");
            }
//            System.out.println(hashBuilder);
            return hashBuilder.toString();
        }
        return null;
    }
}

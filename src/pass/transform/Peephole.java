package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import pass.Pass;
import pass.analysis.Dom;
import pass.analysis.PureFunction;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

public class Peephole implements Pass {

    private final Module module = Module.getModule();

    // storeAddr-storeInst Map
    private final HashMap<Value,Value> addr2store = new HashMap<>();
    private HashMap<String, GEP> GEPMap = new HashMap<>();
    private HashMap<Function, Boolean> is_pure = new HashMap<>();
    private Dom dom = new Dom();
    @Override
    public void run() {
        PureFunction pureFunction = new PureFunction();
        pureFunction.markPure();
        this.is_pure = pureFunction.is_pure;
        // store后紧接着的load,可以消掉load
        Peephole1();
    }

    private void Peephole1() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            GEPMap.clear();
            dom.buildDom(function);
            ArrayList<BasicBlock> blocks = dom.getDomTreePostOrder(function);
            Collections.reverse(blocks);
            for (BasicBlock block : blocks) {
                addr2store.clear();
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof Store store ){
                        if( mysteriousStore(store.getAddr()) ){
                            addr2store.clear();
                        } else addr2store.put(store.getAddr(), store);
                    } else if( instruction instanceof Load load ){
                        if( mysteriousStore(load.getAddr()) ){
                            addr2store.clear();
                        } else if( addr2store.containsKey(load.getAddr()) ){
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
            }
        }
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

package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashMap;

public class Peephole implements Pass {

    private final Module module = Module.getModule();

    // storeAddr-storeInst Map
    private HashMap<Value,Value> addr2store = new HashMap<>();
    @Override
    public void run() {
        // store后紧接着的load,可以消掉load
        Peephole1();
    }

    private void Peephole1() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                addr2store.clear();
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof Store store ){
                        addr2store.put(store.getAddr(), store);
                    }
                    if( instruction instanceof Load load ){
                        if( addr2store.containsKey(load.getAddr()) ){
                            Store store = (Store) addr2store.get(load.getAddr());
                            load.replaceAllUsesWith(store.getValue());
                            load.removeSelf();
                        }
                    }
                }
            }
        }
    }
}

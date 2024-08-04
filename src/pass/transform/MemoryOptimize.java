package pass.transform;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Ret;
import pass.Pass;
import pass.analysis.Dom;

import java.util.*;

/**
 * 之前做了全局变量局部化的操作，但是那部分仅仅只局限于只在 main 函数中使用的全局变量，
 * 因此，现在进行另一个全局变量临时局部化的思路，针对于任何函数。
 */
public class MemoryOptimize implements Pass {
    private final IrBuilder irBuilder = new IrBuilder();
    private final Dom dom = new Dom();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                memoryOptimize(function);
            }
        }
    }

    private void memoryOptimize(Function function) {
        dom.buildDom(function);
//        tmpLocalizeGV(function);
        emitRedundantLoad(function);
    }

    private void tmpLocalizeGV(Function function) {
        HashMap<GlobalVariable, Value> gv2value = new HashMap<>();
        HashMap<GlobalVariable, Value> gvLocalized = new HashMap<>();
        BasicBlock entryBlock = function.getFirstBlock();
        Stack<BasicBlock> stack = new Stack<>();
        stack.push(entryBlock);
        HashSet<BasicBlock> visited = new HashSet<>();
        while (!stack.empty()) {
            BasicBlock block = stack.pop();
            if (visited.contains(block)) {
                continue;
            }
            visited.add(block);
            ArrayList<Instruction> insts = block.getInstructionsArray();
            for (Instruction inst : insts) {
                if (inst instanceof Load load && load.getAddr() instanceof GlobalVariable gv) {
                    if (!gv2value.containsKey(gv)) {
                        gv2value.put(gv, load);
                    } else {
                        load.replaceAllUsesWith(gv2value.get(gv));
                        load.removeSelf();
                    }
                } else if (inst instanceof Store store && store.getAddr() instanceof GlobalVariable gv) {
                    gv2value.put(gv, store.getValue());
                    gvLocalized.put(gv, store.getValue());
                    store.removeSelf();
                } else if (inst instanceof Call call) {
                    for (Map.Entry<GlobalVariable, Value> entry : gvLocalized.entrySet()) {
                        irBuilder.buildStoreBeforeInstr(block, entry.getValue(), entry.getKey(), call);
                    }
                    gv2value.clear();
                    gvLocalized.clear();
                } else if (inst instanceof Ret ret && !block.getName().equals("@main")) {
                    for (Map.Entry<GlobalVariable, Value> entry : gvLocalized.entrySet()) {
                        irBuilder.buildStoreBeforeInstr(block, entry.getValue(), entry.getKey(), ret);
                    }
                    gv2value.clear();
                    gvLocalized.clear();
                }
            }
            for (BasicBlock idom : block.getIdoms()) {
                if (!visited.contains(idom)) {
                    stack.push(idom);
                }
            }
        }
    }

    private void emitRedundantLoad(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            Map<Value, Value> addr2value = new HashMap<>();
            ArrayList<Instruction> insts = block.getInstructionsArray();
            for (Instruction inst : insts) {
                if (inst instanceof Load load) {
                    Value addr = load.getAddr();
                    if (!addr2value.containsKey(addr)) {
                        addr2value.put(addr, load);
                    } else {
                        load.replaceAllUsesWith(addr2value.get(addr));
                        load.removeSelf();
                    }
                } else if (inst instanceof Store storeInst) { // 内存变动
                    addr2value.clear();
                    addr2value.put(storeInst.getAddr(), storeInst.getValue());
                } else if (inst instanceof Call) { // 控制流转移
                    addr2value.clear();
                }
            }
        }
    }
}

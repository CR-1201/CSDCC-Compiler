package pass.transform.emituseless;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.PointerType;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * mq：
 * 这里有一点草率，不是很彻底。
 */
public class UselessStoreEmit implements Pass {
    @Override
    public void run() {
        for (Function func : Module.getModule().getFunctionsArray()) {
            if (!func.getIsBuiltIn()) {
                emit(func);
            }
        }
    }

    /**
     * 在再一次可能的使用之前，如果出现了对一个地址重复 store 的情况，那么这个 inst 就是可以被消灭的。
     * @param func 进行无用 store 指令消除的函数
     */
    private void emit(Function func) {
        HashMap<Value, Store> storeAddress = new HashMap<>();
        for (BasicBlock block : func.getBasicBlocksArray()) {
            ArrayList<Instruction> insts = new ArrayList<>(block.getInstructions());
            storeAddress.clear();
            for (Instruction inst : insts) {
                if (inst instanceof Store si) {
                    Value pointer = si.getAddr();
                    if (storeAddress.containsKey(pointer)){
                        Store emitInst = storeAddress.get(pointer);
                        emitInst.removeSelf();
                    }
                    storeAddress.put(pointer, si);
                } else if (potentialUse(inst)) {
                    storeAddress.clear();
                }
            }
        }
    }

    private boolean potentialUse(Instruction inst){
        if (inst instanceof Alloca || inst instanceof BinaryInstruction || inst instanceof Br || inst instanceof Conversion || inst instanceof Phi || inst instanceof Ret) {
            return false;
        }
        if(inst instanceof GEP || inst instanceof Load || inst instanceof Store) {
            return true;
        }
        if (inst instanceof Call ci) {
            for (Value value : ci.getOperators()) {
                if (value.getValueType() instanceof PointerType) {
                    return true;
                }
            }
            if (ci.getFunction().equals(inst.getParent().getParent())) {
                return true;
            }
            return ci.getFunction().getSideEffect();
        }
        return false;
    }

}

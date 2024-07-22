package pass.utility;

import ir.BasicBlock;
import ir.IrBuilder;
import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.Load;

import java.util.HashMap;

public class CloneUtil {
    private IrBuilder irBuilder = new IrBuilder();
    /**
     *  旧 Value 到新 Value 的映射
     */
    private HashMap<Value, Value> cloneMap = new HashMap<>();
    public void cloneBlock(BasicBlock source, BasicBlock target) {
        for (Instruction oldInst : source.getInstructions()) {
            Instruction newInst = cloneInst(oldInst);
            target.insertTail(newInst);
            cloneMap.put(oldInst, newInst);
        }
    }
    public Instruction cloneInst(Instruction oldInst) {
        Instruction newInst = null;
        if (oldInst instanceof Alloca ai) {
//            alloca 指令的情况可以先不管，因为指令一定是放在第一个块，而第一个块肯定是无法进行展开的
//            if (ai.isArray()) {
//
//            } else {
//
//            }
        } else if (oldInst instanceof Load li) {
//            newInst = irBuilder
        }
        return null;
    }

    public Value findValue(Value value) {
        if (value instanceof ConstInt || value instanceof ConstFloat) {
            return value;
        } else {
            if (cloneMap.get(value) != null) {
                return cloneMap.get(value);
            } else {
                return value;
            }
        }
    }

    public void insertCloneMap(Value key, Value value) {
        cloneMap.put(key, value);
    }
}

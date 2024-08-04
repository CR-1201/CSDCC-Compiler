package pass.utility;

import ir.BasicBlock;
import ir.IrBuilder;
import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.*;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.*;

import java.util.ArrayList;
import java.util.HashMap;

public class CloneUtil {
    private IrBuilder irBuilder = new IrBuilder();
    /**
     *  旧 Value 到新 Value 的映射
     */
    private HashMap<Value, Value> cloneMap = new HashMap<>();
    public void cloneBlock(BasicBlock source, BasicBlock target) {
        for (Instruction oldInst : source.getInstructionsArray()) {
            Instruction newInst = cloneInst(target, oldInst);
            cloneMap.put(oldInst, newInst);
        }
    }
    public Instruction cloneInst(BasicBlock target, Instruction oldInst) {
        Instruction clonedInst = null;
        if (oldInst instanceof Alloca ai) {
//            alloca 指令的情况可以先不管，因为指令一定是放在第一个块，而第一个块肯定是无法进行展开的
//            if (ai.isArray()) {
//
//            } else {
//
//            }
        } else if (oldInst instanceof Load li) {
            clonedInst = irBuilder.buildLoad(target, findValue(li.getAddr()));
        } else if (oldInst instanceof Store si) {
            Value value = findValue(si.getValue());
            Value addr = findValue(si.getAddr());
            clonedInst = irBuilder.cloneStore(target, value, addr);
        } else if (oldInst instanceof GEP gi) {
            ArrayList<Value> values = new ArrayList<>();
            for (int i = 0; i < gi.getIndex().size(); i++) {
                values.add(findValue(gi.getIndex().get(i)));
            }
            Value base = findValue(gi.getBase());
            ValueType dataType = ((PointerType) gi.getBase().getValueType()).getPointeeType();
            while (dataType instanceof ArrayType arrayType) {
                dataType = arrayType.getElementType();
            }
            if (values.size() == 1) {
                clonedInst = irBuilder.buildGEP(target, base, values.get(0));
            } else if (values.size() == 2) {
                clonedInst = irBuilder.buildGEP(target, base, values.get(0), values.get(1));
            } else {
                clonedInst = irBuilder.buildGEP(target, new PointerType(dataType), base, values);
            }
        } else if (oldInst instanceof Phi phi) {
            clonedInst = irBuilder.buildPhi((DataType) phi.getValueType(), target, phi.getPrecursorNum());
        } else if (oldInst instanceof Br br) {
            if (br.getHasCondition()) {
                clonedInst = irBuilder.buildBr(target,
                        findValue(br.getCond()),
                        (BasicBlock) findValue(br.getTrueBlock()),
                        (BasicBlock) findValue(br.getFalseBlock()));
            } else {
                clonedInst = irBuilder.buildBr(target,
                        (BasicBlock) findValue(br.getOperator(0)));
            }
        } else if (oldInst instanceof Ret ri) {
            if (ri.getValueType() instanceof VoidType) {
                clonedInst = irBuilder.buildRet(target);
            } else {
                clonedInst = irBuilder.buildRet(target, findValue(ri.getRetValue()));
            }
        } else if (oldInst instanceof Call ci) {
            ArrayList<Value> args = new ArrayList<>();
            for (int i = 0; i < ci.getArgs().size(); i++) {
                args.add(findValue(ci.getArgs().get(i)));
            }
            clonedInst = irBuilder.buildCall(target, ci.getFunction(), args);
        } else if (oldInst instanceof BinaryInstruction bi) {
            Value left = findValue(bi.getOp1());
            Value right = findValue(bi.getOp2());
            DataType type = (DataType) bi.getValueType();
            if (bi instanceof Add) {
                clonedInst = irBuilder.buildAdd(target, type, left, right);
            } else if (bi instanceof Sub) {
                clonedInst = irBuilder.buildSub(target, type, left, right);
            } else if (bi instanceof Mul) {
                clonedInst = irBuilder.buildMul(target, type, left, right);
            } else if (bi instanceof Sdiv) {
                clonedInst = irBuilder.buildSdiv(target, type, left, right);
            } else if (bi instanceof Srem) {
                clonedInst = irBuilder.buildSrem(target, type, left, right);
            } else if (bi instanceof Icmp) {
                Icmp.Condition cond = ((Icmp) bi).getCondition();
                clonedInst = irBuilder.buildIcmp(target, cond, left, right);
            }
        } else if (oldInst instanceof Conversion ci) {
            clonedInst = irBuilder.buildConversion(target,
                    ci.getType(),
                    (DataType) ci.getValueType(),
                    findValue(ci.getConversionValue()));
        } else if (oldInst instanceof BitCast bi) {
            clonedInst = irBuilder.buildBitCast(target, (DataType) bi.getValueType(),
                    findValue(bi.getConversionValue()));
        } else if (oldInst instanceof Zext zi) {
            clonedInst = irBuilder.buildZext(target, findValue(zi.getConversionValue()));
        }
        return clonedInst;
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
    public void clearCloneMap() {
        cloneMap.clear();
    }
}

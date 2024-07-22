package pass.utiles;

import ir.*;
import ir.constants.Constant;
import ir.instructions.binaryInstructions.*;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.otherInstructions.Zext;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.DataType;
import ir.types.IntType;
import ir.instructions.Instruction;
import ir.types.PointerType;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.memoryInstructions.Load;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class FunctionClone {

    private final HashMap<Value, Value> copyMap = new HashMap<>();

    private final HashSet<BasicBlock> visited = new HashSet<>();

    private final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    private final ArrayList<Phi> phis = new ArrayList<>();

    public Function copyFunction(Function srcFunc) {
        copyMap.clear();
        visited.clear();
        phis.clear();

        Function copyFunc = new Function(srcFunc.getName() + "_COPY", srcFunc.getValueType(), srcFunc.getIsBuiltIn());

        int argNum = srcFunc.getArguments().size();
        for (int i = 0; i < argNum; i++) {
            Argument argument = srcFunc.getArguments().get(i);
            putValue(argument, copyFunc.getArguments().get(i));
        }
        for (BasicBlock srcBlock : srcFunc.getBasicBlocksArray()) {
            putValue(srcBlock, irBuilder.buildBasicBlock(copyFunc));
        }

        copyBlocks(srcFunc.getFirstBlock());

        for (Phi phi : phis) {
            for (int i = 0; i < phi.getOperators().size(); i++) {
                Value v = findValue(phi.getOperator(i));
                ((Phi) findValue(phi)).setOperator(i, v);
                findValue(phi.getOperator(i)).addUser(((Phi) findValue(phi)));
            }
        }

        return copyFunc;
    }

    private void putValue(Value source, Value copy) {
        copyMap.put(source, copy);
    }

    private Value findValue(Value source) {
        if (source instanceof GlobalVariable || source instanceof Constant || source instanceof Function) {
            return source;
        } else if (copyMap.containsKey(source) && copyMap.get(source) != null) {
            return copyMap.get(source);
        } else {
            assert false : "Don't have copy source: " + source;
            return Constant.getZeroConstant(IntType.I32);
        }
    }

    private void copyBlocks(BasicBlock basicBlock) {
        for (Instruction srcInstr : basicBlock.getInstructionsArray()) {
            Instruction copyInstr = copyInstr(srcInstr);
            putValue(srcInstr, copyInstr);
        }

        for (BasicBlock successor : basicBlock.getSuccessors())
        {
            if (!visited.contains(successor))
            {
                visited.add(successor);
                copyBlocks(successor);
            }
        }
    }

    private Instruction copyInstr(Instruction srcInstr) {
        Instruction copyInstr = null;
        BasicBlock copyBlock = (BasicBlock) findValue(srcInstr.getParent());

        if (srcInstr instanceof BinaryInstruction)
        {
            Value copyOp1 = findValue(((BinaryInstruction) srcInstr).getOp1());
            Value copyOp2 = findValue(((BinaryInstruction) srcInstr).getOp2());
            if (srcInstr instanceof Add)
            {
                copyInstr = irBuilder.buildAdd(copyBlock, (DataType) copyOp1.getValueType(), copyOp1, copyOp2);
            }
            else if (srcInstr instanceof Sub)
            {
                copyInstr = irBuilder.buildSub(copyBlock, (DataType) copyOp1.getValueType(), copyOp1, copyOp2);
            }
            else if (srcInstr instanceof Mul)
            {
                copyInstr = irBuilder.buildMul(copyBlock, (DataType) copyOp1.getValueType(), copyOp1, copyOp2);
            }
            else if (srcInstr instanceof Sdiv)
            {
                copyInstr = irBuilder.buildSdiv(copyBlock, (DataType) copyOp1.getValueType(), copyOp1, copyOp2);
            }
            else if (srcInstr instanceof Srem)
            {
                copyInstr = irBuilder.buildSrem(copyBlock, (DataType) copyOp1.getValueType(), copyOp1, copyOp2);
            }
            else if (srcInstr instanceof Icmp)
            {
                copyInstr = irBuilder.buildIcmp(copyBlock, ((Icmp) srcInstr).getCondition(), copyOp1, copyOp2);
            }
        } else if (srcInstr instanceof Zext) {
            copyInstr = irBuilder.buildZext(copyBlock, findValue(((Zext) srcInstr).getConversionValue()));
        } else if (srcInstr instanceof Phi) {
            copyInstr = irBuilder.buildPhi((DataType) srcInstr.getValueType(), copyBlock, ((Phi) srcInstr).getPrecursorNum());
            phis.add((Phi) srcInstr);
        } else if (srcInstr instanceof Load) {
            copyInstr = irBuilder.buildLoad(copyBlock, findValue(((Load) srcInstr).getAddr()));
        } else if (srcInstr instanceof Store) {
            irBuilder.buildStore(copyBlock, findValue(((Store) srcInstr).getValue()), findValue(((Store) srcInstr).getAddr()));
        } else if (srcInstr instanceof Alloca) {
            copyInstr = irBuilder.buildALLOCA(((PointerType) srcInstr.getValueType()).getPointeeType(), copyBlock);
        } else if (srcInstr instanceof GEP) {
            ArrayList<Value> copyIndices = new ArrayList<>();
            for (Value index : ((GEP) srcInstr).getIndex()) {
                copyIndices.add(findValue(index));
            }
            Value copyBase = findValue(((GEP) srcInstr).getBase());
            if (copyIndices.size() == 1) {
                copyInstr = irBuilder.buildGEP(copyBlock, copyBase, copyIndices.get(0));
            } else {
                copyInstr = irBuilder.buildGEP(copyBlock, copyBase, copyIndices.get(0), copyIndices.get(1));
            }
        } else if (srcInstr instanceof Call) {
            ArrayList<Value> args = new ArrayList<>();
            for (int i = 1; i < srcInstr.getNumOfOps(); i++) {
                args.add(findValue(srcInstr.getOperator(i)));
            }
            copyInstr = irBuilder.buildCall(copyBlock, ((Call) srcInstr).getFunction(), args);
        } else if (srcInstr instanceof Br) {
            if (((Br) srcInstr).getHasCondition()) {
                irBuilder.buildBr(copyBlock, findValue(srcInstr.getOperator(0)),
                        (BasicBlock) findValue(srcInstr.getOperator(1)),
                        (BasicBlock) findValue(srcInstr.getOperator(2)));
            } else {
                irBuilder.buildBr(copyBlock, (BasicBlock) findValue(srcInstr.getOperator(0)));
            }
        } else if (srcInstr instanceof Ret) {
            if (srcInstr.getOperators().size() == 0) {
                irBuilder.buildRet(copyBlock);
            } else {
                irBuilder.buildRet(copyBlock, findValue(((Ret) srcInstr).getRetValue()));
            }
        } else if (srcInstr instanceof Conversion conversionInstr) {

            copyInstr = irBuilder.buildConversion(copyBlock, conversionInstr.getType(), (DataType) conversionInstr.getValueType(), findValue(conversionInstr.getConversionValue()));
        }

        return copyInstr;
    }

}

package pass.transform.gcmgvn;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.otherInstructions.BitCast;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.transform.SimplifyInst;
import utils.IOFunc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class GVN {
    private final HashMap<String, Value> GVNMap = new HashMap<>();
    private final HashMap<String, Integer> GVNCnt = new HashMap<>();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                runGVN(function);
            }
        }
        IOFunc.output(Module.getModule().toString(), "checkir/gvn.txt");
    }

    private void runGVN(Function func) {
        clear();
        CFG cfg = new CFG();
        Dom dom = new Dom();
        cfg.buildCFG(func);
        dom.buildDom(func);
        BasicBlock entry = func.getFirstBlock();
        RPOSearch(entry);
    }

    private void RPOSearch(BasicBlock entry) {
        HashSet<Instruction> numberedInsts = new HashSet<>();
        ArrayList<Instruction> insts = new ArrayList<>(entry.getInstructions());
        for (int i = 0; i < insts.size() && insts.get(i) != null; i++) {
            Instruction curInst = insts.get(i);
            if (canGVN(curInst)) {
                boolean isNumbered = checkAndSetGVN(curInst);
                if (isNumbered) {
                    numberedInsts.add(curInst);
                }
            }
        }

        for(BasicBlock idom : entry.getIdoms()){
            RPOSearch(idom);
        }

        for(Instruction inst : numberedInsts){
            removeGvnMap(inst);
        }
    }

    private void clear() {
        GVNMap.clear();
        GVNCnt.clear();
    }

    private boolean canGVN(Instruction inst){
        if(inst instanceof Call ci){
            Function function = ci.getFunction();
            return !function.getIsBuiltIn() && !function.getSideEffect();
        } else if (inst instanceof BinaryInstruction || inst instanceof GEP || inst instanceof Conversion || inst instanceof BitCast) {
            return true;
        }
        return false;
    }

    private void removeGvnMap(Instruction inst){
        String hash = setHashValue(inst);
        GVNMap.remove(hash);
        if (inst instanceof BinaryInstruction binaryInst && isSwapBinary(binaryInst)){
            String swapHash = setSwapBinaryHashValue(binaryInst);
            GVNMap.remove(swapHash);
        }
    }

    private boolean checkAndSetGVN(Instruction inst) {
        if (inst instanceof BinaryInstruction bi) {
            String hash = setHashValue(bi);
            if (GVNMap.containsKey(hash)) {
                inst.replaceAllUsesWith(GVNMap.get(hash));
                inst.removeSelf();
                return false;
            }
            if (isSwapBinary(bi)) {
                String swapHash = setSwapBinaryHashValue(bi);
                if (GVNMap.containsKey(swapHash)) {
                    inst.replaceAllUsesWith(GVNMap.get(swapHash));
                    inst.removeSelf();
                    return false;
                }
                GVNMap.put(hash, inst);
                GVNMap.put(swapHash, inst);
            } else {
                GVNMap.put(hash, inst);
            }
            return true;
        } else if (inst instanceof Call || inst instanceof GEP || inst instanceof Conversion || inst instanceof BitCast) {
            String hash = setHashValue(inst);
            if (GVNMap.containsKey(hash)) {
                inst.replaceAllUsesWith(GVNMap.get(hash));
                inst.removeSelf();
                return false;
            }
            GVNMap.put(hash, inst);
            return true;
        }
        return false;
    }

    private String setHashValue(Instruction inst){
        if(inst instanceof BinaryInstruction binaryInst){
            String leftName = binaryInst.getOp1().getName();
            String op = binaryInst.getOpString();
            String rightName = binaryInst.getOp2().getName();
//            System.out.println(leftName + op + rightName);
            return leftName + op + rightName;
        } else if(inst instanceof Call callInst){
            StringBuilder hashBuilder = new StringBuilder(callInst.getFunction().getName() + "(");
            ArrayList<Value> params = callInst.getArgs();
            for (int i = 0; i < params.size(); i++) {
                hashBuilder.append(params.get(i).getName());
                if (i < params.size() - 1) {
                    hashBuilder.append(", ");
                }
            }
            hashBuilder.append(")");
//            System.out.println(hashBuilder);
            return hashBuilder.toString();
        } else if(inst instanceof GEP gepInst){
            StringBuilder hashBuilder = new StringBuilder(gepInst.getBase().getName());
            ArrayList<Value> indexs = gepInst.getIndex();
            for (Value index : indexs) {
                hashBuilder.append("[").append(index.getName()).append("]");
            }
//            System.out.println(hashBuilder);
            return hashBuilder.toString();
        } else if(inst instanceof Conversion conversionInst) {
//            System.out.println(conversionInst);
            return conversionInst.toString();
        }
        return null;
    }

    private boolean isSwapBinary(Instruction inst){
        if (inst instanceof BinaryInstruction bi) {
            return bi.isCommutative();
        }
        return false;
    }

    private String setSwapBinaryHashValue(BinaryInstruction binaryInst){
        String leftName = binaryInst.getOp1().getName();
        String op = binaryInst.getOpString();
        String rightName = binaryInst.getOp2().getName();
        return rightName + op + leftName;
    }
}

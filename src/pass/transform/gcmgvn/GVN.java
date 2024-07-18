package pass.transform.gcmgvn;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import pass.analysis.Dom;

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
    }

    private void runGVN(Function func) {
        clear();
        Dom dom = new Dom();
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
                boolean isNumbered = runGVNOnInst(curInst);
                if (isNumbered) {
                    numberedInsts.add(curInst);
                }
            }
        }

        for(BasicBlock idom : entry.getIdoms()){
            RPOSearch(idom);
        }

        for(Instruction inst : numberedInsts){
            removeInstFromGVN(inst);
        }
    }

    private void clear() {
        GVNMap.clear();
        GVNCnt.clear();
    }

    private void removeInstFromGVN(Instruction inst){
        String hash = setHashValue(inst);
        GVNMap.remove(hash);
        if(inst instanceof BinaryInstruction binaryInst && isSwapBinary(binaryInst)){
            String hash_2 = setSwapBinaryHashValue(binaryInst);
            GVNMap.remove(hash_2);
        }
    }

    private boolean runGVNOnInst(Instruction inst) {
        if (inst instanceof BinaryInstruction binaryInst) {
            String hash_1 = setHashValue(binaryInst);
            if (GVNMap.containsKey(hash_1)) {
                inst.replaceAllUsesWith(GVNMap.get(hash_1));
                inst.removeAllOperators();
                inst.eraseFromParent();
                return false;
            }
            if (isSwapBinary(binaryInst)) {
                String hash_2 = setSwapBinaryHashValue(binaryInst);
                if (GVNMap.containsKey(hash_2)) {
                    inst.replaceAllUsesWith(GVNMap.get(hash_2));
                    inst.removeAllOperators();
                    inst.eraseFromParent();
                    return false;
                }
                GVNMap.put(hash_1, inst);
                GVNMap.put(hash_2, inst);
            }
            else {
                GVNMap.put(hash_1, inst);
            }
            return true;
        }
        else if (inst instanceof Call || inst instanceof GEP
                || inst instanceof Conversion) {
            String hash = setHashValue(inst);
            if (GVNMap.containsKey(hash)) {
                inst.replaceAllUsesWith(GVNMap.get(hash));
                inst.removeAllOperators();
                inst.eraseFromParent();
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
            return leftName + op + rightName;
        }
        else if(inst instanceof Call callInst){
            StringBuilder hashBuilder = new StringBuilder(callInst.getFunction().getName() + "(");
            ArrayList<Value> params = callInst.getArgs();
            for (int i = 0; i < params.size(); i++) {
                hashBuilder.append(params.get(i).getName());
                if (i < params.size() - 1) {
                    hashBuilder.append(", ");
                }
            }
            hashBuilder.append(")");
            return hashBuilder.toString();
        }
        else if(inst instanceof GEP gepInst){
            StringBuilder hashBuilder = new StringBuilder(gepInst.getBase().getName());
            ArrayList<Value> indexs = gepInst.getIndex();
            for (Value index : indexs) {
                hashBuilder.append("[").append(index.getName()).append("]");
            }
            return hashBuilder.toString();
        }
        else if(inst instanceof Conversion conversionInst) {
            return conversionInst.toString();
        }
        return null;
    }

    private boolean canGVN(Instruction inst){
        if(inst instanceof Call ci){
            Function function = ci.getFunction();
            return !function.getIsBuiltIn() && !function.getSideEffect();
        }
        return inst instanceof BinaryInstruction || inst instanceof GEP || inst instanceof Conversion;
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

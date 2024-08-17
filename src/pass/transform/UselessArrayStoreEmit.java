package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.types.ArrayType;
import ir.types.PointerType;
import pass.Pass;
import pass.analysis.SideEffect;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

// FIXME 没有考虑参数数组
public class UselessArrayStoreEmit implements Pass {

    private final Module irModule = Module.getModule();

    private final HashMap<Value, HashSet<Integer>> usefulPositions = new HashMap<>();

    @Override
    public void run() {
        new SideEffect().run();
        new GepFuse().run();
        globalEmit();
        localEmit();
        neverLoadGlobalEmit();
        new DeadCodeEmit().run();
        uselessGlobalArrayEmit();
    }

    private void uselessGlobalArrayEmit() {
        ArrayList<Value> toBeRemovedValue = new ArrayList<>();
        for (Value value : irModule.getGlobalVariables()) {
            if (value.getUsers().size() == 0) {
                toBeRemovedValue.add(value);
            }
        }
        for (Value value : toBeRemovedValue) {
            irModule.getGlobalVariables().remove(value);
        }
    }

    private void neverLoadGlobalEmit() {
        for (Function function : irModule.getFunctionsArray()) {
            if (!function.getIsBuiltIn() && hasParamArray(function)) {
                return;
            }
        }

        HashSet<Value> usefulGlobalArrayBase = new HashSet<>();
        for (Function function : irModule.getFunctionsArray()) {
            for (BasicBlock block : function.getBasicBlocksArray()) {
                for (Instruction instruction : block.getInstructionsArray()) {

                    if (instruction instanceof Load loadInstr && loadInstr.getAddr() instanceof GEP loadGepInstr) {
                        usefulGlobalArrayBase.add(loadGepInstr.getBase());
                    }
                    if (instruction instanceof Call callInstr && callInstr.getFunction().getName().equals("@putarray")) {
                        GEP gepInstr = (GEP) callInstr.getParamAt(1);
                        usefulGlobalArrayBase.add(gepInstr.getBase());
                    }

                }
            }
        }

        ArrayList<Store> toBeDeletedStore = new ArrayList<>();
        for (Function function : irModule.getFunctionsArray()) {
            for (BasicBlock block : function.getBasicBlocksArray()) {
                for (Instruction instruction : block.getInstructionsArray()) {
                    if (instruction instanceof Store storeInstr && storeInstr.getAddr() instanceof GEP storeGepInstr && !usefulGlobalArrayBase.contains(storeGepInstr.getBase())) {
                        toBeDeletedStore.add(storeInstr);
                    }
                }
            }
        }

        for (Store storeInstr : toBeDeletedStore) {
            storeInstr.removeSelf();
        }
    }

    private void globalEmit() {
        usefulPositions.clear();

        for (Function function : irModule.getFunctionsArray()) {
            if (!function.getIsBuiltIn() && (hasVarGep(function) || hasPutArray(function) || hasParamArray(function))) {
                return;
            }
        }

        for (Function function : irModule.getFunctionsArray()) {
            for (BasicBlock block : function.getBasicBlocksArray()) {
                for (Instruction instruction : block.getInstructionsArray()) {
                    if (instruction instanceof Load loadInstr) {
                        Value address = loadInstr.getAddr();
                        if (address instanceof GEP gepInstr && isGlobalGep(gepInstr)) {
                            markIndex(gepInstr.getBase(), gepInstr);
                        }
                    }
                }
            }
        }

        HashSet<Store> toBeDeletedStores = new HashSet<>();
        for (Function function : irModule.getFunctionsArray()) {
            for (BasicBlock block : function.getBasicBlocksArray()) {
                for (Instruction instruction : block.getInstructionsArray()) {
                    if (instruction instanceof Store storeInstr) {
                        Value address = storeInstr.getAddr();
                        if (address instanceof GEP gepInstr) {
                            if (!isMarkedIndex(gepInstr.getBase(), gepInstr)) {
                                toBeDeletedStores.add(storeInstr);
                            }
                        }
                    }
                }
            }
        }

        for (Store storeInstr : toBeDeletedStores) {
            storeInstr.removeSelf();
        }
    }

    private void localEmit() {
        ArrayList<Function> functions = irModule.getFunctionsArray();
        for (Function func : functions) {
            if (!func.getIsBuiltIn()) {
                usefulPositions.clear();
                deleteUselessLocalArrayStore(func);
            }
        }
    }

    private void deleteUselessLocalArrayStore(Function function) {
        if (hasVarGep(function) || hasNotLocalArray(function) || hasPutArray(function))
            return;  // gep中有变量不分析 有参数数组不分析 有putarray不分析

        // 保存数组相关的被load过的index
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Load loadInstr) {
                    Value address = loadInstr.getAddr();
                    if (address instanceof GEP gepInstr) {  // 只分析数组相关的io指令
                        markIndex(gepInstr.getBase(), gepInstr);
                    }
                }
            }
        }

        HashSet<Store> toBeDeletedStores = new HashSet<>();
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Store storeInstr) {
                    Value address = storeInstr.getAddr();
                    if (address instanceof GEP gepInstr) {
                        if (!isMarkedIndex(gepInstr.getBase(), gepInstr)) {
                            toBeDeletedStores.add(storeInstr);
                        }
                    }
                }
            }
        }

        for (Store storeInstr : toBeDeletedStores) {
            storeInstr.removeSelf();
        }
    }

    private void markIndex(Value base, GEP gepInstr) {
        if (!usefulPositions.containsKey(base)) {
            usefulPositions.put(base, new HashSet<>());
        }
        usefulPositions.get(base).add(getLocalArrayPosition(gepInstr));
    }

    private boolean isMarkedIndex(Value base, GEP gepInstr) {
        if (!usefulPositions.containsKey(base)) {
            return false;
        }
        return usefulPositions.get(base).contains(getLocalArrayPosition(gepInstr));
    }

    private boolean isGlobalGep(GEP gepInstr) {
        return gepInstr.getBase().getName().startsWith("@");
    }

    private boolean hasParamArray(Function function) {
        for (Argument argument : function.getArguments()) {
            if (argument.getValueType() instanceof PointerType) {
                return true;
            }
        }
        return false;
    }

    private boolean hasPutArray(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Call callInstr && callInstr.getFunction().getName().equals("@putarray")) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean hasNotLocalArray(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof GEP gepInstr) {
                    if (!(gepInstr.getBase() instanceof Alloca)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private boolean hasVarGep(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof GEP gepInstr) {
                    for (Value value : gepInstr.getIndex()) {
                        if (!(value instanceof ConstInt)) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }

    private int getLocalArrayPosition(GEP gepInstr) {
        ArrayList<Integer> dimension = ((ArrayType) ((PointerType) gepInstr.getBase().getValueType()).getPointeeType()).getNumList();
        ArrayList<Integer> index = new ArrayList<>();
        for (Value value : gepInstr.getIndex()) {
            index.add(Integer.parseInt(value.getName()));
        }
        index.remove(0);

        int pos = 0;
        for (int i = 0 ; i < dimension.size() ; i ++) {
            int cur = index.get(i);
            for (int j = i + 1 ; j < dimension.size() ; j ++) {
                cur *= dimension.get(j);
            }
            pos += cur;
        }
        return pos;
    }

}

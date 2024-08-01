package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.BitCast;
import ir.instructions.otherInstructions.Call;
import pass.Pass;
import pass.analysis.Loop;
import pass.analysis.LoopAnalysis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

/**
 * LICM： Loop Invariant Code Motion 循环不变代码外提
 * 目前似乎效果很差
 */
public class LICM implements Pass {
    private final HashMap<Alloca, HashSet<Instruction>> allocaDefMaps = new HashMap<>();
    private final HashMap<Alloca, HashSet<Instruction>> allocaUseMaps = new HashMap<>();
    private final HashMap<Value, HashSet<Instruction>> defMaps = new HashMap<>();
    private final HashMap<Value, HashSet<Instruction>> useMaps = new HashMap<>();
    /**
     * function 中对 gv 进行了 def 操作
     */
    private final HashMap<Function, HashSet<Value>> gvDefInFunc = new HashMap<>();
    /**
     * function 中对 gv 进行了 use 操作
     */
    private final HashMap<Function, HashSet<Value>> gvUseInFunc = new HashMap<>();
    /**
     * value 在 Hash<Loop> 中被 def
     */
    private final HashMap<Value, HashSet<Loop>> defLoops = new HashMap<>();
    /**
     * value 在 Hash<Loop> 中被 use
     */
    private final HashMap<Value, HashSet<Loop>> useLoops = new HashMap<>();
    /**
     * function 调用了 Hashset<Function> 中的函数
     */
    private final HashMap<Function, HashSet<Function>> callMaps = new HashMap<>();
    private final LoopAnalysis loopAnalysis = new LoopAnalysis();

    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                gvDefInFunc.put(function, new HashSet<>());
                gvUseInFunc.put(function, new HashSet<>());
                callMaps.put(function, new HashSet<>());
            }
        }
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                loopAnalysis.analyzeLoopInfo(function);
                constArrayDefMotion(function);
                loopInvariantCodeMotion(function);
            }
        }
    }

    private void clear() {
        allocaDefMaps.clear();
        allocaUseMaps.clear();
        defMaps.clear();
        useMaps.clear();
        defLoops.clear();
        useLoops.clear();
    }

    private void loopInvariantCodeMotion(Function func) {
        clear();
        for (BasicBlock block : func.getBasicBlocksArray()) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction inst : instructions) {
                if (inst instanceof Alloca alloca) {
                    for (User user : alloca.getUsers()) {
                        dfs4ValueDefUse(inst, (Instruction) user);
                    }
                } else if (inst instanceof Call call && !call.getFunction().getIsBuiltIn()) {
                    callMaps.get(func).add(call.getFunction());
                }
            }
        }
        for (GlobalVariable gv : Module.getModule().getGlobalVariablesArray()) {
            /*
            ATTENTION：
            下面三个循环的顺序不允许发生改变
             */
            useMaps.put(gv, new HashSet<>());
            defMaps.put(gv, new HashSet<>());
            for (User user : gv.getUsers()) {
                dfs4ValueDefUse(gv, (Instruction) user);
            }
            for (Instruction inst : useMaps.get(gv)) {
                gvUseInFunc.get(inst.getParent().getParent()).add(gv);
            }
            for (Instruction inst : defMaps.get(gv)) {
                gvDefInFunc.get(inst.getParent().getParent()).add(gv);
            }
        }
        boolean flag = true;
        while (flag) {
            flag = false;
            for (Function callee : callMaps.get(func)) {
                for (Value value : gvUseInFunc.get(callee)) {
                    boolean ret = !gvUseInFunc.get(func).contains(value);
                    if (ret) {
                        gvUseInFunc.get(func).add(value);
                        flag = true;
                    }
                }
                for (Value value : gvDefInFunc.get(callee)) {
                    boolean ret = !gvDefInFunc.get(func).contains(value);
                    if (ret) {
                        gvDefInFunc.get(func).add(value);
                        flag = true;
                    }
                }
            }
        }
        for (Function function : gvUseInFunc.keySet()) {
            for (Value value : gvUseInFunc.get(function)) {
                for (User user : function.getUsers()) {
                    useMaps.get(value).add((Instruction) user);
                }
            }
        }
        for (Function function : gvDefInFunc.keySet()) {
            for (Value value : gvDefInFunc.get(function)) {
                for (User user : function.getUsers()) {
                    defMaps.get(value).add((Instruction) user);
                }
            }
        }
        /*
        确定 value 被哪几个 loop 所 def/use
         */
        for (Value value : defMaps.keySet()) {
            defLoops.put(value, new HashSet<>());
            for (Instruction inst : defMaps.get(value)) {
                defLoops.get(value).add(inst.getParent().getLoop());
            }
        }
        for (Value value : useMaps.keySet()) {
            useLoops.put(value, new HashSet<>());
            for (Instruction inst : useMaps.get(value)) {
                useLoops.get(value).add(inst.getParent().getLoop());
            }
        }
        for (Value value : useMaps.keySet()) {
            codeMotion(value);
        }
    }

    private void dfs4ValueDefUse(Value value, Instruction inst) {
        if (inst instanceof GEP gep) {
            for (User user : gep.getUsers()) {
                dfs4ValueDefUse(value, (Instruction) user);
            }
        } else if (inst instanceof Store store) {
            if (!defMaps.containsKey(value)) {
                defMaps.put(value, new HashSet<>());
            }
            defMaps.get(value).add(inst);
        } else if (inst instanceof Load load) {
            if (!useMaps.containsKey(value)) {
                useMaps.put(value, new HashSet<>());
            }
            useMaps.get(value).add(inst);
        } else if (inst instanceof Call call) {
            if (call.getFunction() == Function.memset || call.getFunction() == Function.getarray) {
                if (!defMaps.containsKey(value)) {
                    defMaps.put(value, new HashSet<>());
                }
                defMaps.get(value).add(inst);
            } else if (call.getFunction() == Function.putarray) {
                if (!useMaps.containsKey(value)) {
                    useMaps.put(value, new HashSet<>());
                }
                useMaps.get(value).add(inst);
            } else {
                if (!defMaps.containsKey(value)) {
                    defMaps.put(value, new HashSet<>());
                }
                if (!useMaps.containsKey(value)) {
                    useMaps.put(value, new HashSet<>());
                }
                defMaps.get(value).add(inst);
                useMaps.get(value).add(inst);
            }
        } else if (inst instanceof BitCast bitCast) {
            for (User user : bitCast.getUsers()) {
                dfs4ValueDefUse(value, (Instruction) user);
            }
        }
    }

    private void codeMotion(Value value) {
        for (Instruction user : useMaps.get(value)) {
            if (!(user instanceof Load load)) {
                continue;
            }
            Loop useLoop = user.getParent().getLoop();
            if (useLoop == null) {
                continue;
            }
            if (useLoop.getEnterings().size() > 1) {
                continue;
            }
            BasicBlock entering = useLoop.getEnterings().iterator().next();
            boolean flag = false;
            for (Loop defLoop : defLoops.get(value)) {
                if (checkLoop(useLoop, defLoop)) {
                    flag = true;
                }
            }
            if (flag) {
                continue;
            }
            if (!defLoops.get(value).contains(useLoop)) {
                if (load.getAddr() instanceof GEP gep && gep.getParent().getLoop() == useLoop) {
                    continue;
                }
                user.eraseFromParent();
                entering.insertBefore(user, entering.getTailInstruction());
            }
        }
    }

    private Boolean checkLoop(Loop useLoop, Loop defLoop) {
        if (useLoop == null && defLoop == null) {
            return true;
        } else if (useLoop == null) {
            return false;
        } else if (defLoop == null) {
            return false;
        }
        int useDepth = useLoop.getDepth();
        int defDepth = defLoop.getDepth();
        if (useDepth == defDepth) {
            return useLoop == defLoop;
        }
        if (useDepth > defDepth) {
            return false;
        } else {
            int gap = defDepth - useDepth;
            for (int i = 0; i < gap; i++) {
                defLoop = defLoop.getParent();
            }
        }
        return useLoop == defLoop;
    }

    private void constArrayDefMotion(Function function) {
        clear();
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction inst : block.getInstructionsArray()) {
                if (inst instanceof Alloca alloca) {
                    for (User user : alloca.getUsers()) {
                        dfs(alloca, (Instruction) user);
                    }
                }
            }
        }
        for (Alloca alloca : allocaDefMaps.keySet()) {
            defMotion(alloca);
        }
    }
    private void dfs(Alloca alloca, Instruction inst) {
        if (inst instanceof GEP gep) {
            for (User user : gep.getUsers()) {
                dfs(alloca, (Instruction) user);
            }
        } else if (inst instanceof Store store) {
            if (!allocaDefMaps.containsKey(alloca)) {
                allocaDefMaps.put(alloca, new HashSet<>());
            }
            allocaDefMaps.get(alloca).add(inst);
        } else if (inst instanceof Load load) {
            if (!allocaUseMaps.containsKey(alloca)) {
                allocaUseMaps.put(alloca, new HashSet<>());
            }
            allocaUseMaps.get(alloca).add(inst);
        } else if (inst instanceof Call call) {
            if (call.getFunction() == Function.memset || call.getFunction() == Function.getarray) {
                if (!allocaDefMaps.containsKey(alloca)) {
                    allocaDefMaps.put(alloca, new HashSet<>());
                }
                allocaDefMaps.get(alloca).add(inst);
            } else {
                if (!allocaDefMaps.containsKey(alloca)) {
                    allocaDefMaps.put(alloca, new HashSet<>());
                }
                if (!allocaUseMaps.containsKey(alloca)) {
                    allocaUseMaps.put(alloca, new HashSet<>());
                }
                allocaDefMaps.get(alloca).add(inst);
                allocaUseMaps.get(alloca).add(inst);
            }
        } else if (inst instanceof BitCast bitCast) {
            for (User user : bitCast.getUsers()) {
                dfs(alloca, (Instruction) user);
            }
        }
    }
    private void defMotion(Alloca alloca) {
        HashSet<Instruction> allocaDefs = allocaDefMaps.get(alloca);
        BasicBlock block = null;
        // 这里是保证所有的 def 都必须在同一个基本块
        for (Instruction def : allocaDefs) {
            if (block == null) {
                block = def.getParent();
            } else {
                if (block != def.getParent()) {
                    return;
                }
            }
        }
        for (Instruction def : allocaDefs) {
            if (def instanceof Call call) {
                if (call.getFunction() == Function.memset) {
                    Value param1 = call.getParamAt(1);
                    Value param2 = call.getParamAt(2);
                    if (param1 instanceof ConstInt constParam1 && param2 instanceof ConstInt constParam2) {
                        int initNum = constParam1.getValue();
                        if (initNum != 0) {
                            return;
                        }
                    } else {
                        return;
                    }
                } else {
                    return;
                }
            } else if (def instanceof Store store) {
                Value addr = store.getAddr();
                Value value = store.getValue();
                if (!(value instanceof ConstInt)) {
                    return;
                }
                if (addr instanceof GEP gep) {
                    for (Value index : gep.getIndex()) {
                        if (!(index instanceof ConstInt)) {
                            return;
                        }
                    }
                } else {
                    return;
                }
            }
        }
        if (block.getLoop() == null) {
            return;
        }
        if (block.getLoop().getDepth() == 0) {
            return;
        }
        Loop loop = block.getLoop();
        if (loop.getEnterings().size() > 1) {
            return;
        }
        HashSet<Instruction> liftInst = new HashSet<>();
        BasicBlock entering = loop.getEnterings().iterator().next();
        for (Instruction instruction : block.getInstructionsArray()) {
            if (allocaDefs.contains(instruction)) {
                liftInst.add(instruction);
            }
        }
        for (Instruction instruction : liftInst) {
            instruction.eraseFromParent();
            entering.insertBefore(instruction, entering.getTailInstruction());
        }
    }
}

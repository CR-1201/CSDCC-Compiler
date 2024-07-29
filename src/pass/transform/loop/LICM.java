package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.BitCast;
import ir.instructions.otherInstructions.Call;
import pass.Pass;
import pass.analysis.Loop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

/**
 * LICM： Loop Invariant Code Motion 循环不变代码外提
 */
public class LICM implements Pass {
    private final HashMap<Alloca, HashSet<Instruction>> allocaDefMaps = new HashMap<>();
    private final HashMap<Alloca, HashSet<Instruction>> allocaUseMaps = new HashMap<>();
    private final HashMap<Value, HashSet<Instruction>> defMaps = new HashMap<>();
    private final HashMap<Value, HashSet<Instruction>> useMaps = new HashMap<>();
    private final HashMap<Function, HashSet<Value>> defGvInFunc = new HashMap<>();
    private final HashMap<Function, HashSet<Value>> useGvInFunc = new HashMap<>();
    private final HashMap<Function, HashSet<Function>> callMaps = new HashMap<>();
    private final HashMap<Value, HashSet<Loop>> useLoops = new HashMap<>();
    private final HashMap<Value, HashSet<Loop>> defLoops = new HashMap<>();


    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            defGvInFunc.put(function, new HashSet<>());
            useGvInFunc.put(function, new HashSet<>());
            callMaps.put(function, new HashSet<>());
        }
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                constDefMotion4Array(function);
                licm(function);
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

    private void licm(Function func) {
        clear();
        for (BasicBlock block : func.getBasicBlocksArray()) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction inst : instructions) {
                if (inst instanceof Alloca alloca) {
                    for (User user : alloca.getUsers()) {
                        dfs4array(inst, (Instruction) user);
                    }
                } else if (inst instanceof Call call && !call.getFunction().getIsBuiltIn()) {
                    callMaps.get(func).add(call.getFunction());
                }
            }
        }
        for (GlobalVariable gv : Module.getModule().getGlobalVariablesArray()) {
            useMaps.put(gv, new HashSet<>());
            defMaps.put(gv, new HashSet<>());
        }

        for (GlobalVariable gv : Module.getModule().getGlobalVariablesArray()) {
            for (User user : gv.getUsers()) {
                dfs4array(gv, (Instruction) user);
            }
        }

        for (GlobalVariable gv : Module.getModule().getGlobalVariablesArray()) {
            for (Instruction inst : useMaps.get(gv)) {
                useGvInFunc.get(inst.getParent().getParent()).add(gv);
            }
            for (Instruction inst : defMaps.get(gv)) {
                defGvInFunc.get(inst.getParent().getParent()).add(gv);
            }
        }

        boolean flag = true;
        while (flag) {
            flag = false;
            for (Function callee : callMaps.get(func)) {
                for (Value value : useGvInFunc.get(callee)) {
                    boolean ret = !useGvInFunc.get(func).contains(value);
                    useGvInFunc.get(func).add(value);
                    if (ret) {
                        flag = true;
                    }
                }
                for (Value value : defGvInFunc.get(callee)) {
                    boolean ret = !defGvInFunc.get(func).contains(value);
                    defGvInFunc.get(func).add(value);
                    if (ret) {
                        flag = true;
                    }
                }
            }
        }
        for (Function function : useGvInFunc.keySet()) {
            for (Value value : useGvInFunc.get(function)) {
                for (User user : function.getUsers()) {
                    useMaps.get(value).add((Instruction) user);
                }
            }
        }
        for (Function function : defGvInFunc.keySet()) {
            for (Value value : defGvInFunc.get(function)) {
                for (User user : function.getUsers()) {
                    defMaps.get(value).add((Instruction) user);
                }
            }
        }
        for (Value value : useMaps.keySet()) {
            useLoops.put(value, new HashSet<>());
            for (Instruction inst : useMaps.get(value)) {
                useLoops.get(value).add(inst.getParent().getLoop());
            }
        }
        for (Value value : defMaps.keySet()) {
            defLoops.put(value, new HashSet<>());
            for (Instruction inst : defMaps.get(value)) {
                defLoops.get(value).add(inst.getParent().getLoop());
            }
        }

        for (Value value : useMaps.keySet()) {
            motion(value);
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

    private void dfs4array(Value value, Instruction inst) {
        if (inst instanceof GEP gep) {
            for (User user : gep.getUsers()) {
                dfs4array(value, (Instruction) user);
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
                dfs4array(value, (Instruction) user);
            }
        }
    }

    private void motion(Value value) {
        for (Instruction user : useMaps.get(value)) {
            if (!(user instanceof Load)) {
                continue;
            }
            Load load = (Load) user;
            Loop loop = user.getParent().getLoop();
            if (loop == null) {
                continue;
            }
            if (loop.getDepth() == 0) {
                continue;
            }
            if (loop.getHeader().getPrecursors().size() > 1) {
                continue;
            }
            BasicBlock entering = loop.getHeader().getPrecursors().iterator().next();
            boolean flag = false;
            for (Loop defLoop : defLoops.get(value)) {
                if (check(loop, defLoop)) {
                    flag = true;
                }
            }
            if (flag) {
                continue;
            }
            if (!defLoops.get(value).contains(loop)) {
                if (load.getAddr() instanceof GEP gep && gep.getParent().getLoop() == loop) {
                    continue;
                }
                user.eraseFromParent();
                entering.insertBefore(user, entering.getTailInstruction());
            }
        }
    }

    private Boolean check(Loop useLoop, Loop defLoop) {
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

    private void constDefMotion4Array(Function function) {
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
            lift(alloca);
        }
    }
    private void lift(Alloca alloca) {
        HashSet<Instruction> def4Alloca = allocaDefMaps.get(alloca);
        BasicBlock block = null;
        for (Instruction def : def4Alloca) {
            if (block == null) {
                block = def.getParent();
            } else {
                if (block != def.getParent()) {
                    return;
                }
            }
        }
        for (Instruction def : def4Alloca) {
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
        if (block.getLoop().getDepth() == 0) {
            return;
        }
        Loop loop = block.getLoop();
        if (loop.getHeader().getPrecursors().size() > 1) {
            return;
        }
        HashSet<Instruction> liftInst = new HashSet<>();
        BasicBlock entering = loop.getHeader().getPrecursors().iterator().next();
        for (Instruction instruction : block.getInstructionsArray()) {
            if (def4Alloca.contains(instruction)) {
                liftInst.add(instruction);
            }
        }
        for (Instruction instruction : liftInst) {
            instruction.eraseFromParent();
            entering.insertBefore(instruction, entering.getTailInstruction());
        }
    }
}

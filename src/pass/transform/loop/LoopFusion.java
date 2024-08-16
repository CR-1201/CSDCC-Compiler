package pass.transform.loop;

import backend.instruction.Binary;
import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.binaryInstructions.Icmp;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import pass.Pass;
import pass.analysis.Loop;

import java.util.HashMap;
import java.util.HashSet;

public class LoopFusion implements Pass {
    private final HashSet<Loop> loops = new HashSet<>();
    private Loop nxtLoop = null;
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            loops.clear();
            if (!function.getIsBuiltIn()) {
                loops.addAll(function.getAllLoops());
            }
            if (loops.isEmpty()) {
                continue;
            }
            for (Loop loop : loops) {
                nxtLoop = null;
                loopFusion(loop);
            }
        }
    }

    // 标记前一个循环为 preLoop，紧邻的下一个循环为 nxtLoop
    private void loopFusion(Loop loop) {
        if (!checkLoop(loop)) {
            return;
        }
        BasicBlock preLoopLatch = loop.getLatches().iterator().next();
        BasicBlock preLoopHeader = loop.getHeader();
        BasicBlock preLoopEntering = loop.getEnterings().iterator().next();
        BasicBlock nxtLoopLatch = nxtLoop.getLatches().iterator().next();
        BasicBlock nxtLoopHeader = nxtLoop.getHeader();
        BasicBlock nxtLoopEntering = nxtLoop.getEnterings().iterator().next();
        HashSet<Instruction> preLoopIdcs = new HashSet<>();
        HashSet<Instruction> nxtLoopIdcs = new HashSet<>();

        preLoopIdcs.add((Instruction) loop.getIdcVar());
        preLoopIdcs.add((Instruction) loop.getIdcAlu());
        preLoopIdcs.add(loop.getCond());
        preLoopIdcs.add(preLoopHeader.getTailInstruction());
        preLoopIdcs.add(preLoopLatch.getTailInstruction());

        nxtLoopIdcs.add((Instruction) nxtLoop.getIdcVar());
        nxtLoopIdcs.add((Instruction) nxtLoop.getIdcAlu());
        nxtLoopIdcs.add(nxtLoop.getCond());
        nxtLoopIdcs.add(nxtLoopHeader.getTailInstruction());
        nxtLoopIdcs.add(nxtLoopLatch.getTailInstruction());

        // preLoop info
        HashSet<Value> preLoopLoad = new HashSet<>();
        HashSet<Value> preLoopStore = new HashSet<>();
        HashMap<Value, Instruction> preLoopLoadGep = new HashMap<>();
        HashMap<Value, Instruction> preLoopStoreGep = new HashMap<>();
        HashSet<Instruction> preLoopLatchInsts = new HashSet<>(preLoopLatch.getInstructionsArray());
        preLoopLatchInsts.remove((Instruction) loop.getIdcAlu());
        for (Instruction inst : preLoopLatchInsts) {
            if (inst.isUsedOutside(loop)) {
                return;
            }
        }
        // nxtLoop info
        HashSet<Value> nxtLoopLoad = new HashSet<>();
        HashSet<Value> nxtLoopStore = new HashSet<>();
        HashMap<Value, Instruction> nxtLoopLoadGep = new HashMap<>();
        HashMap<Value, Instruction> nxtLoopStoreGep = new HashMap<>();
        HashSet<Instruction> nxtLoopLatchInsts = new HashSet<>(nxtLoopLatch.getInstructionsArray());
        nxtLoopLatchInsts.remove((Instruction) nxtLoop.getIdcAlu());
        for (Instruction inst : nxtLoopLatchInsts) {
            if (inst.isUsedOutside(nxtLoop)) {
                return;
            }
        }
        // 检查循环体的指令
        if (!checkLatchInst(preLoopLatch, preLoopLatchInsts, preLoopLoad, preLoopStore, preLoopLoadGep, preLoopStoreGep)) {
            return;
        }
        if (!checkLatchInst(nxtLoopLatch, nxtLoopLatchInsts, nxtLoopLoad, nxtLoopStore, nxtLoopLoadGep, nxtLoopStoreGep)) {
            return;
        }

        if (preLoopStore.size() != 1 || nxtLoopStore.size() != 1 || preLoopStore.equals(nxtLoopStore)) {
            return;
        }
    }

    // 只进行最基本的条件的检查
    private Boolean checkLoop(Loop loop) {
        if (!(loop.isSimpleLoop() && loop.isInductorVarSet())) {
            return false;
        }
        BasicBlock preExit = loop.getExits().iterator().next();
        if (preExit.getSuccessors().size() != 1) {
            return false;
        } else {
            if (!preExit.getSuccessors().iterator().next().isLoopHeader()) {
                return false;
            }
        }
        // 此时，可以得到 loop 的下一个 nxtLoop
        nxtLoop = preExit.getSuccessors().iterator().next().getLoop();
        if (!(nxtLoop.isSimpleLoop() && nxtLoop.isInductorVarSet())) {
            return false;
        }
        // 合并要求两个 Loop 的 init、end、step 均保持一致
        if (!(loop.getIdcInit().equals(nxtLoop.getIdcInit()) && loop.getIdcEnd().equals(nxtLoop.getIdcEnd()))) {
            return false;
        }
        // Step 不能直接这样判断
        if (!loop.getIdcStep().equals(nxtLoop.getIdcStep())) {
            Value preStep = loop.getIdcStep();
            Value nxtStep = nxtLoop.getIdcStep();
            if (preStep instanceof ConstInt preStepConst && nxtStep instanceof ConstInt nxtStepConst) {
                if (preStepConst.getValue() != nxtStepConst.getValue()) {
                    return false;
                }
            } else {
                return false;
            }
        }

        if (!loop.getCond().getCondition().equals(nxtLoop.getCond().getCondition())) {
            return false;
        }
        BasicBlock preLoopLatch = loop.getLatches().iterator().next();
        BasicBlock nxtLoopLatch = nxtLoop.getLatches().iterator().next();
        // 目前需要进行限制：i = i + 1 这样的 idcALu 必须是一个循环中的最后一个语句
        // 即 latch 的 倒数第二条语句（因为最后一条是 br 语句）
        if (!preLoopLatch.getInstructionsArray().get(preLoopLatch.getInstructionsArray().size() - 2).equals(loop.getIdcAlu())) {
            return false;
        }
        // 需要保证 preLoop 和 nxtLoop 的迭代变量都没有在循环外被使用
        // preLoop
        if (((Instruction) loop.getIdcVar()).isUsedOutside(loop)) {
            return false;
        }
        if (((Instruction) loop.getIdcAlu()).isUsedOutside(loop)) {
            return false;
        }
        if (((Instruction) loop.getCond()).isUsedOutside(loop)) {
            return false;
        }
        if (loop.getHeader().getTailInstruction().isUsedOutside(loop)) {
            return false;
        }
        if (preLoopLatch.getTailInstruction().isUsedOutside(loop)) {
            return false;
        }
        // nxtLoop
        if (((Instruction) nxtLoop.getIdcVar()).isUsedOutside(nxtLoop)) {
            return false;
        }
        if (((Instruction) nxtLoop.getIdcAlu()).isUsedOutside(nxtLoop)) {
            return false;
        }
        if (nxtLoop.getCond().isUsedOutside(nxtLoop)) {
            return false;
        }
        if (nxtLoop.getHeader().getTailInstruction().isUsedOutside(nxtLoop)) {
            return false;
        }
        if (nxtLoopLatch.getTailInstruction().isUsedOutside(nxtLoop)) {
            return false;
        }
        return true;
    }

    private Boolean checkLatchInst(BasicBlock loopLatch, HashSet<Instruction> loopLatchInsts,
                                   HashSet<Value> loopLoad, HashSet<Value> loopStore,
                                   HashMap<Value, Instruction> loopLoadGep, HashMap<Value, Instruction> loopStoreGep) {
        for (Instruction loopLatchInst : loopLatchInsts) {
            if (loopLatchInst instanceof Load load) {
                Value addr = load.getAddr();
                while (addr instanceof GEP gep) {
                    addr = gep.getBase();
                }
                loopLoad.add(addr);
            } else if (loopLatchInst instanceof Store store) {
                Value value = store.getValue();
                Value addr = store.getAddr();
                while (addr instanceof GEP gep) {
                    addr = gep.getBase();
                }
                loopStore.add(addr);
            } else if (loopLatchInst instanceof BinaryInstruction binary) {
                if (loopLatchInst instanceof Icmp) {
                    return false;
                }
                Value left = binary.getOp1();
                Value right = binary.getOp2();
                // FIXME: 这个限制是不是过于死了，看起来并不是很合理
                if (left instanceof Instruction li && !li.getParent().equals(loopLatch)) {
                    return false;
                }
                if (right instanceof Instruction ri && !ri.getParent().equals(loopLatch)) {
                    return false;
                }
            } else if (loopLatchInst instanceof GEP gep) {
                Value addr = gep.getBase();
                while (addr instanceof GEP innerGep) {
                    addr = innerGep.getBase();
                }
                for (User user : gep.getUsers()) {
                    if (user instanceof Load) {
                        if (loopLoadGep.containsKey(addr)) {
                            return false;
                        }
                        loopLoadGep.put(addr, loopLatchInst);
                    } else if (user instanceof Store) {
                        if (loopStoreGep.containsKey(addr)) {
                            return false;
                        }
                        loopStoreGep.put(addr, loopLatchInst);
                    } else {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}

package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.types.IntType;
import pass.Pass;
import pass.analysis.CFG;
import pass.analysis.Loop;
import pass.analysis.LoopVarAnalysis;
import pass.utility.BlockUtil;
import pass.utility.CloneUtil;
import utils.IOFunc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class LoopUnroll implements Pass {
    private CFG cfg = new CFG();
    private BlockUtil blockUtil = new BlockUtil();
    private boolean isUnrolled = false;
    private final int LOOP_MAX_LINE = 5000;

    private BasicBlock header;
    private BasicBlock next;
    private BasicBlock exit;
    private BasicBlock latch;

    private LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
    public void run() {
//        isUnrolled = true;
//        while (isUnrolled) {
//            isUnrolled = false;
        IOFunc.clear("checkir/loop.txt");
        IOFunc.output(Module.getModule().toString(), "checkir/loop.txt");
            for (Function func : Module.getModule().getFunctionsArray()) {
                if (!func.getIsBuiltIn()) {
                    clear();
                    loopVarAnalysis.loopVarAnalysis(func);
                    runLoopUnroll(func);
                    if (isUnrolled) {
                        cfg.setCFG(func.getBasicBlocksArray());
                    }
                }
            }
//        }
    }
    private void clear() {
        isUnrolled = false;
        header = null;
        next = null;
        exit = null;
        latch = null;
    }
    private void runLoopUnroll(Function func) {
        ArrayList<Loop> allLoops = new ArrayList<>();
        for (Loop loop : func.getTopLoops()) {
            allLoops.addAll(loop.computeDfsLoops());
        }
        for (Loop loop : allLoops) {
            constLoopUnroll(loop);
        }
    }

    private void constLoopUnroll(Loop loop) {
        Value idcVar = loop.getIdcVar();
        Value idcEnd = loop.getIdcEnd();
        Value idcInit = loop.getIdcInit();
        BinaryInstruction idcAlu = (BinaryInstruction) loop.getIdcAlu();
        Value idcStep = loop.getIdcStep();
        Icmp cond = loop.getCond();
        if (!(idcEnd instanceof Constant) || !(idcStep instanceof Constant) || !(idcInit instanceof Constant)) {
            return;
        }
        int init = ((ConstInt) idcInit).getValue();
        int step = ((ConstInt) idcStep).getValue();
        int end = ((ConstInt) idcEnd).getValue();
        if (step == 0) {
            return;
        }
        int loopTimes = computeLoopTimes(init, end, step, idcAlu, cond.getCondition());
        if (loopTimes <= 0) {
            return;
        } else {
            loop.setLoopTimes(loopTimes);
        }
        if (!initUnroll(loop)) {
            return;
        }
        isUnrolled = true;
        handleUnroll(loop);
    }

    private Boolean initUnroll(Loop loop) {
        HashSet<BasicBlock> allExits = new HashSet<>(loop.computeChildrenExits());
        HashSet<BasicBlock> allBlocks = new HashSet<>(loop.getAllBlocks());
        for (BasicBlock exit : allExits) {
            if (!allBlocks.contains(exit)) {
                return false;
            }
        }
        int loopTimes = loop.getLoopTimes();
        int loopSize = loop.computeLoopSize();
        if ((long) loopTimes * loopSize > LOOP_MAX_LINE) {
            return false;
        }
        header = loop.getHeader();
        for (BasicBlock block : header.getPrecursors()) {
            if (loop.getLatches().contains(block)) {
                latch = block;
            }
        }
        exit = loop.getExits().iterator().next();
        for (BasicBlock block : header.getSuccessors()) {
            if (block != exit) {
                next = block;
            }
        }
        return next == null || next.getPrecursors().size() == 1;
    }

    private void handleUnroll(Loop loop) {
        HashMap<Value, Value> phiMap = new HashMap<>();
        HashMap<Value, Value> beginToEnd = new HashMap<>();
        Function headerParent = header.getParent();
        HashSet<Phi> headerPhis = new HashSet<>();
        for (Instruction inst : header.getInstructions()) {
            if (inst instanceof Phi phi) {
                headerPhis.add(phi);
            } else {
                break;
            }
        }
        // headerPhis 中有来自 latch 的 value，我们需要清除掉
        for (Phi phi : headerPhis) {
            int latchIndex = phi.getOperators().indexOf(latch);
            Value latchValue = phi.getOperator(latchIndex - phi.getPrecursorNum());
            phi.removeUsedValue(latchValue);
            phiMap.put(phi, latchValue);
            beginToEnd.put(phi, latchValue);
        }
        header.removePrecursor(latch);
        header.removeSuccessor(exit);
        loop.removeBlock(header);
        header.setLoop(loop.getParent());
        Br br = (Br) header.getTailInstruction();
        br.cond2jump(next);
        latch.removeLastInst();
        ArrayList<BasicBlock> dfs = loop.computeDfsBlocksFromEntry(next);
        Loop parent = loop.getParent();
        if (parent != null) {
            parent.removeChild(loop);
            for (BasicBlock bb : loop.getAllBlocks()) {
                bb.setLoop(parent);
                if (!parent.getAllBlocks().contains(bb)) {
                    parent.addBlock(bb);
                }
            }
            for (Loop child : loop.getChildren()) {
                child.setParent(parent);
            }
        } else {
            headerParent = header.getParent();
            headerParent.removeTopLoop(loop);
        }
        BasicBlock oldNext = next;
        BasicBlock oldLatch = latch;
        CloneUtil cloneUtil = new CloneUtil();
        for (Value value : phiMap.keySet()) {
            cloneUtil.insertCloneMap(value, phiMap.get(value));
        }
        for (int loopTime = 0; loopTime < loop.getLoopTimes() - 1; loopTime++) {
            for (BasicBlock block : dfs) {
                BasicBlock clonedBlock = IrBuilder.getIrBuilder().buildBasicBlock(header.getParent());
                cloneUtil.insertCloneMap(block, clonedBlock);
            }
            for (BasicBlock block : dfs) {
                BasicBlock clonedBlock = (BasicBlock) cloneUtil.findValue(block);
                cloneUtil.cloneBlock(block, clonedBlock);
                clonedBlock.setLoop(block.getLoop());
                block.getLoop().addBlock(clonedBlock);
            }
            ArrayList<BasicBlock> beforeDfs = new ArrayList<>(dfs);
            dfs.clear();
            for(BasicBlock block : beforeDfs){
                dfs.add((BasicBlock) cloneUtil.findValue(block));
            }

            BasicBlock newNext = (BasicBlock) cloneUtil.findValue(oldNext);
            BasicBlock newLatch = (BasicBlock) cloneUtil.findValue(oldLatch);
            cfg.setCFG(dfs);
            oldLatch.addSuccessor(newNext);
            newNext.addPrecursor(oldLatch);
            IrBuilder.getIrBuilder().buildBr(oldLatch, newNext);

            ArrayList<Phi> phis = blockUtil.getAllPhisIn(beforeDfs);
            for (Phi phi : phis) {
                int precursorNum = phi.getPrecursorNum();
                for (int i = 0; i < precursorNum; i++) {
                    BasicBlock preBlock = (BasicBlock) phi.getOperator(i + precursorNum);
                    BasicBlock nowBlock = (BasicBlock) cloneUtil.findValue(preBlock);
                    Phi clonedPhi = (Phi) cloneUtil.findValue(phi);
                    int index = clonedPhi.getOperators().indexOf(nowBlock);
                    Value value = phi.getOperator(i);
                    Value clonedValue;
                    if(value instanceof ConstInt){
                        int val = ((ConstInt) value).getValue();
                        clonedValue = new ConstInt(val);
                    } else if(value instanceof ConstFloat){
                        float val = ((ConstFloat) value).getValue();
                        clonedValue = new ConstFloat(val);
                    } else {
                        clonedValue = cloneUtil.findValue(value);
                    }
                    clonedPhi.addIncoming(clonedValue, nowBlock);
                }
            }
            for(Value key : beginToEnd.keySet()){
                Value value = beginToEnd.get(key);
                beginToEnd.put(key, cloneUtil.findValue(value));
            }
            oldNext = newNext;
            oldLatch = newLatch;
        }
        IrBuilder.getIrBuilder().buildBr(oldLatch, exit);
        ArrayList<Phi> phiInExit = exit.getPhis();
        for(Phi phi : phiInExit){
            for(Value value : phi.getOperators()){
                if(value instanceof Instruction inst && inst.getParent().equals(header)){
                    phi.replaceOperator(value, beginToEnd.get(value));
                }
            }
        }
    }

    private int computeLoopTimes(int init, int end, int step, Instruction alu, Icmp.Condition cmp) {
        int loopTimes = -1;
        if (alu instanceof Add) {
            if (cmp.equals(Icmp.Condition.EQ)) {
                loopTimes = (init == end) ? 1 : 0;
            } else if (cmp.equals(Icmp.Condition.NE)) {
                loopTimes = ((end - init) % step == 0) ? (end - init) / step : -1;
            } else if (cmp.equals(Icmp.Condition.GE) || cmp.equals(Icmp.Condition.LE)) {
                loopTimes = (end - init) / step + 1;
            } else if (cmp.equals(Icmp.Condition.GT) || cmp.equals(Icmp.Condition.LT)) {
                loopTimes = ((end - init) % step == 0) ? (end - init) / step : (end - init) / step + 1;
            }
        } else if (alu instanceof Sub) {
            if (cmp.equals(Icmp.Condition.EQ)) {
                loopTimes = (init == end) ? 1 : 0;
            } else if (cmp.equals(Icmp.Condition.NE)) {
                loopTimes = ((init - end) % step == 0) ? (init - end) / step : -1;
            } else if (cmp.equals(Icmp.Condition.GE) || cmp.equals(Icmp.Condition.LE)) {
                loopTimes = (init - end) / step + 1;
            } else if (cmp.equals(Icmp.Condition.GT) || cmp.equals(Icmp.Condition.LT)) {
                loopTimes = ((init - end) % step == 0) ? (init - end) / step : (init - end) / step + 1;
            }
        } else if (alu instanceof Mul) {
            double val = Math.log(end / init) / Math.log(step);
            boolean tag = init * Math.pow(step, val) == end;
            if (cmp.equals(Icmp.Condition.EQ)) {
                loopTimes = (init == end) ? 1 : 0;
            } else if (cmp.equals(Icmp.Condition.NE)) {
                loopTimes = tag ? (int) val : -1;
            } else if (cmp.equals(Icmp.Condition.GE) || cmp.equals(Icmp.Condition.LE)) {
                loopTimes = (int) val + 1;
            } else if (cmp.equals(Icmp.Condition.GT) || cmp.equals(Icmp.Condition.LT)) {
                loopTimes = tag ? (int) val : (int) val + 1;
            }
        }
        return loopTimes;
    }
}

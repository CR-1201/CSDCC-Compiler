package pass.transform.loop;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import pass.Pass;
import pass.analysis.Loop;
import pass.analysis.LoopVarAnalysis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class LoopUnroll implements Pass {
    private boolean isUnrolled = false;
    private final int LOOP_MAX_LINE = 5000;

    private BasicBlock header;
    private BasicBlock next;
    private BasicBlock exit;
    private BasicBlock enter;
    private BasicBlock latch;

    private LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
    public void run() {
        for (Function func : Module.getModule().getFunctionsArray()) {
            if (!func.getIsBuiltIn()) {
//                loopVarAnalysis.loopVarAnalysis(func);
//                runLoopUnroll(func);
            }
        }
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
        HashSet<BasicBlock> allExits = new HashSet<>(loop.computeAllExits());
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
        BasicBlock header = loop.getHeader();
        for (BasicBlock block : header.getPrecursors()) {
            if (loop.getLatches().contains(block)) {
                latch = block;
            } else {
                enter = block;
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
        HashSet<Phi> headerPhi = new HashSet<>();
        for (Instruction inst : header.getInstructions()) {
            if (inst instanceof Phi phi) {
                headerPhi.add(phi);
            } else {
                break;
            }
        }

        // headerPhi 中有来自 latch 的 value，我们需要清除掉
        for (Phi phi : headerPhi) {
            int latchIndex = phi.getOperators().indexOf(latch);
            Value latchValue = phi.getOperator(latchIndex - phi.getPrecursorNum());
            phi.removeUsedValue(latchValue);
            phiMap.put(phi, latchValue);
            beginToEnd.put(phi, latchValue);
        }
        //  删除 header 和 latch/exit 之间的前驱后继关系
        header.removePrecursor(latch);
        header.removeSuccessor(exit);
        loop.removeBlock(header);
        header.setLoop(loop.getParent());
        Br br = (Br) header.getTailInstruction();
        br.cond2jump(next);
        latch.removeLastInst();
        ArrayList<BasicBlock> dfs = next.computeDfsSuccBlocks();

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
            Function headerParent = header.getParent();
            headerParent.removeTopLoop(loop);
        }

        /**
         * 执行 Unroll 操作
         */
        BasicBlock oldNext = next;
        BasicBlock oldLatch = latch;
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

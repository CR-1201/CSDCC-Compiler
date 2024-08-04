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
import pass.Pass;
import pass.analysis.CFG;
import pass.analysis.Loop;
import pass.analysis.LoopVarAnalysis;
import pass.utility.BlockUtil;
import pass.utility.CloneUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class LoopUnroll implements Pass {
    private final CFG cfg = new CFG();
    private final BlockUtil blockUtil = new BlockUtil();
    private final CloneUtil cloneUtil = new CloneUtil();
    private boolean isUnrolled = false;
    private final int LOOP_MAX_LINE = 15000;

    private BasicBlock header;
    private BasicBlock next;
    private BasicBlock exit;
    private BasicBlock latch;

    private LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
    public void run() {
//        IOFunc.log("checkir/loop.ll", Module.getModule().toString());
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
            /*
             * ATTENTION:
             * 不能在某一个循环达到限制之后，就直接return。
             * 因为函数后面其他的Top循环还需要被展开。
             */
        }
//        System.out.println(allLoops);
    }

    private void constLoopUnroll(Loop loop) {
        if (!loop.isInductorVarSet()) {
            return;
        }
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
        int loopTimes = loop.computeLoopTimes(init, end, step, idcAlu, cond.getCondition());
        if (loopTimes <= 0) {
            // 说明这个 loop 其实是无用的 loop，可以直接删掉
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
//        System.out.println("============ Loop: " + loop.getId() + " ============");
//        for (BasicBlock block : allBlocks) {
//            System.out.println(block.getName());
//        }
//        System.out.println(loopSize);
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
        for (Instruction inst : header.getInstructionsArray()) {
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
            phi.removeUsedBlock(latch);
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
        /*
        对于第一次展开，我们只需要保证原来 loop 中的块的设置新的 loop 为 loop.getParent即可。
        不需要把块加进上层的块，这是没有意义的，因为本身就已经有了。
         */
        if (parent != null) {
            parent.removeChild(loop);
            for (Loop child : loop.getChildren()) {
                child.setParent(parent);
            }
        } else {
            headerParent.removeTopLoop(loop);
        }
        BasicBlock oldNext = next;
        BasicBlock oldLatch = latch;
        cloneUtil.clearCloneMap();
        for (Value value : phiMap.keySet()) {
            cloneUtil.insertCloneMap(value, phiMap.get(value));
        }
        int loopTime = loop.getLoopTimes();
        for (int curLoopTime = 0; curLoopTime < loopTime - 1; curLoopTime++) {
            for (BasicBlock block : dfs) {
                BasicBlock clonedBlock = IrBuilder.getIrBuilder().buildBasicBlock(header.getParent());
                cloneUtil.insertCloneMap(block, clonedBlock);
            }
            for (BasicBlock block : dfs) {
                BasicBlock clonedBlock = (BasicBlock) cloneUtil.findValue(block);
                cloneUtil.cloneBlock(block, clonedBlock);
                clonedBlock.setLoop(block.getLoop());
                /*
                 * 应该是该循环所有的外层循环都有新的Block
                 * 同时，需要注意，AllBlocks 是 ArrayList，需要去重
                 */
                block.getLoop().addBlockInLoopChain(clonedBlock);
//              block.getLoop().addBlock(clonedBlock);
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
                    phi.replaceOperator(value, beginToEnd.get(value), oldLatch);
                }
            }
        }
    }
}
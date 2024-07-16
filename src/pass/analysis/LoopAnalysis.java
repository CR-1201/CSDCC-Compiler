package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Stack;

public class LoopAnalysis implements Pass {
    private Module module = Module.getModule();
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                analyzeLoopInfo(function);
                for (Loop loop : allLoops) {
                    System.out.println(loop.toString());
                }
            }
        }
    }
    // 函数内部的所有的Loop
    private final ArrayList<Loop> allLoops = new ArrayList<>();
    // 顶层Loop
    private final ArrayList<Loop> topLoops = new ArrayList<>();

    private void analyzeLoopInfo(Function function) {
        clear();
        ArrayList<BasicBlock> latches = new ArrayList<>();
        ArrayList<BasicBlock> domPostOrder = Dom.getDomTreePostOrder(function);
        for (BasicBlock block : domPostOrder) {
            for (BasicBlock prec : block.getPrecursors()) {
                if (block.isDominator(prec)) {
                    latches.add(prec);
                }
            }
            if (!latches.isEmpty()) {
                Loop loop = new Loop(block, latches);
                completeLoop(loop, latches);
                latches.clear();
            }
        }
        setLoopRelation(function.getFirstBlock());
    }
    private void clear() {
        allLoops.clear();
        topLoops.clear();
    }

    /**
     * 根据新建的 Loop 和该 Loop 的 End 块，确定 Loop 中的基本块
     * @param loop 新建的 loop
     * @param latches 该 Loop 的 End 块
     */
    private void completeLoop(Loop loop, ArrayList<BasicBlock> latches) {
        ArrayList<BasicBlock> loopLatches = new ArrayList<>(latches);
        while (!loopLatches.isEmpty()) {
            BasicBlock latch = loopLatches.remove(0);
            Loop curLoop = latch.getLoop();
            if (curLoop == null) {
                latch.setLoop(loop);
                if (latch == loop.getHeader()) {
                    continue;
                }
                loopLatches.addAll(latch.getPrecursors());
            } else {
                Loop parent = curLoop.getParent();
                while (parent != null) {
                    curLoop = parent;
                    parent = parent.getParent();
                }
                if (curLoop == loop) {
                    continue;
                }
                curLoop.setParent(loop);
                for (BasicBlock prec : curLoop.getHeader().getPrecursors()) {
                    if (prec.getLoop() != curLoop) {
                        loopLatches.add(prec);
                    }
                }
            }
        }
    }

    /**
     * 确定 Loop 之间的关系，并且计算循环深度
     * @param funcEntry 函数的入口基本块
     */
    private void setLoopRelation(BasicBlock funcEntry) {
        Stack<BasicBlock> stack = new Stack<>();
        HashSet<BasicBlock> visited = new HashSet<>();
        stack.push(funcEntry);
        while (!stack.isEmpty()) {
            BasicBlock curBlock = stack.pop();
            visited.add(curBlock);
            Loop child = curBlock.getLoop();
            if (child != null && curBlock == child.getHeader()) {
                Loop parent = child.getParent();
                if (parent != null) {
                    parent.addChild(child);
                    allLoops.add(child);
                } else {
                    topLoops.add(child);
                    allLoops.add(child);
                }
                int depth = 1;
                Loop tmp = child.getParent();
                while (tmp != null) {
                    tmp = tmp.getParent();
                    depth++;
                }
                child.setDepth(depth);
            }
            while (child != null) {
                child.addBlock(curBlock);
                child = child.getParent();
            }
            for (BasicBlock succ : curBlock.getSuccessors()) {
                if (!visited.contains(succ)) {
                    stack.push(succ);
                }
            }
        }
    }
}

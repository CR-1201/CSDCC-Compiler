package pass.analysis;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.binaryInstructions.Icmp;

import java.util.ArrayList;
import java.util.HashSet;

public class Loop {
    private static int idCounter = 0;
    private int id;
    private int depth;
    /**
     * 该 Loop 的父 Loop
     */
    private Loop parent;
    /**
     * Header: 存在唯一的 Basic Block，使得它支配 Loop 中包含的所有 Basic Block。这个 Basic Block 称为 Header。
     */
    private BasicBlock header;
    /**
     * Latch: Latch 指后继包含 Header 的 Basic Block，可以理解为跳转到循环头的基本块
     */
    private HashSet<BasicBlock> latches = new HashSet<>();
    /**
     * Exit: 退出循环后，第一个到达的基本块
     */
    private HashSet<BasicBlock> exits = new HashSet<>();
    /**
     * Exiting: 即将要退出循环的块，即 Exiting 块可以跳转到 Exit 块
     */
    private HashSet<BasicBlock> exitings = new HashSet<>();
    /**
     * Loop 中包含的全部基本块
     */
    private ArrayList<BasicBlock> allBlocks = new ArrayList<>();
    /**
     * subLoops：该 Loop 的子 Loop
     */
    private ArrayList<Loop> children = new ArrayList<>();

    // ========================= Inductor Var =========================
    private Value idcVar = null;
    private Value idcEnd = null;
    private Value idcInit = null;
    private Value idcAlu = null;
    private Value idcStep = null;
    private Icmp cond = null;
    private int loopTimes;
    private boolean isSetInductorVar = false;

    public Loop (BasicBlock header, HashSet<BasicBlock> latches) {
        this.id = idCounter++;
        header.setLoop(this);
        this.header = header;
        this.latches.addAll(latches);
    }

    public Loop getParent() {
        return parent;
    }

    public void setParent(Loop parent) {
        this.parent = parent;
    }

    public BasicBlock getHeader() {
        return header;
    }

    public void addLatch(BasicBlock latch) {
        latches.add(latch);
    }

    public HashSet<BasicBlock> getLatches() {
        return latches;
    }

    public void setLatches(HashSet<BasicBlock> latches) {
        this.latches = latches;
    }

    public void addExit(BasicBlock exit) {
        exits.add(exit);
    }

    public HashSet<BasicBlock> getExits() {
        return exits;
    }

    public void setExits(HashSet<BasicBlock> exits) {
        this.exits = exits;
    }

    public void addExiting(BasicBlock exiting) {
        exitings.add(exiting);
    }

    public HashSet<BasicBlock> getExitings() {
        return exitings;
    }

    public void addChild(Loop child) {
        if (!children.contains(child)) {
            children.add(child);
        }
    }

    public void removeChild(Loop child) {
        children.remove(child);
    }

    public ArrayList<Loop> getChildren() {
        return children;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    public int getDepth() {
        return depth;
    }

    public void addBlock(BasicBlock block) {
        if (!allBlocks.contains(block)) {
            allBlocks.add(block);
        }
    }

    public ArrayList<BasicBlock> getAllBlocks() {
        return allBlocks;
    }

    public void removeBlock(BasicBlock block) {
        allBlocks.remove(block);
    }

    public void removeSelf() {
        for (BasicBlock block : allBlocks) {
            block.removeLoop();
        }
        for (Loop loop : children) {
            loop.removeSelf();
        }
    }

    public ArrayList<Loop> computeDfsLoops() {
        ArrayList<Loop> ans = new ArrayList<>();
        for (Loop child : children) {
            ans.addAll(child.computeDfsLoops());
        }
        ans.add(this);
        return ans;
    }

    public HashSet<BasicBlock> computeAllExits() {
        HashSet<BasicBlock> ans = new HashSet<>();
        ans.addAll(exits);
        for (Loop child : children) {
            ans.addAll(child.computeAllExits());
        }
        return ans;
    }

    public HashSet<BasicBlock> computeChildrenExits() {
        HashSet<BasicBlock> ans = new HashSet<>();
        for (Loop child : children) {
            ans.addAll(child.computeChildrenExits());
            ans.addAll(child.getExits());
        }
        return ans;
    }

    public int computeLoopSize() {
        int loopSize = 0;
        for (BasicBlock block : this.getAllBlocks()) {
            loopSize += block.getInstructions().size();
        }
        return loopSize;
    }

    public ArrayList<BasicBlock> computeDfsBlocksFromEntry(BasicBlock entry) {
        return entry.computeDfsSuccBlocks();
    }

    /**
     * 循环结构：
     * int i;
     * while (i < n) {
     *     i = i + k;
     * }
     * 特征为：
     * 1、只有一个 latch
     * 2、只有一个 Exit
     * 3、只有一个 Exiting
     * 4、Header 只有两个前驱
     * @return true/false
     */
    public Boolean isSimpleLoop() {
        if (header.getPrecursors().size() != 2) {
            return false;
        }
        if (latches.size() != 1) {
            return false;
        }
        if (exits.size() != 1) {
            return false;
        }
        if (exitings.size() != 1) {
            return false;
        }
        BasicBlock exiting = exitings.iterator().next();
        return exiting == header;
    }

    public void setInductorVar(Value idcVar, Value idcEnd, Value idcInit, Value idcAlu, Value idcStep, Icmp cond) {
        this.idcVar = idcVar;
        this.idcEnd = idcEnd;
        this.idcInit = idcInit;
        this.idcAlu = idcAlu;
        this.idcStep = idcStep;
        this.cond = cond;
        this.isSetInductorVar = true;
    }

    public Value getIdcVar() {
        return idcVar;
    }

    public Value getIdcEnd() {
        return idcEnd;
    }

    public Value getIdcInit() {
        return idcInit;
    }

    public Value getIdcAlu() {
        return idcAlu;
    }

    public Value getIdcStep() {
        return idcStep;
    }

    public Icmp getCond() {
        return cond;
    }

    public void setLoopTimes(int loopTimes) {
        this.loopTimes = loopTimes;
    }

    public int getLoopTimes() {
        return loopTimes;
    }
    public Boolean getIsSetInductorVar() {
        return isSetInductorVar;
    }
}

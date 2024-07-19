package pass.analysis;

import ir.BasicBlock;

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
}

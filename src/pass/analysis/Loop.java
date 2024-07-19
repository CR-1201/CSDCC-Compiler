package pass.analysis;

import ir.BasicBlock;

import java.util.ArrayList;

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
     * Latch: Latch 指后继包含 Header 的 Basic Block
     */
    private ArrayList<BasicBlock> latches = new ArrayList<>();
    /**
     * Loop 中包含的全部基本块
     */
    private ArrayList<BasicBlock> allBlocks = new ArrayList<>();
    /**
     * subLoops：该 Loop 的子 Loop
     */
    private ArrayList<Loop> children = new ArrayList<>();
    public Loop (BasicBlock header, ArrayList<BasicBlock> latches) {
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
    public void addChild(Loop child) {
        if (!children.contains(child)) {
            children.add(child);
        }
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
}

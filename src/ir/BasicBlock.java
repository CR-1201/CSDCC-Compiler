package ir;

import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.types.LabelType;
import pass.analysis.Loop;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Stack;

/**
 @author Conroy
 一个基本块由若干 instruction 组成,且最后一条指令一定为终结指令 ( ret / br )
 支持 3 种插入指令的方式(插在末尾,插在某个指令之前,插在头部)
 Attention : BasicBlock 不是 user,它并不使用 Instruction
 */
public class BasicBlock extends Value{
    // 指令集合
    private final LinkedList<Instruction> instructions = new LinkedList<>();
    // 前驱与后继基本块,不讲求顺序,因此不用链表
    private final HashSet<BasicBlock> precursors = new HashSet<>();
    private final HashSet<BasicBlock> successors = new HashSet<>();
    // 当前基本块支配的基本块
    private HashSet<BasicBlock> doms = new HashSet<>();
    // 当前基本块的必经基本块，即当前基本块的支配者
    private HashSet<BasicBlock> domers = new HashSet<>();
    // 当前基本块直接支配的基本块
    private HashSet<BasicBlock> idoms = new HashSet<>();
    // 直接支配当前基本块的基本块
    private BasicBlock idomer;
    // 在支配树中的深度
    private int domLevel;
    // ========================== Loop Info ==========================
    // 当前 Basicblock 所在的循环，如果 loop 为 null，说明此BasicBlock不在任何循环中
    private Loop loop;
    // 支配边际,即刚好不被当前基本块支配的基本块
    private final HashSet<BasicBlock> dominanceFrontier = new HashSet<>();

    public LinkedList<Instruction> getInstructions(){
        return instructions;
    }

    public ArrayList<Instruction> getInstructionsArray(){
        return new ArrayList<>(instructions);
    }

    public HashSet<BasicBlock> getPrecursors(){
        return precursors;
    }

    public HashSet<BasicBlock> getSuccessors(){
        return successors;
    }

    // ========================== Dom Info ==========================

    public void setDomLevel(int domLevel) {
        this.domLevel = domLevel;
    }

    public HashSet<BasicBlock> getDoms(){
        return doms;
    }

    public void setDoms(HashSet<BasicBlock> doms){
        this.doms = doms;
    }

    public HashSet<BasicBlock> getDomers() {
        return domers;
    }

    public void setDomers(HashSet<BasicBlock> domers) {
        this.domers = domers;
    }

    public void addDomer(BasicBlock domer){
        domers.add(domer);
    }

    public HashSet<BasicBlock> getIdoms(){
        return idoms;
    }

    public void setIdoms(HashSet<BasicBlock> idoms){
        this.idoms = idoms;
    }

    public void addIdom(BasicBlock idom){
        idoms.add(idom);
    }

    public BasicBlock getIDomer(){
        return idomer;
    }

    public void setIdomer(BasicBlock idomer){
        this.idomer = idomer;
    }

    public int getDomLevel() {
        return domLevel;
    }

    public HashSet<BasicBlock> getDominanceFrontier(){
        return dominanceFrontier;
    }

    public void addDominanceFrontier(BasicBlock domFrontier){
        dominanceFrontier.add(domFrontier);
    }

    /**
     * 返回当前块是否是 other 的支配者
     * @param other 另一个块
     * @return 是则为 true
     */
    public boolean isDominator(BasicBlock other){
        return other.domers.contains(this);
    }

    // =================================================================
    // ========================== Loop Info ==========================

    public Loop getLoop() {
        return loop;
    }

    public int getLoopDepth() {
        if (loop == null) {
            return 0;
        } else return loop.getDepth();
    }

    public void setLoop(Loop loop) {
        this.loop = loop;
    }

    public BasicBlock(int nameNum, Function parent){
        super("%b" + nameNum, new LabelType(), parent);
        parent.addFunctionSymbol(this);
    }

    // 这个 block 主要用于控制 break 和 continue 后的语句
    public BasicBlock(){
        super("%LOOP_TMP", new LabelType(), Function.LOOP_TRASH);
    }

    public void insertTail(Instruction instruction){
        instructions.add(instruction);
    }

    // 将 instruction 插入到 target 指令的前面
    public void insertBefore(Instruction inst, Instruction target){
        for (Instruction oldInst : instructions) {
            if (oldInst.equals(target)){
                int index = instructions.indexOf(oldInst);
                instructions.add(index, inst);
                if (inst.getParent() != this) {
                    inst.setParent(this);
                }
                return;
            }
        }
    }

    public void insertHead(Instruction instruction){
        instructions.add(0,instruction);
    }

    public void removeInstruction(Instruction instruction) {
        instructions.remove(instruction);
    }

    public void removeLastInst(){
        Instruction lastInst = getTailInstruction();
        lastInst.removeSelf();
    }

    public void addPrecursor(BasicBlock precursor){
        precursors.add(precursor);
    }

    public void addSuccessor(BasicBlock successor){
        successors.add(successor);
    }

    public void removeSuccessor(BasicBlock successor){
        successors.remove(successor);
        successor.getPrecursors().remove(this);
    }

    public void removePrecursor(BasicBlock precursor){
        precursors.remove(precursor);
        precursor.getSuccessors().remove(this);
    }

    public ArrayList<BasicBlock> computeDfsSuccBlocks() {
        HashSet<BasicBlock> visited = new HashSet<>();
        Stack<BasicBlock> stack = new Stack<>();
        ArrayList<BasicBlock> dfs = new ArrayList<>();
        stack.add(this);
        visited.add(this);
        while (!stack.isEmpty()) {
            BasicBlock top = stack.pop();
            dfs.add(top);
            if (!top.getSuccessors().isEmpty()) {
                for (BasicBlock succ : top.getSuccessors()) {
                    if (!visited.contains(succ)) {
                        visited.add(succ);
                        stack.push(succ);
                    }
                }
            }
        }
        return dfs;
    }

    /**
     * precursor - successor 是一对双向关系
     * @param oldBlock 原有 block
     * @param newBlock 现有 block
     */
    public void replaceSuccessor(BasicBlock oldBlock, BasicBlock newBlock){
        removeSuccessor(oldBlock);
        oldBlock.removePrecursor(this);
        addSuccessor(newBlock);
        newBlock.addPrecursor(this);

//        successors.remove(oldBlock);
//        oldBlock.precursors.remove(this);
//        successors.add(newBlock);
        // 个人觉得要加这句话,后续有bug注意一下
//        newBlock.precursors.add(this);
    }

    /**
     * 获得结尾的指令,如果结尾没有指令,那么返回 null
     * @return 结尾指令
     */
    public Instruction getTailInstruction(){
        if (instructions.isEmpty()){
            return null;
        }else{
            return instructions.getLast();
        }
    }

    /**
     * 获得首指令,如果开头没有指令,那么返回 null
     * @return 首指令
     */
    public Instruction getHeadInstruction(){
        if (instructions.isEmpty()){
            return null;
        }else{
            return instructions.getFirst();
        }
    }

    // BasicBlock 的 parent 一定是 Function
    @Override
    public Function getParent(){
        return (Function) super.getParent();
    }

    public void removeSelf() {
        for (BasicBlock successor : this.getSuccessors()) {
            successor.getPrecursors().remove(this);
        }
        for (Instruction inst : instructions) {
            inst.removeAllOperators();
            // 这里 parent 等下要被删掉了，没必要再erase，反而会报错。
//            inst.eraseFromParent();
        }
        getParent().removeBlock(this);
    }

    public void removeFromParent() {
        getParent().removeBlock(this);
    }

    public ArrayList<Phi> getPhiUsers() {
        ArrayList<Phi> phis = new ArrayList<>();
        for (User user : getUsers()) {
            if (user instanceof Phi phi) {
                phis.add(phi);
            }
        }
        return phis;
    }

    public Br getUselessBr() {
        if (getInstructions().size() == 1 && getTailInstruction() instanceof Br br)
            return br;
        else
            return null;
    }

    @Override
    public String toString(){
        // 将 % 去掉,因为只有在跳转指令里需要加上这个
        StringBuilder s = new StringBuilder(getName().substring(1)).append(":\n");
        for (Instruction instructionNode : instructions){
            s.append('\t').append(instructionNode).append('\n');
        }
        if (!instructions.isEmpty()) {
            s.deleteCharAt(s.length() - 1);
        }
        return s.toString();
    }

}

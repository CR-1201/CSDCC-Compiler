package ir.instructions.terminatorInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.VoidType;

import java.util.ArrayList;

public class Br extends TerInstruction{
    // 有条件跳转还是无条件跳转
    private boolean hasCondition;

    public Br(BasicBlock parent, BasicBlock target){
        super(new VoidType(), parent, new ArrayList<>(){{
            add(target);
        }});
        hasCondition = false;
        if (target != null){
            parent.addSuccessor(target);
            target.addPrecursor(parent);
        }
    }

    public Br(BasicBlock parent, Value condition, BasicBlock trueBlock, BasicBlock falseBlock){
        super(new VoidType(), parent, new ArrayList<>(){{
            add(condition);add(trueBlock);add(falseBlock);
        }});
        hasCondition = true;
        if (trueBlock != null){
            parent.addSuccessor(trueBlock);
            trueBlock.addPrecursor(parent);
        }
        if (falseBlock != null) {
            parent.addSuccessor(falseBlock);
            falseBlock.addPrecursor(parent);
        }
    }

    public Value getCond() {
        if (hasCondition) {
            return getOperator(0);
        }
        return null;
    }

    public BasicBlock getTrueBlock() {
        if (hasCondition) {
            return (BasicBlock) getOperator(1);
        }
        return null;
    }

    public BasicBlock getFalseBlock() {
        if (hasCondition) {
            return (BasicBlock) getOperator(2);
        }
        return null;
    }
    public boolean getHasCondition(){
        return hasCondition;
    }

    public void setHasCondition(boolean hasCondition){
        this.hasCondition = hasCondition;
    }

    // 指令的全部操作数,使用前需要用hasCondition()判定是否为有条件跳转
    public ArrayList<Value> getOps(){
        ArrayList<Value> result = new ArrayList<>();
        int n = hasCondition ? 2 : 0;
        for( int i = 0 ; i <= n ; i++ ){
            result.add(getOperator(i));
        }
        return result;
    }

    @Override
    public void setOperator(int index, Value newValue){
        if (!hasCondition) {
            BasicBlock oldBlock = (BasicBlock) getOperator(index);
            getParent().replaceSuccessor(oldBlock, (BasicBlock) newValue);
        }else {
            if (index > 0){
                BasicBlock oldBlock = (BasicBlock) getOperator(index);
                getParent().replaceSuccessor(oldBlock, (BasicBlock) newValue);
            }
        }
        super.setOperator(index, newValue);
    }

    public void removeSelf() {
        ArrayList<BasicBlock> succs = new ArrayList<>();
        if (hasCondition) {
            succs.add((BasicBlock) getOperator(1));
            succs.add((BasicBlock) getOperator(2));
        } else {
            succs.add((BasicBlock) getOperator(0));
        }
        for (BasicBlock succ : succs) {
            getParent().removeSuccessor(succ);
        }
        removeAllOperators();
        eraseFromParent();
    }

    public void cond2jump(BasicBlock target) {
        hasCondition = false;
        removeAllOperators();
        addOperator(target);
    }

    public void move2Block(BasicBlock target) {
        if (hasCondition) {
            BasicBlock trueBlock = (BasicBlock) getOperator(1);
            BasicBlock falseBlock = (BasicBlock) getOperator(2);
            trueBlock.replacePrecursor(getParent(), target);
            falseBlock.replacePrecursor(getParent(), target);
        } else {
            BasicBlock block = (BasicBlock) getOperator(0);
            block.replacePrecursor(getParent(), target);
        }
        eraseFromParent();
        target.insertTail(this);
        this.setParent(target);
    }

    @Override
    public String toString(){
        StringBuilder result = new StringBuilder("br " + getOperator(0).getValueType() + " " + getOperator(0).getName());
        int n = hasCondition ? 2 : 0;
        for( int i = 1 ; i <= n ; i++ ){
            result.append(", ").append(getOperator(i).getValueType()).append(" ").append(getOperator(i).getName());
        }
        return result.toString();
    }
}

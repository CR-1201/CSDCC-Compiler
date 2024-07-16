package ir.instructions.terminatorInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.VoidType;

import java.util.ArrayList;

/**
 @author Conroy
 br i1 <cond>, label <iftrue>, label <iffalse>
 br label <dest>
 FIXME
 如果让 Br 在新建的时候就维护 CFG 图,就会出现过于耦联的结果
 比如说 break 的时候会导致一个正常的块有一个 TMP_BLOCK 的前驱
 */

public class Br extends TerInstruction{
    // 有条件跳转还是无条件跳转
    private final boolean hasCondition;

    /**
     * 无条件跳转
     * @param target 唯一的操作数,目标基本块
     */
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

    /**
     * 有条件跳转
     * @param condition  第一个操作数,条件
     * @param trueBlock  第二个操作数,条件成立目标
     * @param falseBlock 第三个操作数,条件不成立目标
     */
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

    public boolean getHasCondition(){
        return hasCondition;
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

    /**
     * 重载 updateValue 方法,如果设置的是跳转基本块,会自动更新所属 Block 的 successor
     * @param index 索引
     * @param newValue 新 Value
     */
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

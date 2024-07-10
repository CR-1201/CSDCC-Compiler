package ast;

import ir.BasicBlock;

// TODO
//  Cond -> LOrExp
public class Cond extends Node{
    private LOrExp lOrExp = null;
    public Cond(LOrExp lOrExp) {
        this.lOrExp = lOrExp;
        childNode.add(lOrExp);
    }

    public LOrExp getLOrExp() {
        return lOrExp;
    }

    // 短路求值
    private BasicBlock trueBlock = null;
    private BasicBlock falseBlock = null;

    public void setTrueBlock(BasicBlock trueBlock) {
        this.trueBlock = trueBlock;
    }

    public void setFalseBlock(BasicBlock falseBlock) {
        this.falseBlock = falseBlock;
    }

    @Override
    public void buildIrTree() {
        lOrExp.setTrueBlock(trueBlock);
        lOrExp.setFalseBlock(falseBlock);
        lOrExp.buildIrTree();
    }

    @Override
    public void accept() {

    }
}

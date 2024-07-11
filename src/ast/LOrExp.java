package ast;

import ir.BasicBlock;
import token.Token;

// TODO
//  LOrExp -> LAndExp | LOrExp '||' LAndExp
public class LOrExp extends Node{
    private LAndExp lAndExp = null;
    private LOrExp lOrExp = null;
    private Token op = null;

    private BasicBlock trueBlock = null;
    private BasicBlock falseBlock = null;

    public LOrExp(LAndExp lAndExp) {
        this.lAndExp = lAndExp;
    }

    public LOrExp(LOrExp lOrExp, LAndExp lAndExp, Token op){
        this.lOrExp = lOrExp;
        this.lAndExp = lAndExp;
        this.op = op;
        childNode.add(lOrExp);
        childNode.add(lAndExp);
    }

    public void setTrueBlock(BasicBlock trueBlock) {
        this.trueBlock = trueBlock;
    }

    public void setFalseBlock(BasicBlock falseBlock) {
        this.falseBlock = falseBlock;
    }

    /**
     * 所谓的短路求值,描述的是这样的一个过程,对于由 && 连接的多个表达式
     * 当某个表达式被求值的时候,如果是 true,那么不会直接进入 trueBlock,
     * 而是会进入一个新的 block,在这个 block 里会判断下一个表达式
     * 但是如果是 false,那么就会直接进入 falseBlock
     * 对于 || 连接的多个表达式
     * 当某个表达式被求值的时候,如果是 true,那么会直接进入 trueBlock,
     * 如果是 false,则会进入一个新的 block 判断下一个表达式
     */
    @Override
    public void buildIrTree() {
        if( lOrExp != null ){
            lAndExp.setTrueBlock(trueBlock);
            BasicBlock nextBlock = builder.buildBasicBlock(curFunc);
            lAndExp.setFalseBlock(nextBlock);
            lAndExp.buildIrTree();
            curBlock = nextBlock;
            lOrExp.buildIrTree();
        } else {
            lAndExp.setTrueBlock(trueBlock);
            lAndExp.setFalseBlock(falseBlock);
            lAndExp.buildIrTree();
        }
    }

    @Override
    public void accept() {

    }
}

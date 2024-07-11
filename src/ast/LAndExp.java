package ast;

import ir.BasicBlock;
import ir.constants.ConstInt;
import ir.instructions.binaryInstructions.Icmp;
import token.Token;

// TODO
//  LAndExp -> EqExp | LAndExp '&&' EqExp
public class LAndExp extends Node{
    private EqExp eqExp = null;
    private LAndExp lAndExp = null;
    private Token op = null;

    private BasicBlock trueBlock = null;
    private BasicBlock falseBlock = null;

    public LAndExp(EqExp eqExp) {
        this.eqExp = eqExp;
    }

    public LAndExp(LAndExp lAndExp, EqExp eqExp, Token op) {
        this.lAndExp = lAndExp;
        this.eqExp = eqExp;
        this.op = op;
        childNode.add(lAndExp);
        childNode.add(eqExp);
    }

    public void setTrueBlock(BasicBlock trueBlock) {
        this.trueBlock = trueBlock;
    }

    public void setFalseBlock(BasicBlock falseBlock) {
        this.falseBlock = falseBlock;
    }

    @Override
    public void buildIrTree() {
        BasicBlock nextBlock = builder.buildBasicBlock(curFunc);
        i32InRelUp = true;
        eqExp.buildIrTree();
        if (i32InRelUp) { // 在这里,将某个为 I32 的 eqExp 变成 I1
            i32InRelUp = false;
            valueUp = builder.buildIcmp(curBlock, Icmp.Condition.NE, valueUp, ConstInt.ZERO);
        }
        // 错了就直接进入 falseBlock
        builder.buildBr(curBlock, valueUp, nextBlock, falseBlock);
        curBlock = nextBlock;
        if( lAndExp != null ){
            lAndExp.buildIrTree();
        } else {
            builder.buildBr(curBlock, trueBlock);
        }
    }

    @Override
    public void accept() {

    }
}

package ast;

import ir.BasicBlock;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.binaryInstructions.Icmp;
import ir.types.FloatType;
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
        if( lAndExp != null ){
            BasicBlock nextBlock = builder.buildBasicBlock(curFunc);
            lAndExp.setTrueBlock(nextBlock);
            lAndExp.setFalseBlock(falseBlock);
            lAndExp.buildIrTree();

            curBlock = nextBlock;
        }
        eqExp.buildIrTree();
        if (i32InRelUp) { // 在这里,将某个为 I32 的 eqExp 变成 I1
            i32InRelUp = false;
            if( valueUp.getValueType() instanceof FloatType ){
                valueUp = builder.buildIcmp(curBlock, Icmp.Condition.NE, valueUp, ConstFloat.ZERO);
            } else valueUp = builder.buildIcmp(curBlock, Icmp.Condition.NE, valueUp, ConstInt.ZERO);

        }
        // 错了就直接进入 falseBlock
        builder.buildBr(curBlock, valueUp, trueBlock, falseBlock);
    }

    @Override
    public void accept() {

    }
}

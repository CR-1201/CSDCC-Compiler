package ast;

import ir.Value;
import ir.instructions.Binary_Instructions.Icmp;
import token.Token;

// TODO
//  RelExp -> AddExp | RelExp ('<' | '>' | '<=' | '>=') AddExp
public class RelExp extends Node{
    private AddExp addExp = null;
    private RelExp relExp = null;
    private Token op = null;

    public RelExp(AddExp addExp) {
        this.addExp = addExp;
    }

    public RelExp(RelExp relExp, AddExp addExp, Token op){
        this.relExp = relExp;
        this.addExp = addExp;
        this.op = op;
        childNode.add(addExp);
        childNode.add(relExp);
    }

    @Override
    public void buildIrTree() {
        addExp.buildIrTree();
        Value result = valueUp;
        if( relExp != null ){
            i32InRelUp = false;
            relExp.buildIrTree();
            Value adder = valueUp;
            // 如果类型不对，需要先换类型
            if( result.getValueType().isI1() ){
                result = builder.buildZext(curBlock, result);
            }
            if( adder.getValueType().isI1() ){
                adder = builder.buildZext(curBlock, adder);
            }
            if( op.getType() == Token.TokenType.LEQ ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.LE, result, adder);
            } else if( op.getType() == Token.TokenType.GEQ ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.GE, result, adder);
            } else if( op.getType() == Token.TokenType.GRE ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.GT, result, adder);
            } else if( op.getType() == Token.TokenType.LSS ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.LT, result, adder);
            }
        }
        valueUp = result;
    }

    @Override
    public void accept() {

    }
}

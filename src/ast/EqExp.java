package ast;

import ir.Value;
import ir.instructions.binaryInstructions.Icmp;
import ir.types.FloatType;
import token.Token;

// TODO
//  EqExp -> RelExp | EqExp ('==' | '!=') RelExp
public class EqExp extends Node{
    private RelExp relExp = null;
    private Token op = null;
    private EqExp eqExp = null;
    public EqExp(RelExp relExp) {
        this.relExp = relExp;
        childNode.add(relExp);
    }
    public EqExp(EqExp eqExp, RelExp relExp, Token op) {
        this.eqExp = eqExp;
        this.relExp = relExp;
        this.op = op;
        childNode.add(relExp);
        childNode.add(eqExp);
    }

    @Override
    public void buildIrTree() {
        Value adder = null;Value result;
        if( eqExp != null ){
            i32InRelUp = false;
            eqExp.buildIrTree();
            adder = valueUp;
        }
        relExp.buildIrTree();
        result = valueUp;

        if( adder != null ){
            // 如果类型不对，需要先换类型
            if (result.getValueType().isI1()) {
                result = builder.buildZext( curBlock, result);
            }
            if (adder.getValueType().isI1()) {
                adder = builder.buildZext( curBlock, adder);
            }
            if( (result.getValueType() instanceof FloatType) && !(adder.getValueType() instanceof FloatType) ){
                adder = builder.buildConversion(curBlock,"sitofp",new FloatType(), adder);
            }
            if( !(result.getValueType() instanceof FloatType) && (adder.getValueType() instanceof FloatType) ){
                result = builder.buildConversion(curBlock,"sitofp",new FloatType(), result);
            }

            if( op.getType() == Token.TokenType.EQL ){
                result = builder.buildIcmp( curBlock, Icmp.Condition.EQ, adder, result);
            } else if( op.getType() == Token.TokenType.NEQ ){
                result = builder.buildIcmp( curBlock, Icmp.Condition.NE, adder, result);
            }
        }

        valueUp = result;
    }

    @Override
    public void accept() {

    }
}

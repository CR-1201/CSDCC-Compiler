package ast;

import ir.Value;
import ir.instructions.binaryInstructions.Icmp;
import ir.types.FloatType;
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
        Value adder = null;
        Value result;
        if( relExp != null ){
            i32InRelUp = false;
            relExp.buildIrTree();
            adder = valueUp;
        }
        addExp.buildIrTree();
        result = valueUp;

        if( adder != null ){
            // 如果类型不对，需要先换类型
            if( result.getValueType().isI1() ){
                result = builder.buildZext(curBlock, result);
            }
            if( adder.getValueType().isI1() ){
                adder = builder.buildZext(curBlock, adder);
            }
            if( (result.getValueType() instanceof FloatType) && !(adder.getValueType() instanceof FloatType) ){
                adder = builder.buildConversion(curBlock,"sitofp",new FloatType(), adder);
            }
            if( !(result.getValueType() instanceof FloatType) && (adder.getValueType() instanceof FloatType) ){
                result = builder.buildConversion(curBlock,"sitofp",new FloatType(), result);
            }
            if( op.getType() == Token.TokenType.LEQ ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.LE, adder, result);
            } else if( op.getType() == Token.TokenType.GEQ ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.GE, adder, result);
            } else if( op.getType() == Token.TokenType.GRE ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.GT, adder, result);
            } else if( op.getType() == Token.TokenType.LSS ){
                result = builder.buildIcmp(curBlock, Icmp.Condition.LT, adder, result);
            }
        }

        valueUp = result;
    }

    @Override
    public void accept() {

    }
}

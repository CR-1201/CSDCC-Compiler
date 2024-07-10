package ast;

import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import token.Token;

// TODO
//  Number -> IntConst | floatConst
public class Number extends Node{
    private Token token = null;
    public Number(Token token) {
        this.token = token;
    }

    @Override
    public void buildIrTree() {
        if( token.getType() == Token.TokenType.DECCON || token.getType() == Token.TokenType.HEXCON || token.getType() == Token.TokenType.OCTCON){
            int num = Integer.parseInt(token.getContent());
            valueUp = new ConstInt(num);
        } else {
            float num = Float.parseFloat(token.getContent());
            valueUp = new ConstFloat(num);
        }
    }

    @Override
    public void accept() {

    }
}

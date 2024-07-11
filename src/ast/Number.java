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
        String content = token.getContent();
        int radix = 10; // 默认为十进制
        if( token.getType() == Token.TokenType.DECCON || token.getType() == Token.TokenType.HEXCON || token.getType() == Token.TokenType.OCTCON){
            if (token.getType() == Token.TokenType.HEXCON) {
                radix = 16;
                content = content.substring(2);
            } else if (token.getType() == Token.TokenType.OCTCON) {
                radix = 8;
            }
            int num = Integer.parseInt(content, radix);
            valueUp = new ConstInt(num);
        } else {
            float num = Float.parseFloat(content);
            valueUp = new ConstFloat(num);
        }
    }

    @Override
    public void accept() {

    }
}

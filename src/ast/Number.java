package ast;

import token.Token;

// TODO
//  Number -> IntConst | floatConst
public class Number extends Node{
    private Token token = null;
    public Number(Token token) {
        this.token = token;
    }
    @Override
    public void accept() {

    }
}

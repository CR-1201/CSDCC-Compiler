package ast;

import token.Token;

//  StrExp -> StrConst
public class StrExp extends Node{
    private Token token = null;
    public StrExp(Token token) {
        this.token = token;
    }
    @Override
    public void accept() {

    }
}

package ast;

import token.Token;

// TODO
//  UnaryOp -> '+' | '−' | '!'
public class UnaryOp extends Node{
    private Token token = null;
    public UnaryOp(Token token){
        this.token = token;
    }
    @Override
    public void accept() {

    }
}

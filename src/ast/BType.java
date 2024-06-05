package ast;

import token.Token;

// TODO
//  Type -> 'int' | 'float'
public class BType extends Node{
    private Token token;
    public BType(Token token){
        this.token = token;
    }

    public Token getToken() {
        return token;
    }

    @Override
    public void accept() {

    }
}

package ast;

import token.Token;

// TODO
//  FuncType -> 'void' | 'int' | 'float'
public class FuncType extends Node{
    private Token token = null;
    public FuncType(Token token) {
        this.token = token;
    }
    @Override
    public void accept() {

    }
}

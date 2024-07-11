package ast;

import token.Token;

// TODO
//  UnaryOp -> '+' | '−' | '!'
public class UnaryOp extends Node{
    private Token token = null;

    public UnaryOp(Token token){
        this.token = token;
    }

    public Token getToken(){
        return token;
    }

    @Override
    public void buildIrTree() {
        for (Node node : childNode) {
            node.buildIrTree();
        }
    }

    @Override
    public void accept() {

    }
}

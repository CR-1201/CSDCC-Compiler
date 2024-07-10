package ast;

import token.Token;

// TODO
//  FuncType -> 'void' | 'int' | 'float'
public class FuncType extends Node{
    private Token token = null;
    public FuncType(Token token) {
        this.token = token;
    }

    public Token getType() {
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

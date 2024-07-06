package ast;


import token.Token;

import java.util.List;

// TODO
//  ConstDef -> Ident { '[' ConstExp ']' } '=' ConstInitVal
public class ConstDef extends Node{
    private Token identToken;
    private List<ConstExp> constExps = null;
    private ConstInitVal constInitVal = null;

    public ConstDef(Token identToken, List<ConstExp> constExps, ConstInitVal constInitVal) {
        this.identToken = identToken;
        this.constExps = constExps;
        this.constInitVal = constInitVal;
    }

    public Token getIdentToken() {
        return identToken;
    }

    public List<ConstExp> getConstExps() {
        return constExps;
    }

    public ConstInitVal getConstInitVal() {
        return constInitVal;
    }

    @Override
    public void accept() {

    }
}

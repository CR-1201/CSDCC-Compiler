package ast;

import token.Token;

import java.util.List;

// TODO
//  VarDef -> Ident { '[' ConstExp ']' } | Ident { '[' ConstExp ']' } '=' InitVal
public class VarDef extends Node{
    private Token identToken = null;
    private List<ConstExp> constExps = null;
    private InitVal initVal = null;
    public VarDef(Token identToken, List<ConstExp> constExps) {
        this.identToken = identToken;
        this.constExps = constExps;
    }
    public VarDef(Token identToken, List<ConstExp> constExps, InitVal initVal) {
        this.identToken = identToken;
        this.constExps = constExps;
        this.initVal = initVal;
    }
    @Override
    public void accept() {

    }
}

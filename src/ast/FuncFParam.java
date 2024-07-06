package ast;

import token.Token;

import java.util.List;

// TODO
//  FuncFParam -> BType Ident ['[' ']' { '[' Exp ']' }]
public class FuncFParam extends Node{
    private BType bType = null;
    private Token identToken = null;
    private List<ConstExp> constExps;
    private Token lbrack;
    private Token rbrack;
    public FuncFParam( BType bType, Token identToken, Token lbrack, Token rbrack, List<ConstExp> constExps) {
        this.identToken = identToken;
        this.lbrack = lbrack;
        this.rbrack = rbrack;
        this.bType = bType;
        this.constExps = constExps;
    }
    @Override
    public void accept() {

    }
}

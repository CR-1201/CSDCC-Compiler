package ast;

import token.Token;

import java.util.List;

// TODO
//  FuncFParam -> BType Ident ['[' ']' { '[' Exp ']' }]
public class FuncFParam extends Node{
    private BType bType = null;
    private Token identToken = null;
    private List<Exp> exps;
    public FuncFParam(Token identToken, BType bType, List<Exp> exps) {
        this.identToken = identToken;
        this.bType = bType;
        this.exps = exps;
    }
    @Override
    public void accept() {

    }
}

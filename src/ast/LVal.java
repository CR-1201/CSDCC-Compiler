package ast;

import token.Token;

import java.util.List;

// TODO
//  LVal -> Ident {'[' Exp ']'}
public class LVal extends Node{
    private Token identToken = null;
    private List<Exp> exps = null;
    public LVal(Token identToken, List<Exp> exps) {
        this.identToken = identToken;
        this.exps = exps;
    }
    @Override
    public void accept() {

    }
}

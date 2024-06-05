package ast;

import token.Token;

// TODO
//  MulExp -> UnaryExp | MulExp ('*' | '/' | '%') UnaryExp
public class MulExp extends Node{
    private UnaryExp unaryExp = null;
    private MulExp mulExp = null;
    private Token op = null;
    public MulExp(UnaryExp unaryExp) {
        this.unaryExp = unaryExp;
    }
    public MulExp(MulExp mulExp, UnaryExp unaryExp, Token op) {
        this.mulExp = mulExp;
        this.unaryExp = unaryExp;
        this.op = op;
    }
    @Override
    public void accept() {

    }
}

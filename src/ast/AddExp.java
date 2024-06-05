package ast;

import token.Token;

// TODO
//  AddExp -> MulExp | AddExp ('+' | '−') MulExp
public class AddExp extends Node{
    private MulExp mulExp = null;
    private AddExp addExp = null;
    private Token op = null;
    public AddExp(MulExp mulExp, AddExp addExp, Token op) {
        this.mulExp = mulExp;
        this.addExp = addExp;
        this.op = op;
    }
    public AddExp(MulExp mulExp) {
        this.mulExp = mulExp;
    }

    public AddExp getAddExp() {
        return addExp;
    }

    @Override
    public void accept() {

    }
}

package ast;

import token.Token;

// TODO
//  LAndExp -> EqExp | LAndExp '&&' EqExp
public class LAndExp extends Node{
    private EqExp eqExp = null;
    private LAndExp lAndExp = null;
    private Token op = null;
    public LAndExp(EqExp eqExp) {
        this.eqExp = eqExp;
    }
    public LAndExp(LAndExp lAndExp, EqExp eqExp, Token op) {
        this.lAndExp = lAndExp;
        this.eqExp = eqExp;
        this.op = op;
    }
    @Override
    public void accept() {

    }
}

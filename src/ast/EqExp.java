package ast;

import token.Token;

// TODO
//  EqExp -> RelExp | EqExp ('==' | '!=') RelExp
public class EqExp extends Node{
    private RelExp relExp = null;
    private Token op = null;
    private EqExp eqExp = null;
    public EqExp(RelExp relExp) {
        this.relExp = relExp;
    }
    public EqExp(EqExp eqExp, RelExp relExp, Token op) {
        this.eqExp = eqExp;
        this.relExp = relExp;
        this.op = op;
    }
    @Override
    public void accept() {

    }
}

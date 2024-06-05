package ast;

import token.Token;

// TODO
//  LOrExp -> LAndExp | LOrExp '||' LAndExp
public class LOrExp extends Node{
    private LAndExp lAndExp = null;
    private LOrExp lOrExp = null;
    private Token op = null;
    public LOrExp(LAndExp lAndExp) {
        this.lAndExp = lAndExp;
    }
    public LOrExp(LOrExp lOrExp, LAndExp lAndExp, Token op){
        this.lOrExp = lOrExp;
        this.lAndExp = lAndExp;
        this.op = op;
    }
    @Override
    public void accept() {

    }
}

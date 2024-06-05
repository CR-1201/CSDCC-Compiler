package ast;

// TODO
//  Cond -> LOrExp
public class Cond extends Node{
    private LOrExp lOrExp = null;
    public Cond(LOrExp lOrExp) {
        this.lOrExp = lOrExp;
    }

    public LOrExp getLOrExp() {
        return lOrExp;
    }

    @Override
    public void accept() {

    }
}

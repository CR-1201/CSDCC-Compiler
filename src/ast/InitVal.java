package ast;

import java.util.List;

// TODO
//  InitVal -> Exp | '{' [ InitVal { ',' InitVal } ] '}'
public class InitVal extends Node{
    private Exp exp = null;
    private List<InitVal> initVals = null;
    public InitVal(Exp exp) {
        this.exp = exp;
    }
    public InitVal(List<InitVal> initVals) {
        this.initVals = initVals;
    }
    @Override
    public void accept() {

    }
}

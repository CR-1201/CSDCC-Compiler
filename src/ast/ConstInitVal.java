package ast;

import java.util.List;

// TODO
//  ConstInitVal -> ConstExp | '{' [ ConstInitVal { ',' ConstInitVal } ] '}'
public class ConstInitVal extends Node{
    private ConstExp constExp = null;
    private List<ConstInitVal> constInitVals = null;
    public ConstInitVal(ConstExp constExp) {
        this.constExp = constExp;
    }
    public ConstInitVal(List<ConstInitVal> constInitVals) {
        this.constInitVals = constInitVals;
    }
    @Override
    public void accept() {

    }
}

package ast;

// TODO
//  PrimaryExp -> '(' Exp ')' | LVal | Number
public class PrimaryExp extends Node{
    private Exp exp = null;
    private LVal lVal = null;
    private Number number = null;
    public PrimaryExp(Exp exp) {
        this.exp = exp;
    }
    public PrimaryExp(LVal lVal) {
        this.lVal = lVal;
    }
    public PrimaryExp(Number number) {
        this.number = number;
    }
    @Override
    public void accept() {

    }
}

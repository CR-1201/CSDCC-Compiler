package ast;

// TODO
//  Exp -> AddExp
public class Exp extends Node{
    private AddExp addExp = null;
    public Exp(AddExp addExp) {
        this.addExp = addExp;
    }
    @Override
    public void accept() {

    }
}

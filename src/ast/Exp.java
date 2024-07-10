package ast;

import ir.instructions.Binary_Instructions.Sdiv;

// TODO
//  Exp -> AddExp | StrExp
public class Exp extends Node{
    private AddExp addExp = null;
    private StrExp strExp = null;
    public Exp(AddExp addExp) {
        this.addExp = addExp;
    }

    public Exp(StrExp strExp) {
        this.strExp = strExp;
    }

    @Override
    public void accept() {

    }
}

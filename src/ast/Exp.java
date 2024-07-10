package ast;

import ir.instructions.Binary_Instructions.Sdiv;

// TODO
//  Exp -> AddExp | StrExp
public class Exp extends Node{
    private AddExp addExp = null;
    private StrExp strExp = null;
    public Exp(AddExp addExp) {
        this.addExp = addExp;
        childNode.add(addExp);
    }

    public Exp(StrExp strExp) {
        this.strExp = strExp;
        childNode.add(strExp);
    }

    @Override
    public void buildIrTree() {
        for (Node node : childNode) {
            node.buildIrTree();
        }
    }

    @Override
    public void accept() {

    }
}

package ast;

import token.Token;

// TODO
//  RelExp -> AddExp | RelExp ('<' | '>' | '<=' | '>=') AddExp
public class RelExp extends Node{
    private AddExp addExp = null;
    private RelExp relExp = null;
    private Token op = null;
    public RelExp(AddExp addExp) {
        this.addExp = addExp;
    }
    public RelExp(RelExp relExp, AddExp addExp, Token op){
        this.relExp = relExp;
        this.addExp = addExp;
        this.op = op;
        childNode.add(addExp);
        childNode.add(relExp);
    }
    @Override
    public void accept() {

    }
}

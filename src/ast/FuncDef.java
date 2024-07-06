package ast;

import token.Token;

// TODO
// FuncDef -> FuncType Ident '(' [FuncFParams] ')' Block
public class FuncDef extends Node{
    private FuncType funcType = null;
    private Token identToken = null;
    private FuncFParams funcFParams = null;
    private Block block = null;
    public FuncDef(FuncType funcType, Token identToken, FuncFParams funcFParams, Block block) {
        this.identToken = identToken;
        this.funcType = funcType;
        this.funcFParams = funcFParams;
        this.block = block;
    }
    @Override
    public void accept() {

    }
}

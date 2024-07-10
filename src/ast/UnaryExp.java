package ast;


import token.Token;

// TODO
//  UnaryExp -> PrimaryExp | Ident '(' [FuncRParams] ')' | UnaryOp UnaryExp
public class UnaryExp extends Node{
    private PrimaryExp primaryExp = null;
    private Token identToken = null;
    private FuncRParams funcRParams = null;
    private UnaryOp unaryOp = null;
    private UnaryExp unaryExp = null;

    public UnaryExp(PrimaryExp primaryExp) {
        this.primaryExp = primaryExp;
    }
    public UnaryExp(Token identToken, FuncRParams funcRParams) {
        this.identToken = identToken;
        this.funcRParams = funcRParams;
    }
    public UnaryExp(UnaryOp unaryOp, UnaryExp unaryExp) {
        this.unaryOp = unaryOp;
        this.unaryExp = unaryExp;
    }

    @Override
    public void accept() {

    }
}

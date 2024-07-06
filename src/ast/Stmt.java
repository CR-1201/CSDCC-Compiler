package ast;

import token.Token;

// TODO
//  Stmt ->
//  LVal '=' Exp ';'
//  | [Exp] ';' | Block
//  | 'if' '( Cond ')' Stmt [ 'else' Stmt ]
//  | 'while' '(' Cond ')' Stmt
//  | 'break' ';' | 'continue' ';'
//  | 'return' [Exp] ';'
public class Stmt extends Node{

    private Exp exp;
    private LVal lVal;
    private int type;

    private Block block;

    private Cond cond;
    private Stmt stmt1;
    private Stmt stmt2;

    private Stmt stmt;

    private Token conBreakTk;
    public Stmt(int type, LVal lVal, Exp exp) {
       // LVal '=' Exp ';'
       this.type = type;
       this.lVal = lVal;
       this.exp = exp;
    }

    public Stmt(int type, Exp exp) {
        // [Exp] ';'
        this.type = type;
        this.exp = exp;
    }

    public Stmt(int type, Block block) {
        // Block
        this.type = type;
        this.block = block;
    }

    public Stmt(int type, Cond cond, Stmt stmt1, Stmt stmt2) {
        // 'if' '( Cond ')' Stmt [ 'else' Stmt ]
        this.type = type;
        this.cond = cond;
        this.stmt1 = stmt1;
        this.stmt2 = stmt2;
    }

    public Stmt(int type, Cond cond, Stmt stmt) {
        // 'while' '(' Cond ')' Stmt
        this.type = type;
        this.cond = cond;
        this.stmt = stmt;
    }

    public Stmt(int type, Token conBreakTk) {
        this.type = type;
        this.conBreakTk = conBreakTk;
    }

    @Override
    public void accept() {

    }
}

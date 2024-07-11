package ast;

import ir.types.DataType;

// TODO
//  BlockItem -> Decl | Stmt
public class BlockItem extends Node{
    private Decl decl = null;
    private Stmt stmt = null;

    private DataType returnType;

    public BlockItem(Decl decl) {
        this.decl = decl;
        childNode.add(decl);
    }

    public BlockItem(Stmt stmt) {
        this.stmt = stmt;
        childNode.add(stmt);
    }

    public void setReturnType(DataType returnType) {
        this.returnType = returnType;
    }

    public void buildIrTree(){
        if( decl != null ){
            decl.buildIrTree();
        } else {
            stmt.setReturnType(returnType);
            stmt.buildIrTree();
        }
    }

    @Override
    public void accept() {

    }
}

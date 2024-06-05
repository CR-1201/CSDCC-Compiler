package ast;

// TODO
//  BlockItem -> Decl | Stmt
public class BlockItem extends Node{
    private Decl decl = null;
    private Stmt stmt = null;
    public BlockItem(Decl decl) {
        this.decl = decl;
    }
    public BlockItem(Stmt stmt) {
        this.stmt = stmt;
    }
    @Override
    public void accept() {

    }
}

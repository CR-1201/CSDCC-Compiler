package ast;

// TODO
//  BlockItem -> Decl | Stmt
public class BlockItem extends Node{
    private Decl decl = null;
    private Stmt stmt = null;
    public BlockItem(Decl decl) {
        this.decl = decl;
        childNode.add(decl);
    }
    public BlockItem(Stmt stmt) {
        this.stmt = stmt;
        childNode.add(stmt);
    }


    @Override
    public void accept() {

    }
}

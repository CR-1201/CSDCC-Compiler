package ast;

import java.io.PrintStream;

// TODO
//  Decl -> ConstDecl | VarDecl
public class Decl extends Node{
    private ConstDecl constDecl = null;
    private VarDecl varDecl = null;

    public Decl(ConstDecl constDecl) {
        this.constDecl = constDecl;
        childNode.add(constDecl);
    }

    public Decl(VarDecl varDecl) {
        this.varDecl = varDecl;
        childNode.add(varDecl);
    }

    public ConstDecl getConstDecl() {
        return constDecl;
    }

    public VarDecl getVarDecl() {
        return varDecl;
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

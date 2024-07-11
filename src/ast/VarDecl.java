package ast;

import java.util.List;

// TODO
//  VarDecl -> BType VarDef { ',' VarDef } ';
public class VarDecl extends Node{
    private BType bType = null;
    private List<VarDef> varDefs = null;

    public VarDecl(BType bType, List<VarDef> varDefs) {
        this.bType = bType;
        this.varDefs = varDefs;
        childNode.addAll(varDefs);
    }

    public BType getBType() {
        return bType;
    }

    public List<VarDef> getVarDefs() {
        return varDefs;
    }

    @Override
    public void buildIrTree() {
        for (VarDef varDef : varDefs) {
            varDef.setBType(bType);
            varDef.buildIrTree();
        }
    }

    @Override
    public void accept() {

    }
}

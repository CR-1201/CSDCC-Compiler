package ast;

import java.util.List;

// TODO
//  ConstDecl -> 'const' BType ConstDef { ',' ConstDef } ';'
public class ConstDecl extends Node{
    private BType bType;
    private List<ConstDef> constDefs;
    public ConstDecl(BType bType, List<ConstDef> constDefs) {
        this.bType = bType;
        this.constDefs = constDefs;
        childNode.add(bType);
        childNode.addAll(constDefs);
    }

    public boolean getIsConst() {
        return true;
    }

    public BType getBType() {
        return bType;
    }

    public List<ConstDef> getConstDefs() {
        return constDefs;
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
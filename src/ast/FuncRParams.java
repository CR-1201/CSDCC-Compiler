package ast;

import java.util.List;

// TODO
//  FuncRParams -> Exp { ',' Exp }
// FuncFParams → FuncFParam { ',' FuncFParam }
public class FuncRParams extends Node{
    private List<Exp> exps = null;
    public FuncRParams(List<Exp> exps) {
        this.exps = exps;
        childNode.addAll(exps);
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

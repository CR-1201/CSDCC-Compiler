package ast;

import java.util.List;

// TODO
//  FuncRParams -> Exp { ',' Exp }
public class FuncRParams extends Node{
    private List<Exp> exps = null;
    public FuncRParams(List<Exp> exps) {
        this.exps = exps;
    }
    @Override
    public void accept() {

    }
}

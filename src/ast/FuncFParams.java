package ast;

import java.util.List;

// TODO
//  FuncFParams -> FuncFParam { ',' FuncFParam }
public class FuncFParams extends Node{
    private List<FuncFParam> funcFParamList = null;
    public FuncFParams(List<FuncFParam> funcFParamList){
        this.funcFParamList = funcFParamList;
    }
    @Override
    public void accept() {

    }
}

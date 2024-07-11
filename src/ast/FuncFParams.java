package ast;

import ir.Argument;
import ir.instructions.Memory_Instructions.Alloca;
import ir.types.DataType;

import java.util.ArrayList;
import java.util.List;

// TODO
//  FuncFParams -> FuncFParam { ',' FuncFParam }
public class FuncFParams extends Node{
    private List<FuncFParam> funcFParamList = null;
    public FuncFParams(List<FuncFParam> funcFParamList){
        this.funcFParamList = funcFParamList;
        childNode.addAll(funcFParamList);
    }

    /**
     * 这个是为了让形参是 SSA 形式
     * 必须为形参分配空间,然后将指针指向形参,不然形参可能直接被更改
     */
    public void buildFParamsSSA() {
        ArrayList<Argument> args = curFunc.getArguments();
        for (int i = 0; i < funcFParamList.size(); i++) {
            FuncFParam funcFParam = funcFParamList.get(i);
            Argument argument = args.get(i);
            // 这里建立 alloca 和 store 指令,而且并不需要分类讨论,因为类型在之前已经探讨过了
            Alloca alloca = builder.buildALLOCA(argument.getValueType(), curBlock);
            builder.buildStore(curBlock, argument, alloca);
            irSymbolTable.addValue(funcFParam.getIdent().getContent(), alloca);
        }
    }

    @Override
    public void buildIrTree() {
        ArrayList<DataType> types = new ArrayList<>();
        for (Node node : childNode) {
            node.buildIrTree();
            types.add(argTypeUp);
        }
        argTypeArrayUp = types;
    }

    @Override
    public void accept() {

    }
}

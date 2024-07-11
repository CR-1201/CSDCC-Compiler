package ast;

import ir.Value;
import ir.constants.ConstArray;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;

import java.util.ArrayList;
import java.util.List;

// TODO
//  ConstInitVal -> ConstExp | '{' [ ConstInitVal { ',' ConstInitVal } ] '}'
public class ConstInitVal extends Node{
    private ConstExp constExp = null;
    private List<ConstInitVal> constInitVals = null;

    Constant constant = ConstInt.ZERO;

    private final ArrayList<Integer> dims = new ArrayList<>();

    public ConstInitVal(ConstExp constExp) {
        this.constExp = constExp;
        childNode.add(constExp);
    }
    public ConstInitVal(List<ConstInitVal> constInitVals) {
        this.constInitVals = constInitVals;
        childNode.addAll(constInitVals);
    }

    public void setDims(ArrayList<Integer> dims){
        this.dims.addAll(dims);
    }

    public void setConstant(Constant constant){
        this.constant = constant;
    }

    @Override
    public void buildIrTree() {
        // 单变量
        if(constExp != null){
            constExp.buildIrTree();
        } else { // 数组
            // 全局常量数组
            if( irSymbolTable.isGlobalLayer() ){
                ArrayList<Constant> array = new ArrayList<>();
                if( dims.size()  == 1 ){
                    // 一维数组
                    for (ConstInitVal constInitVal : constInitVals){
                        constInitVal.buildIrTree();
                        if(valueUp instanceof ConstInt){
                            array.add((ConstInt)valueUp);
                        } else if(valueUp instanceof ConstFloat){
                            array.add((ConstFloat)valueUp);
                        }
                    }
                    // 不全 补0即可
                    for(int i = constInitVals.size() ; i < dims.get(0) ; i++ ){
                        array.add(constant);
                    }
                } else {
                    // 多维数组
                    int temp = constInitVals.size();
                    for(int i =  temp; i < dims.get(0) ; i++ ){
                        constInitVals.add(new ConstInitVal(new ArrayList<>()));
                    }
                    for (ConstInitVal constInitVal : constInitVals){
                        // 去掉一维,递归赋值
                        constInitVal.setDims(new ArrayList<>(dims.subList(1, dims.size())));
                        constInitVal.buildIrTree();
                        array.add((ConstArray) valueUp);
                    }

                }

                valueUp = new ConstArray(array);
            } else {
                // 局部常量数组,和变量数组的初始化类似,因为局部常量数组本质上也是个局部变量数组,所以方法都一样
                // 之所以采用 flatten 的形式,是因为在 gep 的时候, flatten 的逻辑更容易处理
                // 但是考虑到局部常量数组需要存初始值常量, 所以同时也以 valueUp 的形式返回
                // FIXME 常量数组存取浪费时间 可以优化？
                ArrayList<Value> flattenArray = new ArrayList<>();
                ArrayList<Constant> array = new ArrayList<>();

                // 一维数组
                if( dims.size()  == 1 ){
                    for (ConstInitVal constInitVal : constInitVals){
                        constInitVal.buildIrTree();
                        flattenArray.add(valueUp);
                        if(valueUp instanceof ConstInt){
                            array.add((ConstInt)valueUp);
                        } else if(valueUp instanceof ConstFloat){
                            array.add((ConstFloat)valueUp);
                        }

                        // 不全 补0即可
                        for(int i = constInitVals.size() ; i < dims.get(0) ; i++ ){
                            array.add(constant);
                        }
                    }
                } else {
                    int temp = constInitVals.size();
                    for(int i =  temp; i < dims.get(0) ; i++ ){
                        constInitVals.add(new ConstInitVal(new ArrayList<>()));
                    }

                    for (ConstInitVal constInitVal : constInitVals){
                        constInitVal.setDims(new ArrayList<>(dims.subList(1, dims.size())));
                        constInitVal.buildIrTree();
                        flattenArray.addAll(valueArrayUp);
                        array.add((ConstArray)valueUp);
                    }

                    // 返回
                    valueArrayUp = flattenArray;
                    valueUp = new ConstArray(array);
                }
            }
        }

    }

    @Override
    public void accept() {

    }
}

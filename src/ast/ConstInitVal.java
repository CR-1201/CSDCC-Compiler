package ast;

import ir.Value;
import ir.constants.ConstArray;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import token.Token;

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

    public ConstExp getConstExp(){
        return constExp;
    }

    @Override
    public void buildIrTree() {
        // 单变量
        if(constExp != null){
            constExp.buildIrTree();
        } else { // 数组
            int sum_dims = 1;
            for (int dim : dims) {
                sum_dims *= dim;
            }
            ArrayList<Value> flattenArray = new ArrayList<>();
            // 全局常量数组
            if( irSymbolTable.isGlobalLayer() ){

                if( dims.size()  == 1 ){
                    // 一维数组
                    for (ConstInitVal constInitVal : constInitVals){
                        constInitVal.buildIrTree();
                        flattenArray.add(valueUp);
                    }
                    // 不全 补0即可
                    for(int i = constInitVals.size() ; i < dims.get(0) ; i++ ){
                        flattenArray.add(constant);
                    }
                } else {
                    // 多维数组
                    for (ConstInitVal constInitVal : constInitVals){
                        // 去掉一维,递归赋值
                        if( constInitVal.getConstExp() == null ) {
                            constInitVal.setDims(new ArrayList<>(dims.subList(1, dims.size())));
                        }
                        constInitVal.buildIrTree();
                        if( constInitVal.getConstExp() != null ){
                            flattenArray.add(valueUp);
                        } else {
                            flattenArray.addAll(valueArrayUp);
                        }

                    }
                }

            } else {
                // 局部常量数组,和变量数组的初始化类似,因为局部常量数组本质上也是个局部变量数组,所以方法都一样
                // 之所以采用 flatten 的形式,是因为在 gep 的时候, flatten 的逻辑更容易处理
                // 但是考虑到局部常量数组需要存初始值常量, 所以同时也以 valueUp 的形式返回
                // FIXME 常量数组存取浪费时间 可以优化？
                // 一维数组
                if( dims.size()  == 1 ){
                    for (ConstInitVal constInitVal : constInitVals){
                        constInitVal.buildIrTree();
                        flattenArray.add(valueUp);
                    }
                    // 不全 补0即可
                    for(int i = constInitVals.size() ; i < dims.get(0) ; i++ ){
                        flattenArray.add(constant);
                    }
                } else { // 多维数组
                    for (ConstInitVal constInitVal : constInitVals){
                        if( constInitVal.getConstExp() == null ) {
                            constInitVal.setDims(new ArrayList<>(dims.subList(1, dims.size())));
                        }
                        constInitVal.buildIrTree();

                        if( constInitVal.getConstExp() != null ){
                            flattenArray.add(valueUp);
                        } else {
                            flattenArray.addAll(valueArrayUp);
                        }
                    }
                }

            }
            // 返回
            int x = flattenArray.size();
            for( int i = x ; i < sum_dims; i++ ){
                flattenArray.add(constant);
            }
            valueArrayUp = flattenArray;

            valueUp = getArrayTree(flattenArray,0);
        }

    }

    private ConstArray getArrayTree(ArrayList<Value> flattenArray, int dim_level){
        ArrayList<Constant> temp = new ArrayList<>();
        if( dim_level >= dims.size()-1 ){
            for( int i = 0 ; i < dims.get(dim_level) ; i++ ){
                if( flattenArray.get(i) instanceof ConstInt ){
                    temp.add((ConstInt)flattenArray.get(i));
                } else temp.add((ConstFloat)flattenArray.get(i));
            }
        } else {
            int row_num = dims.get(dim_level);
            int column_num = 1;
            for( int i = dim_level+1 ; i < dims.size() ; i++ ){
                column_num *= dims.get(i);
            }
            for( int i = 0 ; i < row_num ; i++ ){
                ArrayList<Value> temp_flattenArray = new ArrayList<>();
                for( int j = 0 ; j < column_num ; j++ ){
                    Value temp_value = flattenArray.get(i*column_num+j);
                    temp_flattenArray.add(temp_value);
                }
                temp.add(getArrayTree(temp_flattenArray,dim_level+1));
            }
        }
        return new ConstArray(temp);
    }

    @Override
    public void accept() {

    }
}

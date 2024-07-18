package ast;

import ir.Value;
import ir.constants.ConstArray;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.types.FloatType;
import ir.types.IntType;
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

    private Value getTemp() {
        Value temp = valueUp;
        // 用整数初始化浮点数
        if( constant instanceof ConstFloat && valueUp instanceof ConstInt) {
            temp = new ConstFloat((float)((ConstInt)valueUp).getValue());
        } else if (constant instanceof ConstInt && valueUp instanceof ConstFloat) {
            // 虽然说明了不会出现这种情况
            temp = new ConstInt((int)((ConstFloat)valueUp).getValue());
        }
        return temp;
    }

    @Override
    public void buildIrTree() {
        // 单变量
        if(constExp != null){
            constExp.buildIrTree();
            valueUp = getTemp();
        } else { // 数组
            int sum_dims = 1;
            for (int dim : dims) {
                sum_dims *= dim;
            }
            int curNum = 0;
            ArrayList<Value> flattenArray = new ArrayList<>();

            for( ConstInitVal constInitVal : constInitVals ){
                constInitVal.setConstant(constant);
                if( constInitVal.getConstExp() != null ){
                    curNum++;
                    constInitVal.buildIrTree();
                    Value temp = getTemp();
                    flattenArray.add(temp);
                } else {
                    ArrayList<Integer> newDims = getIntegers(curNum);
                    constInitVal.setDims(newDims);
                    constInitVal.buildIrTree();
                    flattenArray.addAll(valueArrayUp);
                    curNum += valueArrayUp.size();
                }
            }
            //  填充元素
            for(int i = curNum; i < sum_dims; i++ ){
                flattenArray.add(constant);
            }

            valueArrayUp = flattenArray; // 返回

//            System.out.println(flattenArray);
            valueUp = getArrayTree(flattenArray,0);
        }

    }

    private ArrayList<Integer> getIntegers(int curNum) {
        ArrayList<Integer> newDims = new ArrayList<>();
        int start = 0;
        if(curNum == 0){
            start = 1;
        } else {
            int tmpMul = 1;
            for(int i = dims.size() - 1; i >= 0; i--){
                tmpMul *= dims.get(i);
                if(curNum % tmpMul != 0){
                    start = i + 1;
                    break;
                }
            }
        }
        for(int i = start; i < dims.size(); i++){
            newDims.add(dims.get(i));
        }
        return newDims;
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

package ast;

import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.ConstStr;
import ir.constants.Constant;
import ir.types.FloatType;
import ir.types.IntType;
import ir.types.VoidType;

import java.util.ArrayList;
import java.util.List;

// TODO
//  InitVal -> Exp | '{' [ InitVal { ',' InitVal } ] '}'
public class InitVal extends Node{
    private Exp exp = null;
    private List<InitVal> initVals = null;

    private final ArrayList<Integer> dims = new ArrayList<>();

    Constant constant = ConstInt.ZERO;

    public InitVal(Exp exp) {
        this.exp = exp;
        childNode.add(exp);
    }
    public InitVal(List<InitVal> initVals) {
        this.initVals = initVals;
        childNode.addAll(initVals);
    }

    public void setDims(ArrayList<Integer> dims) {
        this.dims.addAll(dims);
    }

    public void setConstant(Constant constant){
        this.constant = constant;
    }

    public Exp getExp() {
        return exp;
    }

    public List<InitVal> getInitVals() {
        return initVals;
    }

    /*
     * 对于单变量初始值,通过 valueUp 返回
     * 对于数组初始值,通过 valueArrayUp 返回
     * 之所以无法像 ConstInit 都用 valueUp 返回,是因为对于变量初始值,没有一个 ConstArray 这样的结构打包
     */
    @Override
    public void buildIrTree() {

//        if( !globalInitDown )this.constant = new ConstStr("skip");

        // 初始值是一个表达式(单变量)
        if(exp != null) {
            // 在进行全局单变量初始化
            if( globalInitDown ){
                canCalValueDown = true;
                exp.buildIrTree();
                canCalValueDown = false;

            } else {
                // 在进行局部变量初始化,没法确定初始值是否可以直接求值,所以用一个 value 代替
                paramNotNeedLoadDown = false;
                exp.buildIrTree();
//                System.out.println(valueUp.getValueType() instanceof FloatType);
            }
            valueUp = getTemp();
        } else {
            // 在进行数组初始化
            ArrayList<Value> flattenArray = new ArrayList<>();
            int curNum = 0;
            int sum_dims = 1;
            for (int dim : dims) {
                sum_dims *= dim;
            }

            for( InitVal initVal : initVals ){
                initVal.setConstant(constant);
                if( initVal.getExp() != null ){
                    curNum++;
                    if (globalInitDown) {
                        canCalValueDown = true;
                        initVal.buildIrTree();
                        canCalValueDown = false;
                    } else {
                        initVal.buildIrTree();
                    }
                    Value temp = getTemp();
                    flattenArray.add(temp);
                } else {
                    ArrayList<Integer> newDims = getIntegers(curNum);
                    initVal.setDims(newDims);
                    initVal.buildIrTree();
                    flattenArray.addAll(valueArrayUp);
                    curNum += valueArrayUp.size();
                }
            }

            //  填充元素
            for(int i = curNum; i < sum_dims; i++ ){
                flattenArray.add(constant);
            }

//            System.out.println(flattenArray);
            valueArrayUp = flattenArray; // 返回
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
    public void accept() {

    }
}

package ast;

import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;

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
            }
        } else {
            // 在进行数组初始化
            ArrayList<Value> flattenArray = new ArrayList<>();

            int sum_dims = 1;
            for (int dim : dims) {
                sum_dims *= dim;
            }

            if (dims.size() == 1) {  // 一维数组
                for (InitVal initVal : initVals) {
                    // 全局变量数组初始化,这里的值一定是可以被计算出来的
                    if (globalInitDown) {
                        canCalValueDown = true;
                        initVal.buildIrTree();
                        canCalValueDown = false;
                        flattenArray.add(valueUp);
                    } else {
                        initVal.buildIrTree();
                        flattenArray.add(valueUp);
                    }
                }
                // 不全 补0即可
                for(int i = initVals.size() ; i < dims.get(0) ; i++ ){
                    flattenArray.add(constant);
                }

            } else { // 多维数组
                // 此时在遍历每个一维数组
                for (InitVal initVal : initVals) {
//                    initVal.setDims(new ArrayList<>(dims.subList(1, dims.size())));
                    if( initVal.getExp() == null ){
                        // 如果当前初值包含括号,先减少一维
                        initVal.setDims(new ArrayList<>(dims.subList(1, dims.size())));
                    }
                    initVal.buildIrTree();
                    if( initVal.getExp() != null ){
                        flattenArray.add(valueUp);
                    } else {
                        flattenArray.addAll(valueArrayUp);
                    }
                }
            }

            int x = flattenArray.size();
            for( int i = x ; i < sum_dims; i++ ){
                flattenArray.add(constant);
            }

            valueArrayUp = flattenArray; // 返回

        }

    }


    @Override
    public void accept() {

    }
}

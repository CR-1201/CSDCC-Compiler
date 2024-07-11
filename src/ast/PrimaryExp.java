package ast;

import ir.types.FloatType;
import ir.types.IntType;

// TODO
//  PrimaryExp -> '(' Exp ')' | LVal | Number
public class PrimaryExp extends Node{
    private Exp exp = null;
    private LVal lVal = null;
    private Number number = null;

    public PrimaryExp(Exp exp) {
        this.exp = exp;
        childNode.add(exp);
    }

    public PrimaryExp(LVal lVal) {
        this.lVal = lVal;
        childNode.add(lVal);
    }

    public PrimaryExp(Number number) {
        this.number = number;
        childNode.add(number);
    }

    /*
     * 如果是不可计算的,那么大概率有两种情况
     * (Exp),那么就直接继续递归即可
     * lVal,那么需要在这里完成加载(将指针指向的内容搞出来)
     */
    @Override
    public void buildIrTree() {
        if( canCalValueDown ){
            // 如果是可以计算的,那么忽视这一层即可
            for (Node fatherNode : childNode) {
                fatherNode.buildIrTree();
            }
            // 如果左值是一个 int 或 float 常量,那么就不用加载了
            // 现在这种情况,说明是个指针,指针一般说明是局部变量,那么此时需要加载了
            if (!(valueUp.getValueType() instanceof IntType || valueUp.getValueType() instanceof FloatType)) {
                valueUp = builder.buildLoad(curBlock, valueUp);
            }
        } else {
            if( exp != null ){ // 表达式
                exp.buildIrTree();
            } else if ( lVal != null ){ // 左值
                // 这个变量控制不要加载
                if( paramNotNeedLoadDown ){
                    paramNotNeedLoadDown = false;
                    lVal.buildIrTree();
                } else {
                    lVal.buildIrTree();
                    // 如果左值是一个 int 或者 float 常量,那么就不用加载了
                    // 现在这种情况,说明是个指针,指针一般说明是局部变量，那么此时需要加载了
                    if (!(valueUp.getValueType() instanceof IntType || valueUp.getValueType() instanceof FloatType)) {
                        valueUp = builder.buildLoad(curBlock, valueUp);
                    }
                }
            } else if( number != null ){ // 数字
                number.buildIrTree();
            }
        }
    }

    @Override
    public void accept() {

    }
}

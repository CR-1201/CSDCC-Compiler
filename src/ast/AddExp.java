package ast;

import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.types.DataType;
import ir.types.FloatType;
import ir.types.IntType;
import token.Token;

// TODO
//  AddExp -> MulExp | AddExp ('+' | '−') MulExp
public class AddExp extends Node{
    private MulExp mulExp = null;
    private AddExp addExp = null;
    private Token op = null;
    public AddExp(MulExp mulExp, AddExp addExp, Token op) {
        this.mulExp = mulExp;
        this.addExp = addExp;
        this.op = op;
        childNode.add(addExp);
        childNode.add(mulExp);
    }
    public AddExp(MulExp mulExp) {
        this.mulExp = mulExp;
        childNode.add(mulExp);
    }

    public MulExp getMulExp() {
        return mulExp;
    }

    public AddExp getAddExp() {
        return addExp;
    }

    /*
     * 分为两种:
     * 第一种是可以直接计算类型的,那么就需要在这里进行加减法计算
     * 第二种不可以直接计算,那么就需要在这里添加 add, sub 的指令
     * 对于 1 + (1 == 0) 的式子,虽然应该不会出现,但是我依然写了,对于 (1 == 0),需要用 zext 拓展后参与运算
     */
    @Override
    public void buildIrTree(){
        // 如果是可计算的，那么就要算出来
        if ( canCalValueDown ) {
            mulExp.buildIrTree();
            Value mul = valueUp;
            int i_sum = 0;float f_sum = 0;
            int i_mul;float f_mul;
            int i_add;float f_add;
            boolean float_flag = false;
            if( addExp != null ){
                addExp.buildIrTree();
                Value add = valueUp;
                if( mul.getValueType().isFloat() || add.getValueType().isFloat() ){
                    float_flag = true;
                }
                if(!mul.getValueType().isFloat()){
                    f_mul = ((ConstInt)mul).getValue();
                    i_mul = ((ConstInt)mul).getValue();
                } else {
                    f_mul = ((ConstFloat)mul).getValue();
                    i_mul = (int)(((ConstFloat)mul).getValue());
                }
                if(!add.getValueType().isFloat()){
                    f_add = ((ConstInt)add).getValue();
                    i_add = ((ConstInt)add).getValue();
                } else {
                    f_add = ((ConstFloat)add).getValue();
                    i_add = (int)(((ConstFloat)add).getValue());
                }

                if( op.getType() == Token.TokenType.PLUS ){
                    f_sum = f_add + f_mul;
                    i_sum = i_add + i_mul;
                } else if( op.getType() == Token.TokenType.MINU ){
                    f_sum = f_add - f_mul;
                    i_sum = i_add - i_mul;
                }

                if( float_flag ){
                    valueUp = new ConstFloat(f_sum);
                } else valueUp = new ConstInt(i_sum);
            }

        } else {
            // 是不可直接计算的,要用表达式
            DataType dataType = new IntType(32);
            mulExp.buildIrTree();
            Value sum = valueUp;
            if ( sum.getValueType().isI1()) {
                // 如果类型是 boolean,需要先换类型
                sum = builder.buildZext(curBlock, sum);
            }

            if( addExp != null ){
                addExp.buildIrTree();
                Value adder = valueUp;
                // 如果是 boolean 无脑转int 32; 如果adder和sum当中有且仅有一个float, 那么另外一个就需要进行类型转化
                if (adder.getValueType().isI1()) {
                    adder = builder.buildZext(curBlock, adder);
                } else if( adder.getValueType().isFloat() && !sum.getValueType().isFloat() ){
                    sum = builder.buildConversion(curBlock,"sitofp",new FloatType(), sum);
                    dataType = new FloatType();
                }

                if( !adder.getValueType().isFloat() && sum.getValueType().isFloat() ){
                    adder = builder.buildConversion(curBlock,"sitofp",new FloatType(), adder);
                    dataType = new FloatType();
                }

                if( adder.getValueType().isFloat() && sum.getValueType().isFloat() ){
                    dataType = new FloatType();
                }

                if ( op.getType() == Token.TokenType.PLUS ){
                    sum = builder.buildAdd(curBlock, dataType, adder, sum);
                } else if( op.getType() == Token.TokenType.MINU ){
                    sum = builder.buildSub(curBlock, dataType, adder, sum);
                }
            }

            valueUp = sum;
        }
    }

    @Override
    public void accept() {

    }
}

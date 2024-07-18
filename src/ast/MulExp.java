package ast;

import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.binaryInstructions.Sdiv;
import ir.types.DataType;
import ir.types.FloatType;
import ir.types.IntType;
import token.Token;

// TODO
//  MulExp -> UnaryExp | MulExp ('*' | '/' | '%') UnaryExp
public class MulExp extends Node{
    private UnaryExp unaryExp = null;
    private MulExp mulExp = null;
    private Token op = null;
    public MulExp(UnaryExp unaryExp) {
        this.unaryExp = unaryExp;
        childNode.add(unaryExp);
    }
    public MulExp(MulExp mulExp, UnaryExp unaryExp, Token op) {
        this.mulExp = mulExp;
        this.unaryExp = unaryExp;
        this.op = op;
        childNode.add(mulExp);
        childNode.add(unaryExp);
    }

    @Override
    public void buildIrTree() {
        // 可以计算就算出结果
        if( canCalValueDown ){
            unaryExp.buildIrTree();
            Value unary = valueUp;
            int i_sum = 0;float f_sum = 0;
            int i_mul;float f_mul;
            int i_unary;float f_unary;
            boolean float_flag = false;
            if( mulExp != null ){
                mulExp.buildIrTree();
                Value mul = valueUp;

                if( mul.getValueType().isFloat() || unary.getValueType().isFloat() ){
                    float_flag = true;
                }

                if(!unary.getValueType().isFloat()){
                    f_unary = ((ConstInt)unary).getValue();
                    i_unary = ((ConstInt)unary).getValue();
                } else {
                    f_unary = ((ConstFloat)unary).getValue();
                    i_unary = (int)(((ConstFloat)unary).getValue());
                }

                if(!mul.getValueType().isFloat()){
                    f_mul = ((ConstInt)mul).getValue();
                    i_mul = ((ConstInt)mul).getValue();
                } else {
                    f_mul = ((ConstFloat)mul).getValue();
                    i_mul = (int)(((ConstFloat)mul).getValue());
                }

                if( op.getType() == Token.TokenType.MULT ){
                    f_sum = f_mul * f_unary;
                    i_sum = i_mul * i_unary;
                } else if(op.getType() == Token.TokenType.DIV ){
                    f_sum = f_mul / f_unary;
                    i_sum = i_mul / i_unary;
                } else if(op.getType() == Token.TokenType.MOD ){
                    f_sum = f_mul % f_unary;
                    i_sum = i_mul % i_unary;
                }

                if( float_flag ){
                    valueUp = new ConstFloat(f_sum);
                } else valueUp = new ConstInt(i_sum);
            }


        } else { // 是不可直接计算的,要用表达式
            DataType dataType = new IntType(32);
            Value mul; Value multer = null;

            if( mulExp != null ){
                mulExp.buildIrTree();
                multer = valueUp;
            }


            unaryExp.buildIrTree();
            mul = valueUp;
            if ( mul.getValueType().isI1()) {
                // 如果类型是 boolean,需要先换类型
                mul = builder.buildZext(curBlock, mul);
            }

            if( multer != null ){
                // 如果是 boolean 无脑转int 32; 如果mul和multer当中有且仅有一个float, 那么另外一个就需要进行类型转化
                if (multer.getValueType().isI1()){
                    multer = builder.buildZext(curBlock, multer);
                }

                if( multer.getValueType().isFloat() && !mul.getValueType().isFloat() ){
                    mul = builder.buildConversion(curBlock,"sitofp",new FloatType(), mul);
                    dataType = new FloatType();
                }

                if( !multer.getValueType().isFloat() && mul.getValueType().isFloat() ){
                    multer = builder.buildConversion(curBlock,"sitofp",new FloatType(), multer);
                    dataType = new FloatType();
                }

                if( multer.getValueType().isFloat() && mul.getValueType().isFloat() ){
                    dataType = new FloatType();
                }

                if ( op.getType() == Token.TokenType.MULT ){
                    mul = builder.buildMul(curBlock, dataType, multer, mul);
                } else if( op.getType() == Token.TokenType.DIV ){
                    mul = builder.buildSdiv(curBlock, dataType, multer, mul);
                } else if( op.getType() == Token.TokenType.MOD ){
                    // x % y = x - ( x / y ) * y,这是因为取模优化不太好做
//                    if( mul instanceof ConstInt ){
//                        int num = ((ConstInt) mul).getValue();
//                        if (Math.abs(num) == 1){
//                            // 如果绝对值是 1,那么就翻译成 MOD,这就交给后端优化了
//                            mul = builder.buildSrem(curBlock, dataType, multer, mul);
//                        } else if ((Math.abs(num) & (Math.abs(num) - 1)) == 0){
//                            // 如果是 2 的幂次
//                            mul = builder.buildSrem(curBlock, dataType, multer, mul);
//                        } else {
//                            Sdiv a = builder.buildSdiv(curBlock, dataType, multer, mul);
//                            Mul b = builder.buildMul(curBlock, dataType, a, mul);
//                            mul = builder.buildSub(curBlock,dataType, multer, b);
//                        }
//                    } else {
//                        Sdiv a = builder.buildSdiv(curBlock, dataType, multer, mul);
//                        Mul b = builder.buildMul(curBlock, dataType, a, mul);
//                        mul = builder.buildSub(curBlock,dataType, multer, b);
//                    }
                    mul = builder.buildSrem(curBlock, dataType, multer, mul);
                }
            }

            valueUp = mul;
        }
    }

    @Override
    public void accept() {

    }
}

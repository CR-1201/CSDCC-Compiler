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
            float f_mul = 0;
            int i_mul = 0;
            boolean float_flag = false;
            if( valueUp instanceof ConstInt){
                i_mul = ((ConstInt)valueUp).getValue();
            } else {
                f_mul = ((ConstFloat)valueUp).getValue();
                float_flag = true;
            }
            if( mulExp != null ){
                mulExp.buildIrTree();
                if( op.getType() == Token.TokenType.MULT ){
                    if( valueUp instanceof  ConstInt ){
                        if( !float_flag ){
                            i_mul *= ((ConstInt)valueUp).getValue();
                        } else {
                            f_mul *= ((ConstInt)valueUp).getValue();
                        }
                    } else if( valueUp instanceof ConstFloat ){
                        if( !float_flag ){
                            f_mul = ((ConstFloat)valueUp).getValue() * i_mul;
                            float_flag = true;
                        } else {
                            f_mul *= ((ConstFloat)valueUp).getValue();
                        }
                    }
                } else if(op.getType() == Token.TokenType.DIV ){
                    if( valueUp instanceof  ConstInt ){
                        if( !float_flag ){
                            i_mul /= ((ConstInt)valueUp).getValue();
                        } else {
                            f_mul /= ((ConstInt)valueUp).getValue();
                        }
                    } else if( valueUp instanceof ConstFloat ){
                        if( !float_flag ){
                            f_mul = i_mul / ((ConstFloat)valueUp).getValue();
                            float_flag = true;
                        } else {
                            f_mul /= ((ConstFloat)valueUp).getValue();
                        }
                    }
                } else if(op.getType() == Token.TokenType.MOD ){
                    if( valueUp instanceof  ConstInt ){
                        if( !float_flag ){
                            i_mul %= ((ConstInt)valueUp).getValue();
                        } else {
                            f_mul %= ((ConstInt)valueUp).getValue();
                        }
                    } else if( valueUp instanceof ConstFloat ){
                        if( !float_flag ){
                            f_mul = i_mul % ((ConstFloat)valueUp).getValue();
                            float_flag = true;
                        } else {
                            f_mul %= ((ConstFloat)valueUp).getValue();
                        }
                    }
                }
            }
            if( float_flag ){
                valueUp = new ConstFloat(f_mul);
            } else valueUp = new ConstInt(i_mul);
        } else { // 是不可直接计算的,要用表达式
            DataType dataType = new IntType(32);
            unaryExp.buildIrTree();
            Value mul = valueUp;
            if ( mul.getValueType().isI1()) {
                // 如果类型是 boolean,需要先换类型
                mul = builder.buildZext(curBlock, mul);
            }

            if( mulExp != null ){
                mulExp.buildIrTree();
                Value multer = valueUp;
                // 如果是 boolean 无脑转int 32; 如果mul和multer当中有且仅有一个float, 那么另外一个就需要进行类型转化
                if (multer.getValueType().isI1()){
                    multer = builder.buildZext(curBlock, multer);
                } else if( multer.getValueType().isFloat() && !mul.getValueType().isFloat() ){
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
                    mul = builder.buildMul(curBlock, dataType, mul, multer);
                } else if( op.getType() == Token.TokenType.DIV ){
                    mul = builder.buildSdiv(curBlock, dataType, mul, multer);
                } else if( op.getType() == Token.TokenType.MOD ){
                    // x % y = x - ( x / y ) * y,这是因为取模优化不太好做
                    if( multer instanceof ConstInt ){
                        int num = ((ConstInt) multer).getValue();
                        if (Math.abs(num) == 1){
                            // 如果绝对值是 1,那么就翻译成 MOD,这就交给后端优化了
                            mul = builder.buildSrem(curBlock, dataType, mul, multer);
                        } else if ((Math.abs(num) & (Math.abs(num) - 1)) == 0){
                            // 如果是 2 的幂次
                            mul = builder.buildSrem(curBlock, dataType, mul, multer);
                        } else {
                            Sdiv a = builder.buildSdiv(curBlock, dataType, mul, multer);
                            Mul b = builder.buildMul(curBlock, dataType, a, multer);
                            mul = builder.buildSub(curBlock,dataType, mul, b);
                        }
                    }
                }

                valueUp = mul;
            }
        }
    }

    @Override
    public void accept() {

    }
}

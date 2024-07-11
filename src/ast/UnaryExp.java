package ast;


import ir.Function;
import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Binary_Instructions.Icmp;
import ir.types.DataType;
import ir.types.FloatType;
import ir.types.IntType;
import token.Token;

import java.util.ArrayList;
import java.util.List;

// TODO
//  UnaryExp -> PrimaryExp | Ident '(' [FuncRParams] ')' | UnaryOp UnaryExp
public class UnaryExp extends Node{
    private PrimaryExp primaryExp = null;
    private Token identToken = null;
    private FuncRParams funcRParams = null;
    private UnaryOp unaryOp = null;
    private UnaryExp unaryExp = null;

    public UnaryExp(PrimaryExp primaryExp) {
        this.primaryExp = primaryExp;
        childNode.add(primaryExp);
    }

    public UnaryExp(Token identToken, FuncRParams funcRParams) {
        this.identToken = identToken;
        this.funcRParams = funcRParams;
        childNode.add(funcRParams);
    }

    public UnaryExp(UnaryOp unaryOp, UnaryExp unaryExp) {
        this.unaryOp = unaryOp;
        this.unaryExp = unaryExp;
        childNode.add(unaryOp);
        childNode.add(unaryExp);
    }

    @Override
    public void buildIrTree() {
        // 可计算的情况只有 unaryExp 和 PrimaryExp 两种
        if( canCalValueDown ){
            if( unaryExp != null ){
                // 处理符号即可
                unaryExp.buildIrTree();
                if(unaryOp.getToken().getType() == Token.TokenType.MINU){
                    if( valueUp instanceof ConstInt ){
                        valueUp = new ConstInt(-((ConstInt) valueUp).getValue());
                    } else {
                        valueUp = new ConstFloat(-((ConstFloat) valueUp).getValue());
                    }
                } else if (unaryOp.getToken().getType() == Token.TokenType.NOT){
                    // FIXME: Float 的 NOT 该怎么处理
                    int num = ((ConstInt) valueUp).getValue();
                    num = (num == 0) ? 1 : 0;
                    valueUp = new ConstInt(num);
                }
            } else {
                // primaryExp
                primaryExp.buildIrTree();
            }
        } else { // 不可计算的情况
            if( unaryExp != null ){
                // UnaryOp UnaryExp
                DataType dataType = new IntType(32);
                unaryExp.buildIrTree();
                Value unaryValue = valueUp;

                if( unaryValue.getValueType().isFloat() ){
                    dataType = new FloatType();
                }
                if( unaryValue.getValueType().isI1() ){
                    unaryValue = builder.buildZext(curBlock,unaryValue);
                }
                if ( unaryOp.getToken().getType() == Token.TokenType.NOT ) {
                    valueUp = builder.buildIcmp(curBlock, Icmp.Condition.EQ, unaryValue, ConstInt.ZERO);
                } else if ( unaryOp.getToken().getType() == Token.TokenType.MINU ) {
                    if( dataType instanceof IntType ){
                        valueUp = builder.buildSub(curBlock, dataType, ConstInt.ZERO, unaryValue);
                    } else {
                        valueUp = builder.buildSub(curBlock, dataType, ConstFloat.ZERO, unaryValue);
                    }
                }
            } else if( primaryExp != null ){
                // primary
                primaryExp.buildIrTree();
            } else { // callee
                Function function = findLibFunc(identToken.getContent());
                if( function != null){
                    // 实参表
                    ArrayList<Value> argList = new ArrayList<>();
                    // 如果有实参
                    if (funcRParams != null) {
                        List<Exp> params = funcRParams.getExps();
                        ArrayList<DataType> formalArgs = function.getValueType().getFormalArgs();
                        for (int i = 0; i < params.size(); i++) {
                            Exp param = params.get(i);
                            DataType argType = formalArgs.get(i);

                            // 如果传参的是一个指针,那么就不需要加载
                            paramNotNeedLoadDown = !(argType instanceof IntType || argType instanceof FloatType);
                            param.buildIrTree();
                            paramNotNeedLoadDown = false;

                            argList.add(valueUp);
                        }
                    }
                    //内建函数
                    valueUp = builder.buildCall(curBlock, function, argList);
                } else {
                    // 非内建函数
                    Function func = (Function) irSymbolTable.searchValue(identToken.getContent());
                    // 实参表
                    ArrayList<Value> argList = new ArrayList<>();
                    // 如果有实参
                    if (funcRParams != null) {
                        List<Exp> params = funcRParams.getExps();
                        ArrayList<DataType> formalArgs = func.getValueType().getFormalArgs();
                        for (int i = 0; i < params.size(); i++) {
                            Exp param = params.get(i);
                            DataType argType = formalArgs.get(i);

                            // 如果传参的是一个指针,那么就不需要加载
                            paramNotNeedLoadDown = !(argType instanceof IntType || argType instanceof FloatType);
                            param.buildIrTree();
                            paramNotNeedLoadDown = false;

                            argList.add(valueUp);
                        }
                    }
                    valueUp = builder.buildCall(curBlock, func, argList);
                }
            }
        }
    }

    private Function findLibFunc(String ident){
        return switch (ident) {
            case "getint" -> Function.getint;
            case "putint" -> Function.putint;
            case "getch" -> Function.getch;
            case "putch" -> Function.putch;
            case "getarray" -> Function.getarray;
            case "putarray" -> Function.putarray;
            case "getfloat" -> Function.getfloat;
            case "putfloat" -> Function.putfloat;
            case "getfarray" -> Function.getfarray;
            case "putfarray" -> Function.putfarray;
            case "starttime" -> Function.starttime;
            case "stoptime" -> Function.stoptime;
            default -> null;
        };
    }

    @Override
    public void accept() {

    }
}

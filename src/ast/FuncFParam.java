package ast;

import ir.types.*;
import token.Token;

import java.util.List;

// TODO
//  FuncFParam -> BType Ident ['[' ']' { '[' Exp ']' }]
public class FuncFParam extends Node{
    private BType bType = null;
    private Token identToken = null;
    private List<ConstExp> constExps;
    private Token lbrack;
    private Token rbrack;
    public FuncFParam( BType bType, Token identToken, Token lbrack, Token rbrack, List<ConstExp> constExps) {
        this.identToken = identToken;
        this.lbrack = lbrack;
        this.rbrack = rbrack;
        this.bType = bType;
        this.constExps = constExps;
        childNode.add(bType);
        childNode.addAll(constExps);
    }

    public Token getIdent() {
        return identToken;
    }

    @Override
    public void buildIrTree() {
        DataType dataType ;
        if( bType.getToken().getType() == Token.TokenType.INTTK ){
            dataType = new IntType(32);
        } else {
            dataType = new FloatType();
        }
        // 单变量
        if (lbrack == null) {
            argTypeUp = dataType;
        } else { // 指针
            ValueType argType = dataType;
            // 先倒序遍历
            for (int i = constExps.size() - 1; i >= 0; i--) {
                canCalValueDown = true;
                constExps.get(i).buildIrTree();
                canCalValueDown = false;
                argType = new ArrayType(argType, valueIntUp);
            }
            // 最终做一个指针,和 C 语言逻辑一模一样
            argType = new PointerType(argType);
            argTypeUp = (PointerType) argType;
        }
    }

    @Override
    public void accept() {

    }
}

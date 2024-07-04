package frontend;

import ast.*;
import token.Token;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

public class ParserAnalyze {
    // 唯一实例
    private static final ParserAnalyze parser = new ParserAnalyze();
    // 当前正在处理的 token
    private Token currentToken;
    // 当前正在处理的 token 所处位置索引
    private int index = 0;
    // 词法分析后的 token 流
    private List<Token> tokens;
    // 输出语法分析后的结果
    PrintStream ps;
    private CompUnit compUnit;
    public static ParserAnalyze getParser() {
        return parser;
    }
    public void setTokens(List<Token> tokens) {
        this.tokens = tokens;
        this.currentToken = tokens.get(index);
    }

    public void analyze() {
        this.compUnit = CompUnit();
    }
    public CompUnit getCompUnit() {
        return compUnit;
    }
    {
        try {
            ps = new PrintStream("output.txt");
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private CompUnit CompUnit() {
        // CompUnit -> [ CompUnit ] ( Decl | FuncDef )
        CompUnit compUnit = null;
        Decl decl = null;
        FuncDef funcDef = null;
        MainFuncDef mainFuncDef = null;
        // 根据左括号来区分函数定义和变量定义
        if (index < tokens.size() - 2  && tokens.get(index + 2).getType() != Token.TokenType.LPARENT) {
            decl = Decl();
            compUnit = CompUnit();
            return new CompUnit(compUnit, decl);
        } else {
            // 根据 token main 来区分普通函数还是 main 函数
            if( index < tokens.size() - 1 && tokens.get(index + 1).getType() != Token.TokenType.MAINTK ){
                funcDef = FuncDef();
                compUnit = CompUnit();
                return new CompUnit(compUnit, funcDef);
            } else {
                // 确保 main 函数只能出现在末尾
                mainFuncDef = MainFuncDef();
                return new CompUnit(mainFuncDef);
            }
        }
    }
    private Decl Decl() {
        // Decl -> ConstDecl | VarDecl
        ConstDecl constDecl = null;
        VarDecl varDecl = null;
        if (currentToken.getType() == Token.TokenType.CONSTTK) {
            constDecl = ConstDecl();
            return new Decl(constDecl);
        } else {
            varDecl = VarDecl();
            return new Decl(varDecl);
        }
    }
    private ConstDecl ConstDecl() {
        // ConstDecl -> 'const' BType ConstDef { ',' ConstDef } ';'
        Token constToken = match(Token.TokenType.CONSTTK);
        BType bType= BType();
        List<ConstDef> constDef = new ArrayList<>();
        List<Token> commas = new ArrayList<>();
        Token semicnToken;
//        constDef.add(ConstDef());
//        while (currentToken.getType() == Token.tokenType.COMMA) {
//            commas.add(match(Token.tokenType.COMMA));
//            constDef.add(ConstDef());
//        }
//        semicnToken = match(Token.tokenType.SEMICN);
//        return new ConstDecl(constToken, bType, constDef, commas, semicnToken);
        return null;
    }
    private BType BType(){
        // BType → 'int' | 'float'
        return null;
    }
    private VarDecl VarDecl(){
        // VarDecl → BType VarDef { ',' VarDef } ';'
        return null;
    }
    private FuncDef FuncDef(){

        return null;
    }

    private  MainFuncDef MainFuncDef(){
        // MainFuncDef → 'int' 'main' '(' ')' Block

        return null;
    }

    private Token match(Token.TokenType type) {
        if (currentToken.getType() == type) {
            Token tmp = currentToken;
            if (index < tokens.size() - 1) {
                currentToken = tokens.get(++index);
            }
            return tmp;
        }  else {
            throw new RuntimeException("Syntax error at line " + currentToken.getLineNum() + ": " + currentToken.getContent() + " is not " + type);
        }
    }
}

package frontend;

import ast.*;
import ast.Number;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import token.Token;

public class ParserAnalyze {
    // 唯一实例
    private static final ParserAnalyze parser = new ParserAnalyze();
    // 当前正在处理的 token
    private Token currentToken;
    // 当前正在处理的 token 所处位置索引
    private int index = 0;
    // 词法分析后的 token 流
    private List<Token> tokens;
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

    private LVal LVal(){
        //  LVal → Ident {'[' Exp ']'}
        Token ident = match(Token.TokenType.IDENFR);
        List<Exp> exps = new ArrayList<>();
        while(currentToken.getType() == Token.TokenType.LBRACK){
            match(Token.TokenType.LBRACK);
            exps.add(Exp());
            match(Token.TokenType.RBRACK);
        }
        return new LVal(ident,exps);
    }

    private ConstDecl ConstDecl() {
        // ConstDecl -> 'const' BType ConstDef { ',' ConstDef } ';'
        match(Token.TokenType.CONSTTK);
        BType bType= BType();
        List<ConstDef> constDef = new ArrayList<>();
        constDef.add(ConstDef());
        while (currentToken.getType() == Token.TokenType.COMMA) {
            match(Token.TokenType.COMMA);
            constDef.add(ConstDef());
        }
        match(Token.TokenType.SEMICN);
        return new ConstDecl(bType, constDef);
    }

    private ConstDef ConstDef(){
        // ConstDef → Ident { '[' ConstExp ']' } '=' ConstInitVal
        Token identToken = match(Token.TokenType.IDENFR);
        List<ConstExp> constExp = new ArrayList<>();
        while (currentToken.getType() != Token.TokenType.ASSIGN) {
            match(Token.TokenType.LBRACK);
            constExp.add(ConstExp());
            match(Token.TokenType.RBRACK);
        }
        match(Token.TokenType.ASSIGN);
        ConstInitVal constInitVal = ConstInitVal();
        return new ConstDef(identToken,constExp,constInitVal);
    }

    private  ConstInitVal ConstInitVal(){
        // ConstInitVal → ConstExp | '{' [ ConstInitVal { ',' ConstInitVal } ] '}'
        if( currentToken.getType() == Token.TokenType.LBRACE ){
            List<ConstInitVal> constInitVals = new ArrayList<>();
            match(Token.TokenType.LBRACE);
            if(currentToken.getType() != Token.TokenType.RBRACE ) { // constInitVals不为空
                constInitVals.add(ConstInitVal());
                while(currentToken.getType() == Token.TokenType.COMMA) {
                    match(Token.TokenType.COMMA);
                    constInitVals.add(ConstInitVal());
                }
            }
            match(Token.TokenType.RBRACE);
            return new ConstInitVal(constInitVals);
        }else {
            ConstExp constExp = ConstExp();
            return new ConstInitVal(constExp);
        }
    }

    private ConstExp ConstExp(){
        // ConstExp → AddExp
        AddExp addExp = AddExp();
        return new ConstExp(addExp);
    }

    private AddExp AddExp(){
        // AddExp → MulExp | AddExp ('+' | '−') MulExp
        MulExp mulExp = MulExp();
        if( currentToken.getType() == Token.TokenType.PLUS || currentToken.getType() == Token.TokenType.MINU ){
            Token addExpTK = null;
            if( currentToken.getType() == Token.TokenType.PLUS ){
                addExpTK = match(Token.TokenType.PLUS);
            }else if( currentToken.getType() == Token.TokenType.MINU ){
                addExpTK = match(Token.TokenType.MINU);
            }
            AddExp addExp = AddExp();
            return new AddExp(mulExp,addExp,addExpTK);
        } else return new AddExp(mulExp);

    }

    private MulExp MulExp(){
        //  MulExp → UnaryExp | MulExp ('*' | '/' | '%') UnaryExp
        UnaryExp unaryExp = UnaryExp();
        if(currentToken.getType() == Token.TokenType.MULT || currentToken.getType() == Token.TokenType.DIV || currentToken.getType() == Token.TokenType.MOD){
            Token mulExpTK = null;
            if( currentToken.getType() == Token.TokenType.MULT ){
                mulExpTK = match(Token.TokenType.MULT);
            }else if( currentToken.getType() == Token.TokenType.DIV ){
                mulExpTK = match(Token.TokenType.DIV);
            }else if( currentToken.getType() == Token.TokenType.MOD ){
                mulExpTK = match(Token.TokenType.MOD);
            }
            MulExp mulExp = MulExp();
            return new MulExp(mulExp,unaryExp,mulExpTK);
        } else return new MulExp(unaryExp);
    }

    private UnaryExp UnaryExp(){
        // UnaryExp → PrimaryExp | Ident '(' [FuncRParams] ')' | UnaryOp UnaryExp
        FuncRParams funcRParams = null;
        if(currentToken.getType() == Token.TokenType.IDENFR && index < tokens.size() - 1 && tokens.get(index+1).getType() == Token.TokenType.LPARENT){
            Token identTK = match(Token.TokenType.IDENFR);
            match(Token.TokenType.LPARENT);
            if(currentToken.getType() != Token.TokenType.RPARENT && isExp()){
                funcRParams = FuncRParams();
            }
            match(Token.TokenType.RPARENT);
            return new UnaryExp(identTK,funcRParams);
        }
        else if( currentToken.getType() == Token.TokenType.PLUS || currentToken.getType() == Token.TokenType.MINU || currentToken.getType() == Token.TokenType.NOT){
            UnaryOp unaryOp = UnaryOp();
            UnaryExp unaryExp = UnaryExp();
            return new UnaryExp(unaryOp,unaryExp);
        }
        else{
            PrimaryExp primaryExp = PrimaryExp();
            return new UnaryExp(primaryExp);
        }
    }

    private boolean isExp() {
        return  currentToken.getType() == Token.TokenType.IDENFR ||
                currentToken.getType() == Token.TokenType.PLUS ||
                currentToken.getType() == Token.TokenType.MINU ||
                currentToken.getType() == Token.TokenType.NOT ||
                currentToken.getType() == Token.TokenType.STRCON ||
                currentToken.getType() == Token.TokenType.LPARENT ||
                currentToken.getType() == Token.TokenType.DECCON ||
                currentToken.getType() == Token.TokenType.OCTCON ||
                currentToken.getType() == Token.TokenType.HEXCON ||
                currentToken.getType() == Token.TokenType.DECFLTCON ||
                currentToken.getType() == Token.TokenType.HEXFLTCON;
    }

    private FuncRParams FuncRParams(){
        //  FuncRParams → Exp { ',' Exp }
        List<Exp> exps = new ArrayList<>();
        exps.add(Exp());
        while(currentToken.getType()==Token.TokenType.COMMA){
            match(Token.TokenType.COMMA);
            exps.add(Exp());
        }
        return new FuncRParams(exps);
    }

    private Exp Exp(){
        // Exp → AddExp | StrExp
        if( currentToken.getType() == Token.TokenType.STRCON ){
            StrExp strExp = StrExp();
            return new Exp(strExp);
        } else {
            AddExp addExp = AddExp();
            return new Exp(addExp);
        }
    }

    private StrExp StrExp(){
        // StrExp → StrConst
        Token tmp = currentToken;
        if (index < tokens.size() - 1) {
            currentToken = tokens.get(++index);
        }
        return new StrExp(currentToken);
    }

    private UnaryOp UnaryOp(){
        //  UnaryOp → '+' | '−' | '!'
        Token unaryOp = null;
        if( currentToken.getType() == Token.TokenType.PLUS ){
            unaryOp = match(Token.TokenType.PLUS);
        }else if( currentToken.getType() == Token.TokenType.MINU ){
            unaryOp = match(Token.TokenType.MINU);
        }else if( currentToken.getType() == Token.TokenType.NOT ){
            unaryOp = match(Token.TokenType.NOT);
        }
        return new UnaryOp(unaryOp);
    }

    private Cond Cond(){
        // Cond → LOrExp
        LOrExp lOrExp = LOrExp();
        return new Cond(lOrExp);
    }

    private LOrExp LOrExp(){
        // LOrExp → LAndExp | LOrExp '||' LAndExp
        LAndExp lAndExp = LAndExp();
        if( currentToken.getType() == Token.TokenType.OR ){
            Token lOrExpTK = match(Token.TokenType.OR);
            LOrExp lOrExp = LOrExp();
            return new LOrExp(lOrExp,lAndExp,lOrExpTK);
        } else return new LOrExp(lAndExp);
    }

    private LAndExp LAndExp(){
        // LAndExp → EqExp | LAndExp '&&' EqExp
        EqExp eqExp = EqExp();
        if( currentToken.getType() == Token.TokenType.AND ){
            Token lAndExpTK = match(Token.TokenType.AND);
            LAndExp lAndExp = LAndExp();
            return new LAndExp(lAndExp,eqExp,lAndExpTK);
        } else return new LAndExp(eqExp);
    }

    private EqExp EqExp(){
        // EqExp → RelExp | EqExp ('==' | '!=') RelExp
        RelExp relExp = RelExp();
        if( currentToken.getType() == Token.TokenType.EQL || currentToken.getType() == Token.TokenType.NEQ ){
            Token eqExpTK = null;
            if( currentToken.getType() == Token.TokenType.EQL ){
                eqExpTK = match(Token.TokenType.EQL);
            }else if( currentToken.getType() == Token.TokenType.NEQ ){
                eqExpTK = match(Token.TokenType.NEQ);
            }
            EqExp eqExp = EqExp();
            return new EqExp(eqExp,relExp,eqExpTK);
        } else return new EqExp(relExp);
    }

    private RelExp RelExp(){
        // RelExp → AddExp | RelExp ('<' | '>' | '<=' | '>=') AddExp
        AddExp addExp = AddExp();
        if( currentToken.getType() == Token.TokenType.LSS || currentToken.getType() == Token.TokenType.LEQ
                || currentToken.getType() == Token.TokenType.GRE || currentToken.getType() == Token.TokenType.GEQ ){
            Token relExpTK = null;
            if( currentToken.getType() == Token.TokenType.LSS ){
                relExpTK = match(Token.TokenType.LSS);
            }else if( currentToken.getType() == Token.TokenType.LEQ ){
                relExpTK = match(Token.TokenType.LEQ);
            }else if( currentToken.getType() == Token.TokenType.GRE ){
                relExpTK = match(Token.TokenType.GRE);
            }else if( currentToken.getType() == Token.TokenType.GEQ ){
                relExpTK = match(Token.TokenType.GEQ);
            }
            RelExp relExp = RelExp();
            return new RelExp(relExp,addExp,relExpTK);
        } else return new RelExp(addExp);
    }

    private PrimaryExp PrimaryExp(){
        // PrimaryExp → '(' Exp ')' | LVal | Number
        if( currentToken.getType() == Token.TokenType.LPARENT ){
            match(Token.TokenType.LPARENT);
            Exp exp = Exp();
            match(Token.TokenType.RPARENT);
            return new PrimaryExp(exp);
        }else if( currentToken.getType() == Token.TokenType.IDENFR ){
            LVal lVal = LVal();
            return new PrimaryExp(lVal);
        }else{
            Number number = Number();
            return new PrimaryExp(number);
        }
    }
    
    private Number Number(){
        // Number → IntConst | floatConst
        Token tmp = currentToken;
        if (index < tokens.size() - 1) {
            currentToken = tokens.get(++index);
        }
        return new Number(tmp);
    }

    private BType BType(){
        // BType → 'int' | 'float'
        Token bTypeToken = null;
        if(Objects.equals(currentToken.getContent(), "int")){
            bTypeToken = match(Token.TokenType.INTTK);
        } else bTypeToken = match(Token.TokenType.FLOATTK);
        return new BType(bTypeToken);
    }

    private VarDecl VarDecl(){
        // VarDecl → BType VarDef { ',' VarDef } ';'
        BType bType = BType();
        List<VarDef> varDefs = new ArrayList<>();
        varDefs.add(VarDef());
        while( currentToken.getType() == Token.TokenType.COMMA ){
            match(Token.TokenType.COMMA);
            varDefs.add(VarDef());
        }
        match(Token.TokenType.SEMICN);
        return new VarDecl(bType,varDefs);
    }

    private VarDef VarDef(){
        // VarDef → Ident { '[' ConstExp ']' } | Ident { '[' ConstExp ']' } '=' InitVal
        Token ident = match(Token.TokenType.IDENFR);
        List<ConstExp> constExps = new ArrayList<>();
        InitVal initVal = null;
        while( currentToken.getType() == Token.TokenType.LBRACK ){
            match(Token.TokenType.LBRACK);
            constExps.add(ConstExp());
            match(Token.TokenType.RBRACK);
        }
        if( currentToken.getType() == Token.TokenType.ASSIGN ){
            match(Token.TokenType.ASSIGN);
            initVal = InitVal();
            return new VarDef(ident,constExps,initVal);
        }
        else return new VarDef(ident,constExps);
    }

    private InitVal InitVal(){
        // InitVal → Exp | '{' [ InitVal { ',' InitVal } ] '}'
        Exp exp = null;
        List<InitVal> initVals = new ArrayList<>();
        if( currentToken.getType() == Token.TokenType.LBRACE ){
            match(Token.TokenType.LBRACE);
            if( currentToken.getType() != Token.TokenType.RBRACE ){
                initVals.add(InitVal());
                while( currentToken.getType() == Token.TokenType.COMMA ){
                    match(Token.TokenType.COMMA);
                    initVals.add(InitVal());
                }
            }
            match(Token.TokenType.RBRACE);
            return new InitVal(initVals);
        }else{
            exp = Exp();
            return new InitVal(exp);
        }
    }

    private FuncDef FuncDef(){
        // FuncDef → FuncType Ident '(' [FuncFParams] ')' Block
        FuncType funcType = FuncType();
        Token ident = match(Token.TokenType.IDENFR);
        match(Token.TokenType.LPARENT);
        FuncFParams funcFParams = null;
        Block block = null;
        if( currentToken.getType() != Token.TokenType.RPARENT ){ // != {
            funcFParams = FuncFParams();
        }
        match(Token.TokenType.RPARENT);
        block = Block();
        return new FuncDef(funcType,ident,funcFParams,block);
    }

    private Block Block(){
        // Block → '{' { BlockItem } '}'
        match(Token.TokenType.LBRACE);
        List<BlockItem> blockItems = new ArrayList<>();
        while( currentToken.getType() != Token.TokenType.RBRACE ){
            blockItems.add(BlockItem());
        }
        match(Token.TokenType.RBRACE);
        return new Block(blockItems);
    }

    private BlockItem  BlockItem(){
        // BlockItem → Decl | Stmt
        if( currentToken.getType() == Token.TokenType.INTTK ||  currentToken.getType() == Token.TokenType.FLOATTK || currentToken.getType() == Token.TokenType.CONSTTK){
            Decl decl =  Decl();
            return new BlockItem(decl);
        }else{
            Stmt stmt = Stmt();
            return new BlockItem(stmt);
        }
    }

    private Stmt Stmt(){
        //         Stmt → LVal '=' Exp ';' // 每种类型的语句都要覆盖
        //         | [Exp] ';' //有无Exp两种情况
        //         | Block
        //         | 'if' '(' Cond ')' Stmt [ 'else' Stmt ] // 1.有else 2.无else
        //         | 'while' '(' Cond ')' Stmt
        //         | 'break' ';' | 'continue' ';'
        //         | 'return' [Exp] ';' // 1.有Exp 2.无Exp
        int type = getStmtType();
        switch (type){
            case 1: {
                // LVal '=' Exp ';'
                LVal lVal = LVal();
                match(Token.TokenType.ASSIGN);
                Exp exp = Exp();
                match(Token.TokenType.SEMICN);
                return new Stmt(type,lVal,exp);
            }
            case 2: {
                // [Exp] ';'
                Exp exp = null;
                if( currentToken.getType() != Token.TokenType.SEMICN ){
                    exp = Exp();
                }
                match(Token.TokenType.SEMICN);
                return new Stmt(type,exp);
            }
            case 3: {
                // Block
                Block block = Block();
                return new Stmt(type,block);
            }
            case 4: {
                // 'if' '(' Cond ')' Stmt [ 'else' Stmt ]
                match(Token.TokenType.IFTK);
                match(Token.TokenType.LPARENT);
                Cond cond =  Cond();
                match(Token.TokenType.RPARENT);
                Stmt stmt_1 = Stmt();
                Stmt stmt_2 = null;
                if( currentToken.getType() == Token.TokenType.ELSETK ){
                    match(Token.TokenType.ELSETK);
                    stmt_2 = Stmt();
                }
                return new Stmt(type,cond,stmt_1,stmt_2);
            }
            case 5: {
                // 'while' '(' Cond ')' Stmt
                match(Token.TokenType.WHILETK);
                match(Token.TokenType.LPARENT);
                Cond cond =  Cond();
                match(Token.TokenType.RPARENT);
                Stmt stmt = Stmt();
                return new Stmt(type,cond,stmt);
            }
            case 6: {
                // 'break' ';' | 'continue' ';'
                if( currentToken.getType() == Token.TokenType.CONTINUETK ){
                    Token continueTK = match(Token.TokenType.CONTINUETK);
                    match(Token.TokenType.SEMICN);
                    return new Stmt(type,continueTK);
                }else{
                    Token breakTK = match(Token.TokenType.BREAKTK);
                    match(Token.TokenType.SEMICN);
                    return new Stmt(type,breakTK);
                }
            }
            case 7: {
                // 'return' [Exp] ';'
                match(Token.TokenType.RETURNTK);
                Exp exp = null;
                if(currentToken.getType() != Token.TokenType.SEMICN){
                    exp = Exp();
                }
                match(Token.TokenType.SEMICN);
                return new Stmt(type,exp);
            }
            default: return null;
        }
    }

    private int getStmtType(){
        int type = 0;
        if( currentToken.getType() == Token.TokenType.LBRACE ){
            type = 3;
        }else if( currentToken.getType() == Token.TokenType.IFTK ){
            type = 4;
        }else if( currentToken.getType() == Token.TokenType.WHILETK ){
            type = 5;
        }else if( currentToken.getType() == Token.TokenType.BREAKTK || currentToken.getType() == Token.TokenType.CONTINUETK){
            type = 6;
        }else if( currentToken.getType() == Token.TokenType.RETURNTK ){
            type = 7;
        }
        if(type != 0 )return type;
        int len = index;
        int flag = 0;
        while( tokens.get(len).getType() != Token.TokenType.SEMICN ){
            if( tokens.get(len).getType() == Token.TokenType.ASSIGN ){
                flag = 1;
                break;
            }
            len++;
        }
        if( flag == 1 ){
            type = 1;
        }else
            type = 2;
        return type;
    }

    private FuncFParams FuncFParams(){
        // FuncFParams → FuncFParam { ',' FuncFParam }
        List<FuncFParam> funcFParams = new ArrayList<>();
        funcFParams.add(FuncFParam());
        while( currentToken.getType() == Token.TokenType.COMMA ){
            match(Token.TokenType.COMMA);
            funcFParams.add(FuncFParam());
        }
        return new FuncFParams(funcFParams);
    }

    private FuncFParam FuncFParam(){
        // FuncFParam → BType Ident ['[' ']' { '[' ConstExp ']' }]
        BType bType = BType();
        Token lbrack = null;
        Token rbrack = null;
        Token ident = match(Token.TokenType.IDENFR);
        List<ConstExp> constExps = new ArrayList<>();
        if(currentToken.getType() == Token.TokenType.LBRACK){
            lbrack = match(Token.TokenType.LBRACK);
            rbrack = match(Token.TokenType.RBRACK);
            while(currentToken.getType() == Token.TokenType.LBRACK) {
                match(Token.TokenType.LBRACK);
                constExps.add(ConstExp());
                match(Token.TokenType.RBRACK);
            }
        }
        return new FuncFParam(bType,ident,lbrack,rbrack,constExps);
    }

    private FuncType FuncType(){
        // FuncType → 'void' | 'int' | 'float'
        Token funcType = null;
        if( currentToken.getType() == Token.TokenType.INTTK) {
            funcType = match(Token.TokenType.INTTK);
        } else if(currentToken.getType() == Token.TokenType.VOIDTK){
            funcType = match(Token.TokenType.VOIDTK);
        } else if(currentToken.getType() == Token.TokenType.FLOATTK){
            funcType = match(Token.TokenType.FLOATTK);
        }
        return new FuncType(funcType);
    }

    private  MainFuncDef MainFuncDef(){
        // MainFuncDef → 'int' 'main' '(' ')' Block
        match(Token.TokenType.INTTK);
        match(Token.TokenType.MAINTK);
        match(Token.TokenType.LPARENT);
        match(Token.TokenType.RPARENT);
        Block block = Block();
        return new MainFuncDef(block);
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

package token;

public class Token {
    public enum TokenType {
        IDENFR, HEXCON, DECCON, OCTCON, HEXFLTCON, DECFLTCON, STRCON, MAINTK, CONSTTK, INTTK, BREAKTK, CONTINUETK, IFTK, ELSETK,
        NOT, AND, OR, WHILETK, PRINTFTK, RETURNTK, PLUS, MINU, VOIDTK, FLOATTK,
        MULT, DIV, MOD, LSS, LEQ, GRE, GEQ, EQL, NEQ,
        ASSIGN, SEMICN, COMMA, LPARENT, RPARENT, LBRACK, RBRACK, LBRACE, RBRACE;
    }
    private final TokenType type;
    private final int lineNum;
    private final String content;

    public Token(TokenType type, int lineNum, String content) {
        this.type = type;
        this.lineNum = lineNum;
        this.content = content;
    }

    //final只允许访问
    public TokenType getType() {
        return type;
    }

    public int getLineNum() {
        return lineNum;
    }

    public String getContent() {
        return content;
    }

    @Override
    public String toString() {
        return type.toString() + " " + content + "\n";
    }//重写方法
}

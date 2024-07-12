package frontend;

import token.Token;
import utils.IOFunc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LexicalAnalyze {
    //唯一实例
    private static final LexicalAnalyze lexical = new LexicalAnalyze();

    public static LexicalAnalyze getLexical() {
        return lexical;
    }

    private final List<Token> tokens = new ArrayList<>();

    public List<Token> getTokens() {
        return tokens;
    }

    private final Map<String, Token.TokenType> keywords = new HashMap<>() {{
        put("main", Token.TokenType.MAINTK);
        put("const", Token.TokenType.CONSTTK);
        put("int", Token.TokenType.INTTK);
        put("break", Token.TokenType.BREAKTK);
        put("continue", Token.TokenType.CONTINUETK);
        put("if", Token.TokenType.IFTK);
        put("while", Token.TokenType.WHILETK);
        put("else", Token.TokenType.ELSETK);
        put("return", Token.TokenType.RETURNTK);
        put("void", Token.TokenType.VOIDTK);
        put("float", Token.TokenType.FLOATTK);
    }};

    private final Map<String, Token.TokenType> singleSymbols = new HashMap<>() {{
        put("+", Token.TokenType.PLUS);
        put("-", Token.TokenType.MINU);
        put("*", Token.TokenType.MULT);
        put("%", Token.TokenType.MOD);
        put(";", Token.TokenType.SEMICN);
        put(",", Token.TokenType.COMMA);
        put("(", Token.TokenType.LPARENT);
        put(")", Token.TokenType.RPARENT);
        put("[", Token.TokenType.LBRACK);
        put("]", Token.TokenType.RBRACK);
        put("{", Token.TokenType.LBRACE);
        put("}", Token.TokenType.RBRACE);
    }};

    public void analyze(String str) {
        int lineNum = 1;//当前的行数
        int length = str.length(); // 源代码长度
        for (int i = 0; i < length; i++) {
            char s = str.charAt(i);
            char next = i + 1 < length ? str.charAt(i + 1) : '\0';
            if (s == '\n') lineNum++;
            else if (s == '_' || Character.isLetter(s)) {//标识符
                String idenfr = "" + s;
                for (int j = i + 1; j < length; j++) {
                    char t = str.charAt(j);
                    if (t == '_' || Character.isLetter(t) || Character.isDigit(t)) idenfr += t;
                    else {
                        i = j - 1;
                        break;
                    }
                }
                Token.TokenType type;//检查是否是关键词
                type = keywords.getOrDefault(idenfr, Token.TokenType.IDENFR);
                tokens.add(new Token(type, lineNum, idenfr));
            } else if (s == '/') {//单行注释 多行注释 除号
                if (next == '/') {
                    for (int j = i + 2; j < length; j++) {
                        char t = str.charAt(j);
                        if (t == '\n') {
                            i = j - 1;
                            break;
                        }
                    }
                } else if (next == '*') {
                    for (int j = i + 2; j + 1 < length; j++) {
                        char t = str.charAt(j);
                        char p = str.charAt(j + 1);
                        if (t == '\n') lineNum++;
                        if (t == '*' && p == '/') {
                            i = j + 1;
                            break;
                        }
                    }
                } else tokens.add(new Token(Token.TokenType.DIV, lineNum, "/"));
            } else if (Character.isDigit(s) || '.' == s) { //数字
                StringBuilder num = new StringBuilder("");
                boolean isFloat = false;
                boolean isHex = false;
                boolean isOct = (s == '0');

                while (Character.isDigit(s) || s == 'x' || s == 'X' || s == '+' || s == '-'
                        || s == 'p' || s == 'P' || s == '.' ||
                        (s >= 'a' && s <= 'f') || (s >= 'A' && s <= 'F')) {
                    if (s == '.') {
                        isFloat = true;
                        isOct = false;
                    } else if (s == 'X' || s == 'x') {
                        isHex = true;
                        isOct = false;
                    } else if (s == 'p' || s == 'P') {
                        isFloat = true;
                        isHex = true;
                    } else if ((s == 'e' || s == 'E') && !isHex) {
                        isFloat = true;
                    } else if (s == '+' || s == '-') {
                        String nowStr = num.toString();
                        char last = nowStr.charAt(nowStr.length() - 1);
                        if (last != 'p' && last != 'P' && last != 'e' && last != 'E') {
                            break;
                        }
                        if ((last == 'e' || last == 'E') && !isFloat) {
                            break;
                        }
                    }
                    num.append(s);
                    i++;
                    s = str.charAt(i);
                }
                i--;
                String Num = num.toString();
                if (Num.equals("0")) isOct = false;
                if (isFloat && isHex) tokens.add(new Token(Token.TokenType.HEXFLTCON, lineNum, Num));
                else if (isFloat) tokens.add(new Token(Token.TokenType.DECFLTCON, lineNum, Num));
                else if (isHex) tokens.add(new Token(Token.TokenType.HEXCON, lineNum, Num));
                else if (isOct) tokens.add(new Token(Token.TokenType.OCTCON, lineNum, Num));
                else tokens.add(new Token(Token.TokenType.DECCON, lineNum, Num));

//                boolean isHex = false;
//                boolean isFloat = false;
//                boolean isExponent = false;
//
//                if (s == '0' && (i + 1 < length) && (str.charAt(i + 1) == 'x' || str.charAt(i + 1) == 'X')) {
//                    isHex = true;
//                    num.append(str.charAt(i + 1));
//                    i++; // 跳过 'x' 或 'X'
//                }
//
//                for (int j = i + 1; j < length; j++) {
//                    char t = str.charAt(j);
//                    if (isHex && (Character.isDigit(t) || (t >= 'a' && t <= 'f') || (t >= 'A' && t <= 'F'))) {
//                        num.append(t);
//                    } else if (!isHex && (Character.isDigit(t) || t == '.' || t == 'e' || t == 'E')) {
//                        if (t == '.') {
//                            if (isFloat) { // 已经有一个点了，说明浮点数结束
//                                i = j - 1;
//                                break;
//                            }
//                            isFloat = true;
//                        } else if (t == 'e' || t == 'E') {
//                            if (isExponent) { // 已经有一个 'e' 或 'E'，说明科学计数法部分结束
//                                i = j - 1;
//                                break;
//                            }
//                            isExponent = true;
//                            isFloat = true; // 科学计数法也算浮点数
//                        }
//                        num.append(t);
//                    } else if (isExponent && (t == '+' || t == '-')) {
//                        num.append(t);
//                    } else {
//                        i = j - 1;
//                        break;
//                    }
//                }
//
//                if (isFloat) {
//                    tokens.add(new Token(Token.tokenType.FLTCON, lineNum, num.toString()));
//                } else {
//                    if (isHex) {// 将十六进制字符串转换为十进制字符串
//                        int decimalValue = Integer.parseInt(num.substring(2), 16);
//                        num = new StringBuilder(Integer.toString(decimalValue));
//                    }
//                    tokens.add(new Token(Token.tokenType.INTCON, lineNum, num.toString()));
//                }
            } else if (s == '\"') {//字符串
                StringBuilder _str = new StringBuilder("" + s);
                for (int j = i + 1; j < length; j++) {
                    char t = str.charAt(j);
                    _str.append(t);
                    if (t != '\"') {
                        //处理错误
                        continue;
                    } else {
                        i = j;
                        break;
                    }
                }
                tokens.add(new Token(Token.TokenType.STRCON, lineNum, _str.toString()));
            } else if (s == '!') {//  ! 或 !=
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.TokenType.NEQ, lineNum, "!="));
                } else {
                    tokens.add(new Token(Token.TokenType.NOT, lineNum, "!"));
                }
            } else if (s == '&') {//  &&
                if (next == '&') {
                    i++;
                    tokens.add(new Token(Token.TokenType.AND, lineNum, "&&"));
                }
            } else if (s == '|') {//  ||
                if (next == '|') {
                    i++;
                    tokens.add(new Token(Token.TokenType.OR, lineNum, "||"));
                }
            } else if (s == '<') {//  <= 或 <
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.TokenType.LEQ, lineNum, "<="));
                } else tokens.add(new Token(Token.TokenType.LSS, lineNum, "<"));
            } else if (s == '>') {//  >= 或 >
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.TokenType.GEQ, lineNum, ">="));
                } else tokens.add(new Token(Token.TokenType.GRE, lineNum, ">"));
            } else if (s == '=') {//  == 或 =
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.TokenType.EQL, lineNum, "=="));
                } else tokens.add(new Token(Token.TokenType.ASSIGN, lineNum, "="));
            } else if (singleSymbols.containsKey(s + "")) {
                tokens.add(new Token(singleSymbols.get(s + ""), lineNum, "" + s));
            } else {
                if (!Character.isWhitespace(s)) {
                    System.out.println("LexicalAnalyze Error! " + s + " in the line " + lineNum + " is not a correct char");
                }
            }
        }
    }

    public void printTokens() {
        for (Token token : tokens) {
            IOFunc.output(token.toString());
        }
    }
}

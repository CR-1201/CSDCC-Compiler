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

    private final Map<String, Token.tokenType> keywords = new HashMap<>() {{
        put("main", Token.tokenType.MAINTK);
        put("const", Token.tokenType.CONSTTK);
        put("int", Token.tokenType.INTTK);
        put("break", Token.tokenType.BREAKTK);
        put("continue", Token.tokenType.CONTINUETK);
        put("if", Token.tokenType.IFTK);
        put("while", Token.tokenType.WHILETK);
        put("else", Token.tokenType.ELSETK);
        put("printf", Token.tokenType.PRINTFTK);
        put("return", Token.tokenType.RETURNTK);
        put("void", Token.tokenType.VOIDTK);
        put("float", Token.tokenType.FLOATTK);
    }};

    private final Map<String, Token.tokenType> singleSymbols = new HashMap<>() {{
        put("+", Token.tokenType.PLUS);
        put("-", Token.tokenType.MINU);
        put("*", Token.tokenType.MULT);
        put("%", Token.tokenType.MOD);
        put(";", Token.tokenType.SEMICN);
        put(",", Token.tokenType.COMMA);
        put("(", Token.tokenType.LPARENT);
        put(")", Token.tokenType.RPARENT);
        put("[", Token.tokenType.LBRACK);
        put("]", Token.tokenType.RBRACK);
        put("{", Token.tokenType.LBRACE);
        put("}", Token.tokenType.RBRACE);
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
                Token.tokenType type;//检查是否是关键词
                type = keywords.getOrDefault(idenfr, Token.tokenType.IDENFR);
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
                } else tokens.add(new Token(Token.tokenType.DIV, lineNum, "/"));
            } else if (Character.isDigit(s)) {//数字
                StringBuilder num = new StringBuilder("" + s);
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
                if (isFloat && isHex) tokens.add(new Token(Token.tokenType.HEXFLTCON, lineNum, Num));
                else if (isFloat) tokens.add(new Token(Token.tokenType.DECFLTCON, lineNum, Num));
                else if (isHex) tokens.add(new Token(Token.tokenType.HEXCON, lineNum, Num));
                else if (isOct) tokens.add(new Token(Token.tokenType.OCTCON, lineNum, Num));
                else tokens.add(new Token(Token.tokenType.DECCON, lineNum, Num));


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
                tokens.add(new Token(Token.tokenType.STRCON, lineNum, _str.toString()));
            } else if (s == '!') {//  ! 或 !=
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.tokenType.NEQ, lineNum, "!="));
                } else {
                    tokens.add(new Token(Token.tokenType.NOT, lineNum, "!"));
                }
            } else if (s == '&') {//  &&
                if (next == '&') {
                    i++;
                    tokens.add(new Token(Token.tokenType.AND, lineNum, "&&"));
                }
            } else if (s == '|') {//  ||
                if (next == '|') {
                    i++;
                    tokens.add(new Token(Token.tokenType.OR, lineNum, "||"));
                }
            } else if (s == '<') {//  <= 或 <
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.tokenType.LEQ, lineNum, "<="));
                } else tokens.add(new Token(Token.tokenType.LSS, lineNum, "<"));
            } else if (s == '>') {//  >= 或 >
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.tokenType.GEQ, lineNum, ">="));
                } else tokens.add(new Token(Token.tokenType.GRE, lineNum, ">"));
            } else if (s == '=') {//  == 或 =
                if (next == '=') {
                    i++;
                    tokens.add(new Token(Token.tokenType.EQL, lineNum, "=="));
                } else tokens.add(new Token(Token.tokenType.ASSIGN, lineNum, "="));
            } else if (singleSymbols.containsKey(s + "")) {
                tokens.add(new Token(singleSymbols.get(s + ""), lineNum, "" + s));
            } else {
                if (s != ' ') {
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

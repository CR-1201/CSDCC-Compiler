import config.Config;
import frontend.LexicalAnalyze;
import frontend.ParserAnalyze;
import utils.IOFunc;

import java.io.IOException;

public class Compiler {
    public static void main(String[] args) throws IOException {
        // 初始化
        Config.init();

        // 词法分析
        LexicalAnalyze.getLexical().analyze(IOFunc.input(Config.fileInPutPath));
        LexicalAnalyze.getLexical().printTokens();

        // 语法分析
        ParserAnalyze.getParser().setTokens(LexicalAnalyze.getLexical().getTokens());
        ParserAnalyze.getParser().analyze();
        ParserAnalyze.getParser().printParseAns();

    }
}
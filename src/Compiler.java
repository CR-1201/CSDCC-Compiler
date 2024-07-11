import ast.CompUnit;
import config.Config;
import frontend.LexicalAnalyze;
import frontend.ParserAnalyze;
import ir.IrBuilder;
import ir.Module;
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

        // ir build
        CompUnit syntaxTreeRoot = ParserAnalyze.getParser().getCompUnit();
        IrBuilder.getIrBuilder().buildModule(syntaxTreeRoot);
        IOFunc.output(Module.getModule().toString(),Config.irOutPutPath);
    }
}
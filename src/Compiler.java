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
        // 设置默认值
        String fileInPutPath = "testfile.txt";
        String fileOutPutPath = "output.txt";
        String irOutPutPath = "llvm_ir.txt";
        // 解析命令行参数
        for (int i = 0; i < args.length; i++) {
            if ("-f".equals(args[i]) && i + 1 < args.length) {
                fileInPutPath = args[i + 1];
            } else if ("-ll".equals(args[i]) && i + 1 < args.length) {
                irOutPutPath = args[i + 1];
            } else if ("-o".equals(args[i]) && i + 1 < args.length) {
                fileOutPutPath = args[i + 1];
            }
        }
        // 初始化
        Config.init(fileInPutPath,irOutPutPath,fileOutPutPath);

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
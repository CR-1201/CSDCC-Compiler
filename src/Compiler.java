import ast.CompUnit;
import config.Config;
import frontend.LexicalAnalyze;
import frontend.ParserAnalyze;
import ir.IrBuilder;
import ir.Module;
import pass.PassManager;
import utils.IOFunc;

import java.io.IOException;

public class Compiler {
    public static void main(String[] args) throws IOException {
        // 设置默认值
        String fileInputPath = "testfile.txt";
        String fileOutputPath = "output.txt";
        String irOutputPath = "llvm_ir.txt";
        // 解析命令行参数
        for (int i = 0; i < args.length; i++) {
            if ("-f".equals(args[i]) && i + 1 < args.length) {
                fileInputPath = args[i + 1];
            } else if ("-ll".equals(args[i]) && i + 1 < args.length) {
                irOutputPath = args[i + 1];
            } else if ("-o".equals(args[i]) && i + 1 < args.length) {
                fileOutputPath = args[i + 1];
            }
        }
        // 初始化
        Config.init(fileInputPath,irOutputPath,fileOutputPath);

        // 词法分析
        LexicalAnalyze.getLexical().analyze(IOFunc.input(Config.fileInputPath));
        LexicalAnalyze.getLexical().printTokens();

        // 语法分析
        ParserAnalyze.getParser().setTokens(LexicalAnalyze.getLexical().getTokens());
        ParserAnalyze.getParser().analyze();

        // ir build
        CompUnit syntaxTreeRoot = ParserAnalyze.getParser().getCompUnit();
        IrBuilder.getIrBuilder().buildModule(syntaxTreeRoot);
        IOFunc.output(Module.getModule().toString(),Config.irOutputPath);

        // pass
        PassManager passManager = new PassManager();
        passManager.run();
    }
}
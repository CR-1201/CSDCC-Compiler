import ast.CompUnit;
import backend.ObjBuilder;
import backend.module.ObjModule;
import backend.pass.ObjPassManager;
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
        String fileInputPath = "testcase.sy";
        String fileOutputPath = "testcase.s";
        String irOutputPath = "llvm_ir.txt";
        // 解析命令行参数
        for (int i = 0; i < args.length; i++) {
//            if ("-f".equals(args[i]) && i + 1 < args.length) {
//                fileInputPath = args[i + 1];
//            } else if ("-ll".equals(args[i]) && i + 1 < args.length) {
//                irOutputPath = args[i + 1];
            if ("-o".equals(args[i]) && i + 2 < args.length) {
                fileOutputPath = args[i + 1];
                fileInputPath = args[i + 2];
            }

            if ("-O1".equals(args[i])) {
                Config.isO1 = true;
            }
        }
//        fileInputPath = args[0];
//        fileOutputPath = args[1];
        // 初始化
        Config.init(fileInputPath, irOutputPath, fileOutputPath);

        // 词法分析
        LexicalAnalyze.getLexical().analyze(IOFunc.input(Config.fileInputPath));
//        LexicalAnalyze.getLexical().printTokens();

        // 语法分析
        ParserAnalyze.getParser().setTokens(LexicalAnalyze.getLexical().getTokens());
        ParserAnalyze.getParser().analyze();

        // ir build
        CompUnit syntaxTreeRoot = ParserAnalyze.getParser().getCompUnit();
        IrBuilder.getIrBuilder().buildModule(syntaxTreeRoot);
        IOFunc.clear(Config.irRawOutputPath);
        IOFunc.output(Module.getModule().toString(), Config.irRawOutputPath);

        // pass
        PassManager passManager = new PassManager();
        passManager.run();

        IOFunc.clear(Config.irOptimizeOutputPath);
        IOFunc.output(Module.getModule().toString(), Config.irOptimizeOutputPath);

        // 生成目标代码
        ObjBuilder.getObjBuilder().build();

        ObjPassManager objPassManager = new ObjPassManager();
//        objPassManager.run();

        IOFunc.output(ObjModule.getModule().toString(), fileOutputPath);
    }
}
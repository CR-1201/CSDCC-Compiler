import ast.CompUnit;
import backend.ObjBuilder;
import backend.module.ObjModule;
import backend.pass.ObjPassManager;
import config.Config;
import frontend.LexicalAnalyze;
import frontend.ParserAnalyze;
import ir.BasicBlock;
import ir.Function;
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
        String irOutputPath = "llvm_ir.ll";
        // 解析命令行参数
        for (int i = 0; i < args.length; i++) {
//            if ("-f".equals(args[i]) && i + 1 < args.length) {
//                fileInputPath = args[i + 1];
//            } else if ("-ll".equals(args[i]) && i + 1 < args.length) {
//                irOutputPath = args[i + 1];
//            } else if ("-o".equals(args[i]) && i + 1 < args.length) {
//                fileOutputPath = args[i + 1];
//            }

            /* 编译大赛平台提交版本 */
            if ("-o".equals(args[i]) && i + 2 < args.length) {
                fileOutputPath = args[i + 1];
                fileInputPath = args[i + 2];
            }

            if ("-O1".equals(args[i])) {
                Config.isO1 = true;
                Config.MulOpt = true;
            }
        }
//        Config.isO1 = true;
//        Config.MulOpt = true;
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
        IOFunc.output(Module.getModule().toString(), Config.irRawOutputPath);

        // pass
        PassManager passManager = new PassManager();
        if (Config.isO1) {
            passManager.run();
        } else {
            passManager.run2();
        }
        IOFunc.output(Module.getModule().toString(), Config.irOutputPath);

        // 生成目标代码
        ObjBuilder.getObjBuilder().build();

        if (Config.isO1) {
            ObjPassManager objPassManager = new ObjPassManager();
            objPassManager.run();
        }

        IOFunc.output(ObjModule.getModule().toString(), fileOutputPath);

//        IOFunc.output(ObjModule.getModule().toString(), "peephole.s");
    }
}
package config;

import utils.IOFunc;

import java.io.IOException;

public class Config {
    public static String fileInputPath = "testcase.sy";
    public static String fileOutputPath = "testcase.s";
    public static String ERROR_FILE = "error.txt";
    public static String irOutputPath = "llvm_ir.ll";
    public static String irRawOutputPath = "llvm_ir_raw.ll";
    public static boolean isO1 = true;
    public static boolean MulOpt = false;
    public static boolean enableParallel = false;
    public static int parallelProcessNum = 4;
    public static int maxParallelDepth = 2;

    public static boolean enableLLMMod = false;

    public static void init(String in,String llvm, String arm) throws IOException {
        fileInputPath = in;
        irOutputPath = llvm;
        fileOutputPath = arm;
//        IOFunc.clear(ERROR_FILE);
        IOFunc.clear(irOutputPath);
        IOFunc.clear(irRawOutputPath);
        IOFunc.clear(fileOutputPath);
    }
}

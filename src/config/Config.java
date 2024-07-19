package config;

import utils.IOFunc;

import java.io.IOException;

public class Config {
    public static String fileInputPath = "testfile.txt";
    public static String fileOutputPath = "output.txt";
    public static String ERROR_FILE = "error.txt";
    public static String irOutputPath = "llvm_ir.txt";
    public static String irRawOutputPath = "llvm_ir_raw.txt";
    public static String irOptimizeOutputPath = "llvm_ir_op.txt";

    public static void init(String in,String llvm, String arm) throws IOException {
        fileInputPath = in;
        irOutputPath = llvm;
        fileOutputPath = arm;
//        IOFunc.clear(ERROR_FILE);
//        IOFunc.clear(irOutputPath);
//        IOFunc.clear(irRawOutputPath);
        IOFunc.clear(fileOutputPath);
    }
}

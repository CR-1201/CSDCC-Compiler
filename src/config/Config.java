package config;

import utils.IOFunc;

import java.io.IOException;

public class Config {
    public static String fileInputPath = "testfile.txt";
    public static String fileOutputPath = "output.txt";
    public static String ERROR_FILE = "error.txt";
    public static String irOutputPath = "llvm_ir.txt";
    public static String irOptimizeOutputPath = "llvm_ir_optimize.txt";
    public static void init(String in,String llvm, String arm) throws IOException {
        fileInputPath = in;
        irOptimizeOutputPath = llvm;
        fileOutputPath = arm;
        IOFunc.clear(ERROR_FILE);
        IOFunc.clear(irOutputPath);
        IOFunc.clear(irOptimizeOutputPath);
        IOFunc.clear(fileOutputPath);
    }
}

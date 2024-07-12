package config;

import utils.IOFunc;

import java.io.IOException;

public class Config {
    public static String fileInPutPath = "testfile.txt";
    public static String fileOutPutPath = "output.txt";
    public static String ERROR_FILE = "error.txt";
    public static String irOutPutPath = "llvm_ir.txt";
    public static void init(String in,String llvm, String arm) throws IOException {
        fileInPutPath = in;
        irOutPutPath = llvm;
        fileOutPutPath = arm;
        IOFunc.clear(ERROR_FILE);
        IOFunc.clear(irOutPutPath);
        IOFunc.clear(fileOutPutPath);
    }
}

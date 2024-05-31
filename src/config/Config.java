package config;

import utils.IOFunc;

import java.io.IOException;

public class Config {
    final public static String fileInPutPath = "testfile.txt";
    final public static String fileOutPutPath = "output.txt";
    final public static  String ERROR_FILE = "error.txt";
    final public static String irOutPutPath = "llvm_ir.txt";
    public static void init() throws IOException {
        IOFunc.clear(fileOutPutPath);
        IOFunc.clear(ERROR_FILE);
        IOFunc.clear(irOutPutPath);
    }
}

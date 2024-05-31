import config.Config;
import frontend.LexicalAnalyze;
import utils.IOFunc;

import java.io.IOException;

public class Compiler {
    public static void main(String[] args) throws IOException {
        Config.init();

        LexicalAnalyze.getLexical().analyze(IOFunc.input(Config.fileInPutPath));
        LexicalAnalyze.getLexical().printTokens();

    }
}
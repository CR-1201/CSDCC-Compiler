package utils;

import ir.BasicBlock;
import ir.Function;
import ir.User;
import ir.Value;

public class Logger {
    public static void log(String message) {
        System.out.println(message);
    }

    public static String cfg(Function function) {
        StringBuilder sb = new StringBuilder();
        for (BasicBlock block : function.getBasicBlocksArray()) {
            sb.append("========= ").append(block.getName()).append(" =========").append("\n");
            sb.append("PRECURSORS: ").append("\n");
            for (BasicBlock prec : block.getPrecursors()) {
                sb.append("\t").append(prec.getName()).append("\n");
            }
            sb.append("SUCCESSORS: ").append("\n");
            for (BasicBlock succ : block.getSuccessors()) {
                sb.append("\t").append(succ.getName()).append("\n");
            }
        }
        return sb.toString();
    }

    public static String useInfo(Value value) {
        StringBuilder sb = new StringBuilder();
        sb.append("VALUE: ");
        if (value instanceof BasicBlock block) {
            sb.append(block.getName()).append("\n");
        } else {
            sb.append(value).append("\n");
        }
        for (User user : value.getUsers()) {
            sb.append("\t").append("User: ").append(user).append("\n");
        }
        return sb.toString();
    }
}

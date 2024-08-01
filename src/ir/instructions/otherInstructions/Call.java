package ir.instructions.otherInstructions;

import ir.Argument;
import ir.BasicBlock;
import ir.Function;
import ir.Value;
import ir.instructions.Instruction;

import java.util.ArrayList;

/**
 @author Conroy
 <result> = call [ret attrs] <ty> <fnptrval>(<function args>)
 */
public class Call extends Instruction {

    /**
     * 有返回值的call
     * @param function 第一个操作数,被调用的函数,返回值一定不是void
     * @param args     从第二个操作数开始排列,函数参数
     */
    public Call(int nameNum, BasicBlock parent, Function function, ArrayList<Value> args){
        super("%v" + nameNum, function.getReturnType(), parent, new ArrayList<>(){{
            add(function);addAll(args);
        }});
    }

    /**
     * 没有返回值的call
     * @param function 同上,一定是void返回值
     * @param args     同上
     */
    public Call( BasicBlock parent, Function function, ArrayList<Value> args){
        super("", function.getReturnType(), parent, new ArrayList<>(){{
            add(function);addAll(args);
        }});
    }

    // 获得call指令被调用的函数
    public Function getFunction(){
        return (Function) getOperator(0);
    }

    // 获得call指令传递给函数的参数,全部为具体的 value,不是形参
    public ArrayList<Value> getArgs(){
        ArrayList<Value> args = new ArrayList<>();
        int n = getFunction().getNumArgs();
        for (int i = 0; i < n; i++){
            args.add(getOperator(i + 1));
        }
        return args;
    }

    public Value getParamAt(int i){
        return getOperator(i + 1);
    }

    @Override
    public String toString(){
        Function function = (Function) getOperator(0);
        boolean noReturn = getName().isEmpty();
        StringBuilder s = new StringBuilder(getName()).append(!noReturn ? " = call " : "call ").append(function.getReturnType()).append(' ').append(function.getName()).append('(');
        int num = function.getNumArgs();
        for (int i = 1; i <= num; i++) {
            s.append(getOperator(i).getValueType()).append(' ').append(getOperator(i).getName()).append(", ");
        }
        if (num > 0) {
            s.delete(s.length() - 2, s.length());
        }
        s.append(')');
        return s.toString();
    }

    public int[] getArgNum() {
        int[] ret = new int[2];
        ArrayList<Value> arguments = getArgs();
        for (Value argument : arguments) {
            if (argument.getValueType().isFloat()) {
                ret[1]++;
            } else {
                ret[0]++;
            }
        }
        return ret;
    }
}

package ir;

import java.util.ArrayList;
import java.util.LinkedList;

/**
 @author Conroy
 编译单元 单例模式
 一个编译单元由若干个函数与全局变量组成
 parent->null,name->"Module",valueType->null
 */
public class Module extends Value{
    private static final Module module = new Module();

    // 这两个list是双向链表,用于存储函数与全局变量,是 module 的符号表
    private final LinkedList<Value> functions = new LinkedList<>();
    private final LinkedList<Value> globalVariables = new LinkedList<>();

    private Module() {
        super("Module", null, null);
    }
    public static Module getModule(){
        return module;
    }

    // 向 module 中加入函数
    public void addFunction(Function function){
        for (Value functionNode : functions){
            if (functionNode.equals(function)){
                throw new AssertionError("function is already in!");
            }
        }
        functions.add(function);
    }

    // 向 module 中加入全局变量
    public void addGlobalVariable(GlobalVariable globalVariable){
        for (Value globalVariableNode : globalVariables){
            if (globalVariableNode.equals(globalVariable)){
                throw new AssertionError("global variable is already in!");
            }
        }
        globalVariables.add(globalVariable);
    }

    // 这两个get...s()方法只能由后端调用
    public LinkedList<Value> getFunctions(){
        return functions;
    }

    public LinkedList<Value> getGlobalVariables(){
        return globalVariables;
    }

    public ArrayList<Function> getFunctionsArray(){
        ArrayList<Function> result = new ArrayList<>();
        for (Value functionNode : functions){
            result.add((Function) functionNode); // 强制转化不会出问题
        }
        return result;
    }

    public ArrayList<GlobalVariable> getGlobalVariablesArray(){
        ArrayList<GlobalVariable> result = new ArrayList<>();
        for (Value globalVariableNode : globalVariables){
            result.add((GlobalVariable) globalVariableNode); // 强制转化不会出问题
        }
        return result;
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder();
        for (Value globalVariableNode : globalVariables){
            GlobalVariable globalVariable = (GlobalVariable) globalVariableNode;
            s.append(globalVariable).append('\n');
        }
        if (!globalVariables.isEmpty()) {
            s.append('\n');
        }
        for (Value functionNode : functions){
            Function function = (Function)functionNode;
            s.append(function).append('\n');
        }
        return s.toString();
    }

}

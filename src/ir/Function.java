package ir;

import ir.types.DataType;
import ir.types.FunctionType;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
/**
 @author Conroy
 函数 包括 argument, basic block,有返回值的 instruction
 */
public class Function extends Value{
    // 运行时库函数
    public static Function getint = null;
    public static Function getch = null;
    public static Function getfloat = null;
    public static Function getarray = null;
    public static Function getfarray = null;
    public static Function putint = null;
    public static Function putch = null;
    public static Function putfloat = null;
    public static Function putarray = null;
    public static Function putfarray = null;
    public static Function putf = null;

    public static Function starttime = null;
    public static Function stoptime = null;

    // 处理循环垃圾,比如同一个基本块break或者continue后的指令就是循环垃圾,将它们全部插入到这个函数
    public static Function LOOP_TRASH = new Function();
    //是否是内建函数
    private final boolean isBuiltIn;
    // 函数的形参列表
    private final ArrayList<Argument> arguments = new ArrayList<>();
    // 函数返回类型
    private final DataType returnType;
    // 函数使用基本块
    private final LinkedList<Value> blocks = new LinkedList<>();
    // 存放 name-value 键值对, value 包括 argument, basic block,有返回值的 instruction
    public final HashMap<String, Value> valueSymbolTable = new HashMap<>();
    // 当一个函数向内存中写值的时候,就是有副作用的
    private boolean sideEffect = false;
    //调用图相关
    private final HashSet<Function> callers = new HashSet<>();

    public Function(String name, FunctionType functionType, boolean isBuiltIn){
        super("@" + name, functionType, Module.getModule());
        this.isBuiltIn = isBuiltIn;
        this.returnType = getValueType().getReturnType();
        for (int i = 0; i < getNumArgs(); i++){
            Argument argument = new Argument(i, functionType.getFormalArgs().get(i), this);
            arguments.add(argument);
            addFunctionSymbol(argument);
        }
    }

    // 为了解决 loop 的问题
    private Function(){
        super("@LOOP_TMP", null, null);
        isBuiltIn = true;
        returnType = null;
    }

    public boolean getIsBuiltIn(){
        return isBuiltIn;
    }

    public DataType getReturnType(){
        return returnType;
    }

    public ArrayList<Argument> getArguments(){
        return arguments;
    }

    public LinkedList<Value> getBasicBlocks(){
        return blocks;
    }

    // 用ArrayList形式返回基本块
    public ArrayList<BasicBlock> getBasicBlocksArray(){
        ArrayList<BasicBlock> result = new ArrayList<>();
        for (Value blockNode : blocks){
            BasicBlock block = (BasicBlock)blockNode;
            result.add(block);
        }
        return result;
    }

    // 函数开头基本块
    public BasicBlock getFirstBlock(){
        return (BasicBlock) blocks.get(0);
    }

    /**
     * @param value Argument | BasicBlock | Instruction(带返回值)
     */
    public void addFunctionSymbol(Value value){
        valueSymbolTable.put(value.getName(), value);
    }

    /**
     * 部分信息被转移到了 type 中, value 实体只保留一小部分信息
     * @return 参数个数
     */
    public int getNumArgs(){
        return getValueType().getFormalArgs().size();
    }

    @Override
    public FunctionType getValueType(){
        return (FunctionType) super.getValueType();
    }

    public void insertTail(BasicBlock block){
        blocks.add(block);
    }

    // 将 block 插入到 after 块的后面
    public void insertAfter(BasicBlock block, BasicBlock after){
        for( Value BasicBlockNode : blocks ){
            BasicBlock _block = (BasicBlock) BasicBlockNode;
            if( _block.equals(after) ){
                int index = blocks.indexOf(BasicBlockNode);
                blocks.add(index+1,block);
                return;
            }
        }
    }

    // 在 module 的符号表中删除自己
    public void eraseFromParent(){
        Module.getModule().getFunctions().remove(this);
    }

    // 删除特定的 basic block
    public void removeBlock(BasicBlock block){
        blocks.remove(block);
    }

    /**
     * 编译器可以假设标记为 dso_local 的函数或变量将解析为同一链接单元中的符号
     * 即使定义不在这个编译单元内,也会生成直接访问
     * @return 一个函数的 ir
     */
    @Override
    public String toString(){
        StringBuilder s = new StringBuilder(isBuiltIn ? "declare dso_local " : "define dso_local ");
        s.append(returnType).append(" ").append(getName()).append('(');
        for (Argument argument : arguments) {
            s.append(argument.getValueType()).append(" ").append(argument.getName()).append(", ");
        }
        if (!arguments.isEmpty()){
            s.delete(s.length() - 2, s.length()); // 删除多余 comma
        }
        s.append(")");
        if (!isBuiltIn) {
            s.append(" {\n");
            for (Value blockNode : blocks) {
                BasicBlock block = (BasicBlock) blockNode;
                s.append(block).append('\n');
            }
            s.append("}");
        }
        return s.toString();
    }

}

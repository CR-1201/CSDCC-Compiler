package ast;

import ir.Function;
import ir.Value;
import ir.types.*;

import java.io.PrintStream;
import java.util.ArrayList;

// TODO
//  CompUnit -> [ CompUnit ] ( Decl | FuncDef )
public class CompUnit extends Node{
    private CompUnit compUnit = null;
    private Decl decl = null;
    private MainFuncDef mainFuncDef = null;
    private FuncDef funcDef = null;
    public CompUnit(CompUnit compUnit, Decl decl) {
        this.compUnit = compUnit;
        this.decl = decl;
        childNode.add(decl);
        childNode.add(compUnit);
    }
    public CompUnit(CompUnit compUnit, FuncDef funcDef) {
        this.compUnit = compUnit;
        this.funcDef = funcDef;
        childNode.add(funcDef);
        childNode.add(compUnit);
    }
    public CompUnit( MainFuncDef mainFuncDef) {
        this.mainFuncDef = mainFuncDef;
        childNode.add(mainFuncDef);
    }

    // 遍历 AST 从而建立 ir tree
    // 需要加入运行时库函数,最后还是没有加入符号表,这依赖于程序是正确的
    // Attention : 所有子类都要重写这个方法,否则运行时库函数多次加入
    @Override
    public void buildIrTree() {
        if( buildInFlag == 1 ){
            buildInFlag = 0;
            /*================================ getint ================================*/
            Function.getint = builder.buildFunction("getint", new FunctionType(new ArrayList<>(), new IntType(32)), true);

            /*================================ getch ================================*/
            Function.getch = builder.buildFunction("getch", new FunctionType(new ArrayList<>(), new IntType(32)), true);

            /*================================ getfloat ================================*/
            Function.getfloat = builder.buildFunction("getfloat", new FunctionType(new ArrayList<>(), new FloatType()), true);

            /*================================ getarray ================================*/
            ArrayList<DataType> getarrayArgs = new ArrayList<>();
            getarrayArgs.add(new PointerType(new IntType(32)));
            Function.getarray = builder.buildFunction("getarray", new FunctionType(getarrayArgs, new IntType(32)), true);

            /*================================ getfarray ================================*/
            ArrayList<DataType> getfarrayArgs = new ArrayList<>();
            getfarrayArgs.add(new PointerType(new FloatType()));
            Function.getfarray = builder.buildFunction("getfarray", new FunctionType(getfarrayArgs, new IntType(32)), true);

            /*================================ putint ================================*/
            ArrayList<DataType> putintArgs = new ArrayList<>();
            putintArgs.add(new IntType(32));
            Function.putint = builder.buildFunction("putint", new FunctionType(putintArgs, new VoidType()), true);

            /*================================ putch ================================*/
            ArrayList<DataType> putchArgs = new ArrayList<>();
            putchArgs.add(new IntType(32));
            Function.putch = builder.buildFunction("putch", new FunctionType(putchArgs, new VoidType()), true);

            /*================================ putfloat ================================*/
            ArrayList<DataType> putfloatArgs = new ArrayList<>();
            putfloatArgs.add(new FloatType());
            Function.putfloat = builder.buildFunction("putfloat", new FunctionType(putfloatArgs, new VoidType()), true);

            /*================================ putarray ================================*/
            ArrayList<DataType> putarrayArgs = new ArrayList<>();
            putarrayArgs.add(new IntType(32));
            putarrayArgs.add(new PointerType(new IntType(32)));
            Function.putarray = builder.buildFunction("putarray", new FunctionType(putarrayArgs, new VoidType()), true);

            /*================================ putfarray ================================*/
            ArrayList<DataType> putfarrayArgs = new ArrayList<>();
            putfarrayArgs.add(new IntType(32));
            putfarrayArgs.add(new PointerType(new FloatType()));
            Function.putfarray = builder.buildFunction("putfarray", new FunctionType(putfarrayArgs, new VoidType()), true);

            /*================================ putstr ================================*/
            ArrayList<DataType> printfArgs = new ArrayList<>();
            printfArgs.add(new PointerType(new IntType(8)));
            Function.putstr = builder.buildFunction("putstr", new FunctionType(printfArgs, new VoidType()), true);

            /*================================ starttime ================================*/
            Function.starttime = builder.buildFunction("_sysy_starttime", new FunctionType(new ArrayList<>(), new VoidType()), true);

            /*================================ stoptime ================================*/
            Function.stoptime = builder.buildFunction("_sysy_stoptime", new FunctionType(new ArrayList<>(), new VoidType()), true);
        }
        for (Node node : childNode) {
            node.buildIrTree();
        }
    }


    @Override
    public void accept() {
        
    }
}


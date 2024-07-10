package ir;

import ast.Node;
import ir.constants.Constant;

import java.util.HashMap;

public class IrBuilder {
    // 唯一实例
    private static final IrBuilder irBuilder = new IrBuilder();
    // module 实例
    public final Module module = Module.getModule();
    // 一个起名计数器,对于 instruction 或者 BasicBlock 没有名字,需要用计数器取一个独一无二的名字
    private static int nameNumCounter = 0;
    private static int strNumCounter = 0;
    // 用于给 phi 一个名字,可以从 0 开始编号,因为 phi 一定是 %p1 之类的
    public static int phiNameNum = 0;
    // 全局变量查询表
    private static final HashMap<String, GlobalVariable> globalStrings = new HashMap<>();

    public static IrBuilder getIrBuilder(){
        return irBuilder;
    }
    // 遍历AST构建Ir tree
    public void buildModule(Node root) {
//        root.buildIrTree();
    }

    /**
     * 全局变量初始化的时候,一定是用常量初始化的
     * 建造一个全局变量,并将其加入 module
     * @param ident 标识符
     * @param initValue 初始值
     * @param isConst 是否是常量
     * @return 全局变量
     */
    public GlobalVariable buildGlobalVariable(String ident, Constant initValue, boolean isConst){
        GlobalVariable globalVariable = new GlobalVariable(ident, initValue, isConst);
        module.addGlobalVariable(globalVariable);
        return globalVariable;
    }

}

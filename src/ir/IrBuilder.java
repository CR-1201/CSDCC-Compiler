package ir;

import ast.CompUnit;
import ir.Module;
import ir.constants.ConstArray;
import ir.constants.ConstStr;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.*;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.DataType;
import ir.types.FunctionType;
import ir.types.ValueType;
import ir.types.VoidType;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

public class IrBuilder {
    // 唯一实例
    private static final IrBuilder irBuilder = new IrBuilder();
    // module 实例
    public final Module module = Module.getModule();
    // 一个起名计数器,对于 instruction 或者 BasicBlock 没有名字,需要用计数器取一个独一无二的名字
    public static int nameNumCounter = 0;
    private static int strNumCounter = 0;
    private static int blockNumCounter = 0;
    // 用于给 phi 一个名字,可以从 0 开始编号,因为 phi 一定是 %p1 之类的
    private static int phiNumCounter = 0;
    // 全局变量查询表
    private static final HashMap<String, GlobalVariable> globalStrings = new HashMap<>();

    public static IrBuilder getIrBuilder(){
        return irBuilder;
    }

    // 遍历AST构建Ir tree
    public void buildModule(CompUnit root) {
        root.buildIrTree();
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

    public GlobalVariable buildGlobalStr(ConstStr initValue){
        if (globalStrings.containsKey(initValue.getContent())){
            // 符号表里存在
            return globalStrings.get(initValue.getContent());
        }else{
            // 符号表里不存在
            GlobalVariable globalVariable = new GlobalVariable("Str" + strNumCounter++, initValue, true);
            module.addGlobalVariable(globalVariable);
            globalStrings.put(initValue.getContent(), globalVariable);
            return globalVariable;
        }
    }

    // 是否是内建函数
    public Function buildFunction(String ident, FunctionType type, boolean isBuiltIn){
        Function function = new Function(ident, type, isBuiltIn);
        module.addFunction(function);
        return function;
    }

    public BasicBlock buildBasicBlock(Function function){
        BasicBlock block = new BasicBlock(blockNumCounter++, function);
        function.insertTail(block);
        return block;
    }

    public BasicBlock buildBasicBLockAfter(Function function, BasicBlock after) {
        BasicBlock block = new BasicBlock(blockNumCounter++, function);
        function.insertAfter(block, after);
        return block;
    }

    public Add buildAdd(BasicBlock parent, DataType dataType, Value src1, Value src2){
        Add add = new Add(nameNumCounter++, dataType, parent, src1, src2);
        parent.insertTail(add);
        return add;
    }

    public Sub buildSub(BasicBlock parent, DataType dataType, Value src1, Value src2){
        Sub sub = new Sub(nameNumCounter++, dataType, parent, src1, src2);
        parent.insertTail(sub);
        return sub;
    }

    public Mul buildMul(BasicBlock parent, DataType dataType, Value src1, Value src2) {
        Mul mul = new Mul(nameNumCounter++, dataType, parent, src1, src2);
        parent.insertTail(mul);
        return mul;
    }

    public Mul buildMulBeforeInstr(BasicBlock parent, DataType dataType, Value src1, Value src2, Instruction before) {
        Mul mul = new Mul(nameNumCounter++, dataType, parent, src1, src2);
        parent.insertBefore(mul,before);
        return mul;
    }

    public Sdiv buildSdiv(BasicBlock parent, DataType dataType, Value src1, Value src2) {
        Sdiv sdiv = new Sdiv(nameNumCounter++, dataType, parent, src1, src2);
        parent.insertTail(sdiv);
        return sdiv;
    }

    public Srem buildSrem(BasicBlock parent, DataType dataType, Value src1, Value src2) {
        Srem srem = new Srem(nameNumCounter++, dataType, parent, src1, src2);
        parent.insertTail(srem);
        return srem;
    }

    public Icmp buildIcmp(BasicBlock parent, Icmp.Condition condition, Value src1, Value src2) {
        Icmp icmp = new Icmp(nameNumCounter++, parent, condition, src1, src2);
        parent.insertTail(icmp);
        return icmp;
    }

    public Zext buildZext(BasicBlock parent, Value value){
        Zext zext = new Zext(nameNumCounter++, parent, value);
        parent.insertTail(zext);
        return zext;
    }

    public Conversion buildConversion(BasicBlock parent, String type, DataType dataType, Value value){
        Conversion conversion = new Conversion(nameNumCounter++,type, dataType, parent, value);
        parent.insertTail(conversion);
        return conversion;
    }

    public Conversion buildConversionBeforeInstr(BasicBlock parent, String type, DataType dataType, Value value, Instruction before){
        Conversion conversion = new Conversion(nameNumCounter++,type, dataType, parent, value);
        parent.insertBefore(conversion, before);
        return conversion;
    }

    public BitCast buildBitCast(BasicBlock parent, DataType dataType, Value value){
        BitCast bitCast = new BitCast(nameNumCounter++, dataType, parent, value);
        parent.insertTail(bitCast);
        return bitCast;
    }

    /**
     * 为了方便 mem2reg 优化,约定所有的 Alloca 放到每个函数的入口块处
     * @param allocatedType alloca 空间的类型
     * @param parent 基本块
     * @return Alloca 指令
     */
    public Alloca buildALLOCA(ValueType allocatedType, BasicBlock parent){
//        System.out.println(parent.getParent());
        BasicBlock realParent = parent.getParent().getFirstBlock();
        Alloca alloca = new Alloca(nameNumCounter++, allocatedType, realParent);
        realParent.insertHead(alloca);
        return alloca;
    }

    public Alloca buildALLOCA(Alloca oldAlloca, BasicBlock parent){
        BasicBlock realParent = parent.getParent().getFirstBlock();
        Alloca alloca = new Alloca(oldAlloca.getName(), oldAlloca.getAllocatedType(), realParent);
        realParent.insertHead(alloca);
        return alloca;
    }
    /**
     * 为了方便 mem2reg 优化,约定所有的 Alloca 放到每个函数的入口块处
     * ConstAlloca 对应的是局部的常量数组的 Alloca 这种 Alloca 会多存储一个常量数组 ConstArray
     * 用于 a[constA[0]] 这种阴间情况,此时是没法用常量访存,其实还有很多情况,我之前使用的是 cannotCalDown 比较不本质
     * @param allocatedType alloca 空间的类型
     * @param parent 基本块
     * @return Alloca 指令
     */
    public Alloca buildALLOCA(ValueType allocatedType, BasicBlock parent, ConstArray initVal){
        BasicBlock realParent = parent.getParent().getFirstBlock();
        Alloca alloca = new Alloca(nameNumCounter++, allocatedType, realParent,initVal);
        realParent.insertHead(alloca);
        return alloca;
    }

    /**
     * 全新的 GEP 指令,可以允许变长的 index
     * @param parent 基本块
     * @param base 基地址（是一个指针）
     * @param index 变长索引
     * @return 一个新的指针
     */
    public GEP buildGEP(BasicBlock parent, Value base, Value... index) {
        int nameNum = nameNumCounter++;
        GEP gep;
        if (index.length == 1){
            gep = new GEP(nameNum, parent, base, index[0]);
        }else{
            gep = new GEP(nameNum, parent, base, index[0], index[1]);
        }
        parent.insertTail(gep);
        return gep;
    }

    /**
     * @param parent 基本块
     * @param content 存储内容
     * @param addr 地址
     */
    public void buildStore(BasicBlock parent, Value content, Value addr){
        Store store = new Store(parent, content, addr);
        parent.insertTail(store);
    }

    public void buildStoreBeforeInstr(BasicBlock parent, Value val, Value location, Instruction before){
        Store ans = new Store(parent, val, location);
        parent.insertBefore(ans, before);
    }

    public Load buildLoad(BasicBlock parent, Value addr){
        Load load = new Load(nameNumCounter++, parent, addr);
        parent.insertTail(load);
        return load;
    }

    public Ret buildRet(BasicBlock parent, Value... retValue){
        Ret ret;
        if (retValue.length == 0) {
            // 没有返回值
            ret = new Ret(parent);
        }else{
            ret = new Ret(parent, retValue[0]);
        }
        parent.insertTail(ret);
        return ret;
    }

    public Call buildCall(BasicBlock parent, Function function, ArrayList<Value> args){
        Call call;
        if (function.getReturnType() instanceof VoidType) {
            // 没有返回值
            call = new Call(parent, function, args);
            parent.insertTail(call);
        }else{
            call = new Call(nameNumCounter++, parent, function, args);
            parent.insertTail(call);
        }
        return call;
    }

    public void buildCallBeforeInstr(BasicBlock parent, Function function, ArrayList<Value> args, Instruction before){
        Call call;
        if (function.getReturnType() instanceof VoidType) {
            // 没有返回值
            call = new Call(parent, function, args);
            parent.insertBefore(call, before);
        }else{
            call = new Call(nameNumCounter++, parent, function, args);
            parent.insertBefore(call, before);
        }
    }

    public Br buildBr(BasicBlock parent, BasicBlock target){
        // 无条件跳转
        Br br = new Br(parent, target);
        parent.insertTail(br);
        return br;
    }

    public void buildBrBeforeInstr(BasicBlock parent, BasicBlock target, Instruction instruction) {
        Br br = new Br(parent, target);
        parent.insertBefore(br, instruction);
    }

    public Br buildBr(BasicBlock parent, Value condition, BasicBlock trueBlock, BasicBlock falseBlock){
        // 有条件跳转
        Br br = new Br(parent, condition, trueBlock, falseBlock);
        parent.insertTail(br);
        return br;
    }

    public Phi buildPhi(DataType type, BasicBlock parent){
        Phi phi = new Phi(phiNumCounter++, type, parent, parent.getPrecursors().size());
        parent.insertHead(phi);
        return phi;
    }

    public Phi buildPhi(BasicBlock parent) {
        Phi phi = new Phi(phiNumCounter++, null, parent, parent.getPrecursors().size());
        parent.insertHead(phi);
        return phi;
    }
    public Phi buildPhi(DataType type, BasicBlock parent, int cnt){
        Phi phi = new Phi(phiNumCounter++, type, parent, cnt);
        parent.insertHead(phi);
        return phi;
    }

    // ======================== Using for Clone ========================
    // 这里 Store 之所以分开写，是因为这里的 clonedStore 会返回 store 指令，但是之前的 buildStore 不会返回
    public Store cloneStore(BasicBlock parent, Value value, Value addr){
        Store store = new Store(parent, value, addr);
        parent.insertTail(store);
        return store;
    }
}

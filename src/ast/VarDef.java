package ast;

import ir.Function;
import ir.GlobalVariable;
import ir.Value;
import ir.constants.*;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.BitCast;
import ir.instructions.otherInstructions.Call;
import ir.types.*;
import token.Token;

import java.util.ArrayList;
import java.util.List;

// TODO
//  VarDef -> Ident { '[' ConstExp ']' } | Ident { '[' ConstExp ']' } '=' InitVal
public class VarDef extends Node{
    private Token identToken = null;
    private List<ConstExp> constExps = null;
    private InitVal initVal = null;

    private BType bType = null;
    private final ArrayList<Integer> dims = new ArrayList<>();

    public VarDef(Token identToken, List<ConstExp> constExps) {
        this.identToken = identToken;
        this.constExps = constExps;
        childNode.addAll(constExps);
    }

    public VarDef(Token identToken, List<ConstExp> constExps, InitVal initVal) {
        this.identToken = identToken;
        this.constExps = constExps;
        this.initVal = initVal;
        childNode.addAll(constExps);
        childNode.add(initVal);
    }

    public void setBType(BType bType) {
        this.bType = bType;
    }

    private void genSingleVar() {
        if (irSymbolTable.isGlobalLayer()) { // 全局单变量
            // 有初始值的全局单变量
            if (initVal != null) {
                globalInitDown = true;
                initVal.buildIrTree();
                globalInitDown = false;
                // "全局变量声明中指定的初值表达式必须是常量表达式",所以一定可以转为 ConstInt 或者 ConstFloat
                GlobalVariable globalVariable;
                Value temp = valueUp;
                if( (bType.getToken().getType() == Token.TokenType.INTTK) && valueUp instanceof ConstFloat ){
                    temp = new ConstInt((int)(((ConstFloat)valueUp).getValue()));
                } else if( (bType.getToken().getType() == Token.TokenType.FLOATTK) && valueUp instanceof ConstInt ){
                    temp = new ConstFloat((float) (((ConstInt)valueUp).getValue()));
                }
                if( temp instanceof ConstInt){
                    globalVariable = builder.buildGlobalVariable(identToken.getContent(), (ConstInt) temp, false);
                } else {
                    globalVariable = builder.buildGlobalVariable(identToken.getContent(), (ConstFloat) temp, false);
                }
                irSymbolTable.addValue(identToken.getContent(), globalVariable);
            } else { // 没有初始值的全局变量
                // "未显式初始化的全局变量, 其(元素)值均被初始化为 0 "
                Constant constant;
                if( bType.getToken().getType() == Token.TokenType.INTTK ){
                    constant = ConstInt.ZERO;
                } else constant = ConstFloat.ZERO;
                GlobalVariable globalVariable = builder.buildGlobalVariable(identToken.getContent(), constant, false);
                irSymbolTable.addValue(identToken.getContent(), globalVariable);
            }
        } else { // 局部单变量
            DataType dataType;

            if( bType.getToken().getType() == Token.TokenType.INTTK ){
                dataType = IntType.I32;
            } else dataType = new FloatType();
            Alloca alloca = builder.buildALLOCA(dataType, curBlock);

//            System.out.println(identToken.getContent());

            // 从这里可以看出,可以从符号表这种查询到的东西是一个指针,即 int*
            irSymbolTable.addValue(identToken.getContent(), alloca);
            if (initVal != null) {
                // "当不含有 '=' 和初始值时,其运行时实际初值未定义"
                initVal.buildIrTree();
                Value source = valueUp;
                if( ((PointerType) alloca.getValueType()).getPointeeType() instanceof IntType && source.getValueType() instanceof FloatType){
                    source = builder.buildConversion(curBlock,"fptosi",new IntType(32), source);
                } else if( ((PointerType) alloca.getValueType()).getPointeeType() instanceof FloatType && source.getValueType() instanceof IntType){
                    source = builder.buildConversion(curBlock,"sitofp",new FloatType(), source);
                }
                builder.buildStore(curBlock, source, alloca);
            }
        }
    }

    private void genVarArray() {
        // 解析维数 exp,然后存到 dim 中
        for (ConstExp constExp : constExps) {
            constExp.buildIrTree();
//            System.out.println(valueUp);
            // 维度一定是 int
            dims.add(((ConstInt) valueUp).getValue());
        }

        DataType dataType;
        if( bType.getToken().getType() == Token.TokenType.INTTK ){
            dataType = IntType.I32;
        } else dataType = new FloatType();

        ArrayType arrayType = new ArrayType(dataType, dims);

        // 全局数组 "全局变量声明中指定的初值表达式必须是常量表达式"
        if (irSymbolTable.isGlobalLayer()) {
            if (initVal != null) { // 全局有初始值的数组
//                System.out.println(dims);
                initVal.setDims(new ArrayList<>(dims));

                if(initVal.getInitVals().isEmpty()){
                    ZeroInitializer zeroInitializer = new ZeroInitializer(arrayType);
                    GlobalVariable globalVariable = builder.buildGlobalVariable(identToken.getContent(), zeroInitializer, false);
                    irSymbolTable.addValue(identToken.getContent(), globalVariable);
                } else {
                    globalInitDown = true;
                    initVal.buildIrTree();
                    globalInitDown = false;
                    genGlobalInitArray(valueArrayUp,arrayType);
                }
            } else { // 全局无初始值的数组,那么就初始化为 0
                ZeroInitializer zeroInitializer = new ZeroInitializer(arrayType);
                GlobalVariable globalVariable = builder.buildGlobalVariable(identToken.getContent(), zeroInitializer, false);
                irSymbolTable.addValue(identToken.getContent(), globalVariable);
            }
        } else { // 局部数组
            // 分配空间并登记
            Alloca allocArray = builder.buildALLOCA(arrayType, curBlock);
            irSymbolTable.addValue(identToken.getContent(), allocArray);

            // 有初始值的局部数组
            if (initVal != null) {
                initVal.setDims(new ArrayList<>(dims));
                initVal.buildIrTree();

                ArrayList<Instruction> initValInstructions = new ArrayList<>();

                GEP basePtr = builder.buildGEP(curBlock, allocArray, ConstInt.ZERO, ConstInt.ZERO);
                initValInstructions.add(basePtr);

                for( int i = 1; i < dims.size(); i++ ){
                    // 如果是一个多维数组,继续 GEP, basePtr会变成一个指向具体的 int 的指针,即 int*
                    // basePtr 是指向 allocArray 基地址的
                    basePtr = builder.buildGEP(curBlock, basePtr, ConstInt.ZERO, ConstInt.ZERO);
                    initValInstructions.add(basePtr);
                }

                ArrayList<Value> argList = new ArrayList<>();

                if( ((PointerType)(basePtr.getValueType())).getPointeeType() instanceof IntType ) {
                    argList.add(basePtr);
                } else {
                    BitCast bitCast = builder.buildBitCast(curBlock,new PointerType(new IntType(32)),basePtr);
                    argList.add(bitCast);
                }

                argList.add(new ConstInt(0));
                argList.add(new ConstInt(valueArrayUp.size()*4));


                Call call = builder.buildCall(curBlock, Function.memset, argList);
                initValInstructions.add(call);

                allocArray.setInitValues(valueArrayUp);
                // 利用 store 往内存中存值
                for (int i = 0; i < valueArrayUp.size(); i++){

                    Value source = valueArrayUp.get(i);

                    if( source instanceof ConstStr ) continue;

                    GEP curPtr = builder.buildGEP(curBlock, basePtr, new ConstInt(i));
                    initValInstructions.add(curPtr);

                    if( ((PointerType) curPtr.getValueType()).getPointeeType() instanceof IntType && source.getValueType() instanceof FloatType){
                        source = builder.buildConversion(curBlock,"fptosi",new IntType(32), source);
                        initValInstructions.add((Instruction) source);
                    } else if( ((PointerType) curPtr.getValueType()).getPointeeType() instanceof FloatType && source.getValueType() instanceof IntType){
                        source = builder.buildConversion(curBlock,"sitofp",new FloatType(), source);
                        initValInstructions.add((Instruction) source);
                    }

                    Store store = builder.buildStore(curBlock, source, curPtr);
                    initValInstructions.add(store);
                }

                allocArray.initInstructions = initValInstructions;
                allocArray.parentBlock = curBlock;
            }
        }
    }

    /**
     * 可以根据展平的初始化数组和 dims 来生成一个合乎常理的全局变量
     * @param flattenArray 展平数组
     */
    private void genGlobalInitArray(ArrayList<Value> flattenArray,ArrayType arrayType) {
//        System.out.println(flattenArray);
        boolean flag = true;

        for (Value value : flattenArray) {
            if (!((value instanceof ConstInt && value.equals(new ConstInt(0))) ||
                    (value instanceof ConstFloat && value.equals(new ConstFloat(0))))) {
                flag = false;
                break;
            }
        }

        if( flag ){
            ZeroInitializer zeroInitializer = new ZeroInitializer(arrayType);
            GlobalVariable globalVariable = builder.buildGlobalVariable(identToken.getContent(), zeroInitializer, false);
            irSymbolTable.addValue(identToken.getContent(), globalVariable);
            return;
        }

        if (dims.size() == 1) { // 一维数组,将 flattenArray 转变后加入即可
            ArrayList<Constant> constArray = new ArrayList<>();
            for (Value value : flattenArray) {
                if (value instanceof ConstInt) {
                    constArray.add((ConstInt) value);
                } else {
                    constArray.add((ConstFloat) value);
                }
            }
            ConstArray initArray = new ConstArray(constArray);
            GlobalVariable globalVariable = builder.buildGlobalVariable(identToken.getContent(), initArray, false);
            irSymbolTable.addValue(identToken.getContent(), globalVariable);
        } else { // 多维数组
            // 第一维的数组,其元素为 ConstArray

            ConstArray initArray = getArrayTree(flattenArray,0);
            GlobalVariable globalVariable = builder.buildGlobalVariable(identToken.getContent(), initArray, false);
            irSymbolTable.addValue(identToken.getContent(), globalVariable);
        }
    }

    private ConstArray getArrayTree(ArrayList<Value> flattenArray, int dim_level){
        ArrayList<Constant> temp = new ArrayList<>();
        if( dim_level >= dims.size()-1 ){
            for( int i = 0 ; i < dims.get(dim_level) ; i++ ){
                if( flattenArray.get(i) instanceof ConstInt ){
                    temp.add((ConstInt)flattenArray.get(i));
                } else temp.add((ConstFloat)flattenArray.get(i));
            }
        } else {
            int row_num = dims.get(dim_level);
            int column_num = 1;
            for( int i = dim_level+1 ; i < dims.size() ; i++ ){
                column_num *= dims.get(i);
            }
            for( int i = 0 ; i < row_num ; i++ ){
                ArrayList<Value> temp_flattenArray = new ArrayList<>();
                for( int j = 0 ; j < column_num ; j++ ){
                    Value temp_value = flattenArray.get(i*column_num+j);
                    temp_flattenArray.add(temp_value);
                }
                temp.add(getArrayTree(temp_flattenArray,dim_level+1));
            }
        }
        return new ConstArray(temp);
    }

    @Override
    public void buildIrTree() {
        if( initVal != null ){
            if( bType.getToken().getType() == Token.TokenType.INTTK ){
                initVal.setConstant(ConstInt.ZERO);
            } else initVal.setConstant(ConstFloat.ZERO);
        }

        if (constExps.isEmpty()) { // 单变量
            genSingleVar();
        } else { // 数组
            genVarArray();
        }
    }

    @Override
    public void accept() {

    }
}

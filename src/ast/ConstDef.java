package ast;


import ir.GlobalVariable;
import ir.Value;
import ir.constants.ConstArray;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Memory_Instructions.Alloca;
import ir.instructions.Memory_Instructions.GEP;
import ir.types.ArrayType;
import ir.types.DataType;
import ir.types.FloatType;
import ir.types.IntType;
import token.Token;

import java.util.ArrayList;
import java.util.List;

// TODO
//  ConstDef -> Ident { '[' ConstExp ']' } '=' ConstInitVal
public class ConstDef extends Node{
    private Token identToken;
    private List<ConstExp> constExps = null;
    private ConstInitVal constInitVal = null;

    Constant constant = ConstInt.ZERO;

    // 用于记录数组的维数,比如说 a[1][2] 的 dims 就是 {1, 2}
    private final ArrayList<Integer> dims = new ArrayList<>();

    public ConstDef(Token identToken, List<ConstExp> constExps, ConstInitVal constInitVal) {
        this.identToken = identToken;
        this.constExps = constExps;
        this.constInitVal = constInitVal;
        childNode.addAll(constExps);
        childNode.add(constInitVal);
    }

    public void setConstant(Constant constant){
        this.constant = constant;
    }

    @Override
    public void buildIrTree(){
        // 获得常量的名字
        String ident = identToken.getContent();

        constInitVal.setConstant(constant);
        // 单变量
        if (constExps.isEmpty()){
            constInitVal.buildIrTree();
            // 单变量是不算 GlobalVariable 的,没意义,只放在符号表中;常量在符号表中对应一个 ConstInt 值,哪怕是在局部,也是不分配栈上空间的
           irSymbolTable.addValue(ident, valueUp);
        } else { // 常量数组
            // 解析维数 exp,然后存到 dim 中
            for (ConstExp constExp : constExps){
                constExp.buildIrTree();
                dims.add(((ConstInt) valueUp).getValue());
            }

            // 方便对于 initValue 的分析
            constInitVal.setDims(dims);

            // 分析 initValue
            globalInitDown = true;
            constInitVal.buildIrTree();
            globalInitDown = false;

            // 如果是全局数组,那么是不需要 alloca 指令的,本质是其在静态区
            if( irSymbolTable.isGlobalLayer() ){
                GlobalVariable globalVariable = builder.buildGlobalVariable(ident, (Constant) valueUp, true);  // 加入全局变量
                // 登记到符号表中
                irSymbolTable.addValue(ident, globalVariable);
            } else { // 如果是局部数组
                // FIXME 判断是Int数组还是Float数组
                boolean isFloat = valueUp.getValueType() instanceof FloatType;
                DataType dataType = isFloat ? (new FloatType()) : (IntType.I32);

                // 根据维数信息创建数组标签,之前不用 是因为在 constInitVal 中递归生成了
                ArrayType arrayType = new ArrayType(dataType, dims);
                // alloca 的指针就是指向这个数组的指针
                Alloca allocArray = builder.buildALLOCA(arrayType , curBlock, (ConstArray) valueUp);
                // 登记符号表
                irSymbolTable.addValue(ident, allocArray);

                // 获得一个指针,这个指针指向初始化数组的一个元素
                GEP basePtr = builder.buildGEP(curBlock, allocArray, ConstInt.ZERO, ConstInt.ZERO);

                for( int i = 1; i < dims.size(); i++ ){
                    // 如果是一个多维数组,继续 GEP,basePtr会变成一个指向具体的 int 的指针,即 int*
                    // basePtr 是指向 allocArray 基地址的
                    basePtr = builder.buildGEP(curBlock, basePtr, ConstInt.ZERO, ConstInt.ZERO);
                }

                // 利用 store 往内存中存值
                for (int i = 0; i < valueArrayUp.size(); i++){
                    if (i == 0){
                        builder.buildStore(curBlock,valueArrayUp.get(i), basePtr);
                    }else{
                        // 这里利用的是一维的 GEP,此时的返回值依然是 int*; 变长索引,依次赋值,其实可以不用 if-else
                        GEP curPtr = builder.buildGEP(curBlock, basePtr, new ConstInt(i));
                        builder.buildStore(curBlock, valueArrayUp.get(i), curPtr);
                    }
                }
            }

        }
    }

    @Override
    public void accept() {

    }
}

package ast;

import ir.GlobalVariable;
import ir.Value;
import ir.constants.ConstArray;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Memory_Instructions.Alloca;
import ir.types.*;
import token.Token;

import java.util.List;

// TODO
//  LVal -> Ident {'[' Exp ']'}
public class LVal extends Node{
    private Token identToken = null;
    private List<Exp> exps = null;

    public LVal(Token identToken, List<Exp> exps) {
        this.identToken = identToken;
        this.exps = exps;
        childNode.addAll(exps);
    }


    /**
     * 左值是直接返回指针的,而不是返回指针指向的内容
     * 应当由更高层次的语法树（PrimaryExpNode）决定是否加载
     * 左值指向的内容有 3 种类型:
     * 整型: 十分显然
     * 指针: 至于为什么会有这么个东西,可以这样举例,比如说 f(int a[])
     * 当我们对 a 进行 buildIr 的时候, a 的类型是 i32*
     * 然后我们为了 SSA（主要是为了整型形参,指针形参属于受害者） ,所以在函数一开始做了一个 alloca-store 操作
     * 那么在之后,我们看 a,就变成了一个 (i32*)*,也就是 lVal 指向一个指针的情况
     * 对于这种情况,我们首先用 load 将其指针去掉一层,目前 a 的类型就和 C 语言一致了,所以对它的一维访存,就是 GEP一个 index
     * 对于二维访存,就是 GEP 两个 index
     * 数组: 后面有写
     */
    @Override
    public void buildIrTree() {
        String name = identToken.getContent();
        Value lVal = irSymbolTable.searchValue(name);

        // 说明 lVal 是一个常量,直接返回就好了
        if (lVal.getValueType() instanceof IntType || lVal.getValueType() instanceof FloatType) {
            valueUp = lVal;
        } else {
            // lVal 的类型是一个 PointerType,说明 lVal 指向的是一个局部变量或者全局变量
            // lVal 指向的数据类型
            ValueType type = ((PointerType) lVal.getValueType()).getPointeeType();

            // 三个 boolean 指示了全局变量或者局部变量的类型
            boolean isInt =  type instanceof IntType || type instanceof FloatType;
            boolean isPointer = type instanceof PointerType;
            boolean isArray = type instanceof ArrayType;

            if (isInt) { // eg :  全局变量 b = c;
                // 如果是全局变量的指针,那么在可以计算的情况下,就需要直接把这个量访存出来
                if (canCalValueDown && lVal instanceof GlobalVariable) {
                    if(((GlobalVariable) lVal).getInitVal() instanceof ConstInt initVal){
                        valueUp = new ConstInt(initVal.getValue());
                    } else {
                        ConstFloat initVal = (ConstFloat) ((GlobalVariable) lVal).getInitVal();
                        valueUp = new ConstFloat(initVal.getValue());
                    }
                } else { // eg :  int a = 5;  a = 6;
                    // 可以看到,左值是直接返回指针的,而不是返回指针指向的内容,应当由更高层次的语法树决定是否加载
                    valueUp = lVal;
                }
            } else if (isPointer) {
                // 指向的局部变量是一个指针eg:f(a[]) 也就是 f( i32* %0 )在 builder 形参的时候,会出现指针指向指针的情况

                // 这里存着实际的指针
                Value ptr = builder.buildLoad(curBlock, lVal);

                // FIXME 这里估计有bug
                if (exps.isEmpty()) {
                    // 没有索引, 因为 Sysy 中没有指针运算, 只能被用当成子函数的实参
                    valueUp = ptr;
                } else {
                    for (Exp exp : exps) {
                        exp.buildIrTree();
                        // 根据索引获得一个指针,要维持原有指针的类型
                        ptr = builder.buildGEP(curBlock, ptr, valueUp);
                        if (((PointerType) ptr.getValueType()).getPointeeType() instanceof ArrayType) {
                            ptr = builder.buildGEP(curBlock, ptr, ConstInt.ZERO, ConstInt.ZERO);
                        }
                    }
                    valueUp = ptr;
                }
            } else if (isArray) {
                // 是一个局部数组或者全局数组

                // 当可计算且是一个全局变量的时候, 直接将其算出来, 而不用 GEP 去做
                if (canCalValueDown && lVal instanceof GlobalVariable){
                    Constant initVal = ((GlobalVariable) lVal).getInitVal();
                    for (Exp exp : exps) {
                        exp.buildIrTree();
                        initVal = ((ConstArray) initVal).getElementByIndex(((ConstInt)valueUp).getValue());
                    }
                    valueUp = initVal;
                } else if( canCalValueDown && lVal instanceof Alloca){
                    // 对于局部常量数组的常量式访问(比如说 用于初始化其他常量,用来当某数组的维度等,不用 gep 访存)
                    Constant initVal = ((Alloca) lVal).getInitVal();
                    for (Exp exp : exps) {
                        exp.buildIrTree();
                        initVal = ((ConstArray) initVal).getElementByIndex(((ConstInt)valueUp).getValue());
                    }
                    valueUp = initVal;
                } else {
                    Value ptr = lVal;
                    for (Exp exp : exps) {
                        exp.buildIrTree();
                        ptr = builder.buildGEP(curBlock, ptr, ConstInt.ZERO, valueUp);
                    }
                    // 当一个数组符号经过了中括号的运算后,依然指向一个数组,那么说明这个 lVal 一定是指针实参
                    // 否则如果整型实参,这里一定指向的是 Int 或者 float,但是由于 llvm ir 的数组的指针是高一级的,比如说
                    // int a[2] 在 C 中,a 是指向 int 的指针,而在 llvm ir 中是指向 2 x int 的指针,所以要降级
                    // 至于为啥要降级, 对于 int a[4][5] = ...; a[2] 可能作为函数 f(b[]) 的实参
                    if (((PointerType) ptr.getValueType()).getPointeeType() instanceof ArrayType) {
                        ptr = builder.buildGEP(curBlock, ptr, ConstInt.ZERO, ConstInt.ZERO);
                    }
                    valueUp = ptr;
                }

            }

        }
    }

    @Override
    public void accept() {

    }
}

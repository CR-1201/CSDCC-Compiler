package ast;

import ir.BasicBlock;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.*;
import token.Token;

import java.util.ArrayList;

// TODO
// FuncDef -> FuncType Ident '(' [FuncFParams] ')' Block
public class FuncDef extends Node{
    private FuncType funcType = null;
    private Token identToken = null;
    private FuncFParams funcFParams = null;
    private Block block = null;
    public FuncDef(FuncType funcType, Token identToken, FuncFParams funcFParams, Block block) {
        this.identToken = identToken;
        this.funcType = funcType;
        this.funcFParams = funcFParams;
        this.block = block;
        childNode.add(funcType);
        childNode.add((funcFParams));
        childNode.add((block));
    }

    @Override
    public void buildIrTree() {
        // 函数名
        String funcName = identToken.getContent();

        // 获取函数返回类型
        DataType returnType;
        if( funcType.getType().getType() == Token.TokenType.VOIDTK ){
            returnType = new VoidType();
        } else if( funcType.getType().getType() == Token.TokenType.INTTK ){
            returnType = new IntType(32);
        } else {
            returnType = new FloatType();
        }

        // 此处这是 buildFunc,但是为了 SSA 特性,之后还需要再次遍历 funcFParams 来为形参分配空间
        ArrayList<DataType> argsType = new ArrayList<>();
        if (funcFParams != null) {
            funcFParams.buildIrTree();
            argsType.addAll(argTypeArrayUp);
        }

        // build function object
        curFunc = builder.buildFunction(funcName, new FunctionType(argsType, returnType), false);
        // add to symbol table
        irSymbolTable.addValue(funcName, curFunc);

        // 在 entryBlock 加入函数的形参
        BasicBlock entryBlock = builder.buildBasicBlock(curFunc);
        // 进入一个函数,就会加一层
        irSymbolTable.pushFuncLayer();
        // 将函数的形参放到 block 中,将对 Function 的 arg 的初始化 delay 到 visit(ctx.block)
        curBlock = entryBlock;
        // 如果参数列表不为空,说明是需要参数 alloc 的
        if (funcFParams != null) {
            funcFParams.buildFParamsSSA();
        }
        irSymbolTable.pushBlockLayer();
        block.setReturnType(returnType);
        // 建立函数体
        block.buildIrTree();
        irSymbolTable.popBlockLayer();

        // 在解析完了函数后,开始处理善后工作
        // 如果没有默认的 return 语句 (语义正确保证了结尾有一个 return 语句)
        Instruction tailInstr = curBlock.getTailInstruction();
        // 结尾没有指令或者指令不是跳转指令, null 指令被包含了
        if (!(tailInstr instanceof Ret || tailInstr instanceof Br)) {
            if (curFunc.getReturnType() instanceof VoidType) {
                builder.buildRet(curBlock);
            } else {
                builder.buildRet(curBlock, ConstInt.ZERO);
            }
        }
        irSymbolTable.popFuncLayer();
    }

    @Override
    public void accept() {

    }
}

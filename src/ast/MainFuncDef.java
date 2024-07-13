package ast;

import ir.BasicBlock;
import ir.Function;
import ir.Value;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.DataType;
import ir.types.FunctionType;
import ir.types.IntType;

import java.util.ArrayList;

//TODO
// MainFuncDef -> 'int' 'main' '(' ')' Block
public class MainFuncDef extends Node{
    private Block block = null;
    public MainFuncDef(Block block){
        this.block = block;
        childNode.add(block);
    }


    @Override
    public void buildIrTree() {
        String funcName = "main";
        DataType returnType = new IntType(32);

        // 此处这是 buildFunc,但是为了 SSA 特性,之后还需要再次遍历 funcFParams 来为形参分配空间
        ArrayList<DataType> argsType = new ArrayList<>();
        curFunc = builder.buildFunction(funcName, new FunctionType(argsType, returnType), false);

        irSymbolTable.addValue(funcName, curFunc);
        BasicBlock entryBlock = builder.buildBasicBlock(curFunc);
        // 进入一个函数,就会加一层
        irSymbolTable.pushFuncLayer();
        curBlock = entryBlock;
        // 建立函数体
        block.buildIrTree();
        // 在解析完了函数后,开始处理善后工作, 如果没有默认的 return 语句
        Instruction tailInstr = curBlock.getTailInstruction();
        // 结尾没有指令或者指令不是跳转指令,null 指令被包含了
        if (!(tailInstr instanceof Ret || tailInstr instanceof Br)) {
            builder.buildRet(curBlock, ConstInt.ZERO);
        } else {
            // TODO 输出main函数return的值,为了评测使用
            // 实参表
            ArrayList<Value> argList = new ArrayList<>();
            argList.add(tailInstr);
            builder.buildCall(curBlock, Function.putint, argList);
        }
        irSymbolTable.popFuncLayer();
    }

    @Override
    public void accept() {

    }
}

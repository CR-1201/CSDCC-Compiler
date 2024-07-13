package ast;

import ir.BasicBlock;
import ir.Function;
import ir.Value;
import ir.constants.ConstInt;
import ir.constants.ConstStr;
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
        BasicBlock tempBlock = (lastBasicBlockUp != null) ? (BasicBlock) lastBasicBlockUp : curBlock;

        Instruction tailInstr = tempBlock.getTailInstruction();
        // 结尾没有指令或者指令不是跳转指令
        if (!(tailInstr instanceof Ret || tailInstr instanceof Br)) {
            builder.buildRet(tempBlock, ConstInt.ZERO);
            Instruction nowTailInstr = tempBlock.getTailInstruction();
            ArrayList<Value> argList = new ArrayList<>();
            argList.add(ConstInt.ZERO);
            builder.buildCallBeforeInstr(tempBlock, Function.putint, argList, nowTailInstr);
        } else {
            // TODO 输出main函数return的值,为了评测使用
            // 实参表
            ArrayList<Value> argList = new ArrayList<>();
            ArrayList<Value> charN = new ArrayList<>();
            charN.add(new ConstInt(10));
            if(tailInstr.getValue(0).getValueType() instanceof IntType){
                argList.add(tailInstr.getValue(0));
            } else {
                Instruction returnNUM = builder.buildConversionBeforeInstr(tempBlock,"fptosi",new IntType(32), tailInstr.getValue(0),tailInstr);
                argList.add(returnNUM);
            }
            builder.buildCallBeforeInstr(tempBlock, Function.putch, charN, tailInstr);
            builder.buildCallBeforeInstr(tempBlock, Function.putint, argList, tailInstr);

        }

        irSymbolTable.popFuncLayer();
    }

    @Override
    public void accept() {

    }
}

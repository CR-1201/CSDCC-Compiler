package ir.instructions;

import ir.BasicBlock;
import ir.User;
import ir.Value;
import ir.types.DataType;

import java.util.ArrayList;

/**
 @author Conroy
 一切 llvm ir 指令的父类
 会使用 value 作为操作数
 指令的 parent 是 BasicBlock
 */
public class Instruction extends User {
   /**
    * @param name     指令名称,不是指 "add" "sub"之类的名称,而是指令返回值存放的虚拟寄存器
    *                 eg: %3 = add i32 %1, %2 名称为 "%3"
    *                 store i32 %1, i32* %2 名称为 "",因为没有用虚拟寄存器
    * @param dataType 指令返回值类型,为 DataType,包括 PointerType,VoidType,IntType
    * @param parent   指令所在基本块
    * @param ops      指令的操作数列表,放在values数组中,从0号位置一次排列. values 数组定义在 user 中
    */
    public Instruction(String name, DataType dataType, BasicBlock parent, ArrayList<Value> ops) {
        super(name, dataType, parent, ops);
        if (!name.isEmpty()) {
            parent.getParent().addFunctionSymbol(this);
        }
    }

    // 在 parent block 中删除自己
    public void eraseFromParent(){
        getParent().removeInstruction(this);
    }

    public void removeSelf() {
        removeAllOperators();
        eraseFromParent();
    }

    public void move2Block(BasicBlock target) {
        eraseFromParent();
        target.insertTail(this);
        this.setParent(target);
    }

    @Override
    public BasicBlock getParent(){
        return (BasicBlock) super.getParent();
    }
}

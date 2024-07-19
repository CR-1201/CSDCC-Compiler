package ir.instructions.binaryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;

/**
 @author Conroy
 有左右2个操作数,分别放在 values 列表的 0 号与 1 号位
 操作数可以为常数,也可以为指令
 */
public abstract class BinaryInstruction extends Instruction {
    /**
     * @param nameNum 指令名称中的数字,eg: 名称为 %1 的指令的 nameNum 为 1
     * @param op1     第一个操作数
     * @param op2     第二个操作数
     */
    BinaryInstruction(int nameNum, DataType dataType, BasicBlock parent, Value op1, Value op2) {
        super("%v" + nameNum, dataType, parent, new ArrayList<>(){{
            add(op1);add(op2);
        }});
    }

    public Value getOp1(){
        return getOperator(0);
    }

    public Value getOp2(){
        return getOperator(1);
    }

    //操作数 op1 和op2 是不是可交换的
    public abstract boolean isCommutative();
    public String getOpString() {
        return "binary";
    }
    /**
     * 两个指令是否是相同的运算符
     * @param instr1 指令 1
     * @param instr2 指令 2
     * @return 是则为 true
     */
    public static boolean isSameOp(BinaryInstruction instr1, BinaryInstruction instr2){
        boolean isSame = false;
        if (instr1 instanceof Add && instr2 instanceof Add) isSame = true;
        else if (instr1 instanceof Sub && instr2 instanceof Sub) isSame = true;
        else if (instr1 instanceof Mul && instr2 instanceof Mul) isSame = true;
        else if (instr1 instanceof Sdiv && instr2 instanceof Sdiv) isSame = true;
        else if (instr1 instanceof Srem && instr2 instanceof Srem) isSame = true;
        else if (instr1 instanceof Icmp cmp_1 && instr2 instanceof Icmp cmp_2){
            isSame =  cmp_1.getCondition().equals(cmp_2.getCondition());
        }
        return isSame;
    }
}

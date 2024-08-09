package ir.instructions.binaryInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.types.DataType;

import java.util.ArrayList;

/**
 @author Conroy
 */
public abstract class BinaryInstruction extends Instruction {

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

    /**
     * Binary Instruction 的两个操作数中，只有一个操作数是常数，另一个是变量
     */
    public Boolean with1Const() {
        boolean isLeftConst = getOp1() instanceof Constant;
        boolean isRightConst = getOp2() instanceof Constant;
        return (isLeftConst && !isRightConst) || (!isLeftConst && isRightConst);
    }
}

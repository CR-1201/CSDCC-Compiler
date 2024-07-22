package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.otherInstructions.Conversion;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.otherInstructions.Zext;
import ir.instructions.terminatorInstructions.Br;
import ir.types.FloatType;
import ir.types.IntType;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import pass.Pass;
import utils.Pair;
import utils.ValueStatus;

/**
 @author Conroy
 稀疏条件常量传播(Sparse Conditional Constant Propagation)
 这种常数传播方法相对传统方法有两个主要的优点:它可以由条件推导出有关信息,并且也更为有效.
 */

public class SCCP implements Pass {

    private final Module module = Module.getModule();
    // 指令的状态图
    private HashMap<Value, ValueStatus> valueMap = new HashMap<>();
    // 已经遍历过的边
    private HashSet<Pair<BasicBlock,BasicBlock>> marked = new HashSet<>();
    // 意味着 bb 由 pre_bb 可达
    private ArrayList<Pair<BasicBlock,BasicBlock>> CFGWorkList = new ArrayList<>();
    // 需要重新计算状态的指令
    private ArrayList<Instruction> SSAWorkList = new ArrayList<>();

    ValueStatus prevStatus;
    ValueStatus curStatus;

    BasicBlock curBasicBlock;
    Instruction curInstruction;


    @Override
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn())  {
                visitFunc(function);
            }
        }
    }

    private void visitFunc(Function function) {
        // 初始只标记入口基本块可达
        CFGWorkList.add(new Pair<>(null,function.getFirstBlock()));

        // 初始化为TOP状态; 这里需要注意, 函数参数和全局变量默认应该是 BOT 状态
        for(BasicBlock block : function.getBasicBlocksArray()){
            for( Instruction instruction : block.getInstructionsArray()){
                valueMap.put(instruction,new ValueStatus(ValueStatus.Status.Top, instruction));
            }
        }
        // 维护两个队列
        int i = 0, j = 0;
        while( i < CFGWorkList.size() || j < SSAWorkList.size()){
            while(i < CFGWorkList.size()){
                Pair<BasicBlock,BasicBlock> pair = CFGWorkList.get(i++);

                // 每条边只用遍历一遍,只有新增边才会触发遍历基本块全部指令
                if( marked.contains(pair) ){
                    continue;
                }
                marked.add(pair);

                BasicBlock block = pair.getSecond();
                for( Instruction instruction : block.getInstructionsArray()){
                    visitInstruction(instruction);
                }
            }

//            System.out.println(SSAWorkList.size());

            while(j < SSAWorkList.size()){
                Instruction instruction = SSAWorkList.get(j++);
                BasicBlock block = instruction.getParent();
                // 只有指令可达,才需要遍历;否则可能引发不必要的状态更新
                if( block.getPrecursors().isEmpty() ){
                    visitInstruction(instruction);
                } else {
                    for( BasicBlock preBlock : block.getPrecursors() ){
                        if( marked.contains(new Pair<>(preBlock,block)) ){
                            visitInstruction(instruction);
                        }
                    }
                }
            }
        }
        // 收尾工作, 所有 CONST 状态的指令都替换为常数
        // 并且对于条件为常量的条件跳转指令,改写为无条件跳转
        // 这一改写主要是方便后续其他优化
        replaceConstant(function);
    }

    private void visitInstruction(Instruction instruction) {
        curInstruction = instruction;
        curBasicBlock = instruction.getParent();
        prevStatus = valueMap.get(instruction);
        if( prevStatus == null ){
            prevStatus = new ValueStatus(ValueStatus.Status.Top,instruction);
        }
        curStatus = new ValueStatus(prevStatus.getStatus(),instruction);

        if( instruction instanceof Phi phi){
//            System.out.println(phi);
            visitPHI(phi);
        } else if( instruction instanceof Br br){
            visitBr(br);
        } else if( instruction instanceof BinaryInstruction || instruction instanceof Zext || instruction instanceof Conversion ){
            visitFold(instruction);
        } else {
            curStatus.setStatus(ValueStatus.Status.BOT);
        }

        if( curStatus.notEqual(prevStatus) ){
            // 更新指令状态
            valueMap.put(instruction,curStatus);
            for( User use : instruction.getUsers() ){
                if( use instanceof Instruction ){
//                    System.out.println(use);
                    SSAWorkList.add((Instruction)use);
                }
            }
            if( curStatus.getStatus() == ValueStatus.Status.CONST ){
                instruction.replaceAllUsesWith(curStatus.getValue());
                instruction.eraseFromParent();
            }

        }
    }

    private void replaceConstant(Function function) {
        ArrayList<BasicBlock> BasicBlocks = function.getBasicBlocksArray();
        // cond_br with const cond
        for( BasicBlock basicBlock : BasicBlocks ){
            Instruction tailInstr = basicBlock.getTailInstruction();
            if( tailInstr instanceof Br br && br.getHasCondition() ){
                Value cond = br.getOperator(0);
                if( cond instanceof Constant ){
                    BasicBlock trueBlock = (BasicBlock)(br.getOperator(1));
                    BasicBlock falseBlock = (BasicBlock)(br.getOperator(2));
                    if( cond instanceof ConstInt ){
                        int x = ((ConstInt)cond).getValue();
                        if( x != 0 ){
                            condBrToJump(br,trueBlock,falseBlock);
                        } else condBrToJump(br,falseBlock,trueBlock);
                    } else if( cond instanceof ConstFloat ){
                        float x = ((ConstFloat)cond).getValue();
                        if( x != 0 ){
                            condBrToJump(br,trueBlock,falseBlock);
                        } else condBrToJump(br,falseBlock,trueBlock);
                    }
                }
            }
        }
    }

    private void condBrToJump(Br br, BasicBlock jumpBlock, BasicBlock invalidBlock) {
        BasicBlock block = br.getParent();
        br.removeAllOperators();
        br.setHasCondition(false);
        br.addOperator(jumpBlock);
        jumpBlock.addUser(br);
        valueMap.put(br,curStatus);
//        System.out.println(br);
        if( !jumpBlock.equals(invalidBlock) ){
            block.removeSuccessor(invalidBlock);
            invalidBlock.removePrecursor(block);
            deletePhiValue(block,invalidBlock);
        }
    }

    private void deletePhiValue(BasicBlock curBlock, BasicBlock nextBlock) {
        ArrayList<Instruction> instructions = nextBlock.getInstructionsArray();
        for( Instruction instruction : instructions ){
            if( instruction instanceof Phi phi){
                if( phi.getOperators().contains(curBlock)){
                    phi.removeUsedBlock(curBlock);
                }
            }
        }
    }

    private void visitPHI(Phi phi) {
        int phiSize = phi.getNumOfOps() / 2;
        for( int i = 0; i < phiSize; i++ ){
            BasicBlock prevBlock = (BasicBlock) (phi.getOperator(phiSize+i));
            if( marked.contains(new Pair<>(prevBlock,curBasicBlock)) ){
                Value op = phi.getOperator(i);
                ValueStatus opStatus = valueMap.get(op);
                if( opStatus != null ){
                    curStatus.xor(opStatus);
                }
            }
        }
    }

    private void visitBr(Br br){
//        System.out.println(br);
        // 无条件跳转 换成jump
        if(!br.getHasCondition()){
            BasicBlock jump_block = (BasicBlock)(br.getOperator(0));
            CFGWorkList.add(new Pair<>(curBasicBlock,jump_block));
        } else {
            BasicBlock trueBlock = (BasicBlock)(br.getOperator(1));
            BasicBlock falseBlock = (BasicBlock)(br.getOperator(2));

            if( valueMap.get(br.getOperator(0)) != null ){
                Value cond = valueMap.get(br.getOperator(0)).getValue();
                if( cond instanceof ConstInt){
                    CFGWorkList.add(new Pair<>(curBasicBlock, ((ConstInt) cond).getValue() != 0 ? trueBlock : falseBlock));
                } else if( cond instanceof ConstFloat ){
                    CFGWorkList.add(new Pair<>(curBasicBlock, ((ConstFloat) cond).getValue() != 0 ? trueBlock : falseBlock));
                } else {
                    CFGWorkList.add(new Pair<>(curBasicBlock, trueBlock));
                    CFGWorkList.add(new Pair<>(curBasicBlock, falseBlock));
                }
            } else {
                CFGWorkList.add(new Pair<>(curBasicBlock, trueBlock));
                CFGWorkList.add(new Pair<>(curBasicBlock, falseBlock));
            }
        }
    }

    private void visitFold(Instruction instruction) {
        Constant floded = constFlod(instruction);
        if( floded != null ){
            curStatus.setStatus(ValueStatus.Status.CONST);
            curStatus.setValue(floded);
        } else {
//            curStatus.setStatus(ValueStatus.Status.Top);
            for( Value op : instruction.getOperators() ){
                if( valueMap.containsKey(op) && valueMap.get(op).isBot() ){
                    curStatus.setStatus(ValueStatus.Status.BOT);
                    break;
                }
            }
        }
    }

    private Constant constFlod( Instruction instruction) {
        if( instruction instanceof BinaryInstruction ){
            Value value1 = ((BinaryInstruction) instruction).getOp1();
            Value value2 = ((BinaryInstruction) instruction).getOp2();
            if( valueMap.containsKey(value1) && valueMap.containsKey(value2) ){
                Value v1 = valueMap.get(value1).getValue();
                Value v2 = valueMap.get(value2).getValue();
                if( v1 instanceof Constant && v2 instanceof Constant ){
                    return constFlod((BinaryInstruction)instruction,(Constant) v1,(Constant) v2);
                }
            } else if( value1 instanceof Constant && value2 instanceof Constant ){
                return constFlod((BinaryInstruction)instruction,(Constant) value1,(Constant) value2);
            }
        } else if( instruction instanceof Zext zext){
            Value value = zext.getOperator(0);
            if( valueMap.containsKey(value)){
                Value v = valueMap.get(value).getValue();
                if( v instanceof Constant ){
                    return constFlod(instruction,(Constant) v);
                }
            } else if( value instanceof Constant ){
                return constFlod(instruction,(Constant) value);
            }
        } else if( instruction instanceof Conversion conversion){
            Value value = conversion.getOperator(0);
            if( valueMap.containsKey(value)){
                Value v = valueMap.get(value).getValue();
                if( v instanceof Constant ){
                    return constFlod(instruction,(Constant) v);
                }
            } else if( value instanceof Constant ){
                return constFlod(instruction,(Constant) value);
            }
        }
        return null;
    }

    private Constant constFlod(Instruction instruction, Constant v) {
        if( instruction instanceof Zext ){
            if( v instanceof ConstInt ){
                return new ConstInt(((ConstInt)v).getValue());
            }
        } else if(instruction instanceof Conversion conv){
            if( conv.getType().equals("fptosi") ){
                return new ConstInt((int) ((ConstFloat)v).getValue());
            } else if( conv.getType().equals("sitofp") ){
                return new ConstFloat((float) ((ConstInt)v).getValue());
            }
        }
        return null;
    }

    private Constant constFlod( BinaryInstruction instruction, Constant v1, Constant v2) {
        if(instruction instanceof Add add){
            if( add.getValueType() instanceof FloatType ){
                return new ConstFloat(((ConstFloat)v1).getValue() + ((ConstFloat)v2).getValue());
            } else if( add.getValueType() instanceof IntType){
                return new ConstInt(((ConstInt)v1).getValue() + ((ConstInt)v2).getValue());
            }
        } else if(instruction instanceof Sub sub){
            if( sub.getValueType() instanceof FloatType ){
                return new ConstFloat(((ConstFloat)v1).getValue() - ((ConstFloat)v2).getValue());
            } else if( sub.getValueType() instanceof IntType){
                return new ConstInt(((ConstInt)v1).getValue() - ((ConstInt)v2).getValue());
            }
        } else if(instruction instanceof Mul mul){
            if( mul.getValueType() instanceof FloatType ){
                return new ConstFloat(((ConstFloat)v1).getValue() * ((ConstFloat)v2).getValue());
            } else if( mul.getValueType() instanceof IntType){
                return new ConstInt(((ConstInt)v1).getValue() * ((ConstInt)v2).getValue());
            }
        } else if(instruction instanceof Sdiv div){
            if( div.getValueType() instanceof FloatType ){
                return new ConstFloat(((ConstFloat)v1).getValue() / ((ConstFloat)v2).getValue());
            } else if( div.getValueType() instanceof IntType){
                return new ConstInt(((ConstInt)v1).getValue() / ((ConstInt)v2).getValue());
            }
        } else if(instruction instanceof Srem srem){
            if( srem.getValueType() instanceof FloatType ){
                return new ConstFloat(((ConstFloat)v1).getValue() % ((ConstFloat)v2).getValue());
            } else if( srem.getValueType() instanceof IntType){
                return new ConstInt(((ConstInt)v1).getValue() % ((ConstInt)v2).getValue());
            }
        } else if(instruction instanceof Icmp cmp){
            return constFlod(cmp,v1,v2);
        }
        return null;
    }

    private Constant constFlod(Icmp cmp, Constant v1, Constant v2) {
        Icmp.Condition condition = cmp.getCondition();
        boolean flag = (v1.getValueType() instanceof FloatType);
        switch (condition){
            case EQ -> {
                if(flag){
                    return new ConstInt(i1toi32(((ConstFloat)v1).getValue() == ((ConstFloat)v2).getValue()));
                } else return new ConstInt(i1toi32(((ConstInt)v1).getValue() == ((ConstInt)v2).getValue()));
            }
            case GE -> {
                if(flag){
                    return new ConstInt(i1toi32(((ConstFloat)v1).getValue() >= ((ConstFloat)v2).getValue()));
                } else return new ConstInt(i1toi32(((ConstInt)v1).getValue() >= ((ConstInt)v2).getValue()));
            }
            case GT -> {
                if(flag){
                    return new ConstInt(i1toi32(((ConstFloat)v1).getValue() > ((ConstFloat)v2).getValue()));
                } else return new ConstInt(i1toi32(((ConstInt)v1).getValue() > ((ConstInt)v2).getValue()));
            }
            case LE -> {
                if(flag){
                    return new ConstInt(i1toi32(((ConstFloat)v1).getValue() <= ((ConstFloat)v2).getValue()));
                } else return new ConstInt(i1toi32(((ConstInt)v1).getValue() <= ((ConstInt)v2).getValue()));
            }
            case LT -> {
                if(flag){
                    return new ConstInt(i1toi32(((ConstFloat)v1).getValue() < ((ConstFloat)v2).getValue()));
                } else return new ConstInt(i1toi32(((ConstInt)v1).getValue() < ((ConstInt)v2).getValue()));
            }
            case NE -> {
                if(flag){
                    return new ConstInt(i1toi32(((ConstFloat)v1).getValue() != ((ConstFloat)v2).getValue()));
                } else return new ConstInt(i1toi32(((ConstInt)v1).getValue() != ((ConstInt)v2).getValue()));
            }
            default -> {
                return null;
            }
        }
    }

    private int i1toi32(boolean flag){
        if(flag){
            return 1;
        } else return 0;
    }
}

package pass.transform.gcmgvn;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.otherInstructions.Zext;
import ir.types.PointerType;
import pass.analysis.Dom;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;

public class GCM {
    private final Module module = Module.getModule();

    private final HashSet<Instruction> visited = new HashSet<>();

    // 是否可以 promote
    private boolean isPinned(Instruction instruction) {
        return !(instruction instanceof BinaryInstruction) &&
                !(instruction instanceof Zext) &&
                !(instruction instanceof Conversion) &&
                !(instruction instanceof GEP) &&
                !(instruction instanceof Call && isPure((Call) instruction));
    }

    public void run(){
        ArrayList<Function> functions = module.getFunctionsArray();
        for(Function function : functions ){
            if (!function.getIsBuiltIn() && function.getBasicBlocksArray().size() > 1 )  {
                functionGCM(function);
            }
        }
    }

    private void functionGCM(Function function) {
        visited.clear();
        // 逆后续遍历
        ArrayList<BasicBlock> reversePostOrder = Dom.getDomTreePostOrder(function);
        Collections.reverse(reversePostOrder);

        ArrayList<Instruction> instructions = new ArrayList<>();
        // GCM 中只考虑 value dependency,不考虑基本块
        for( BasicBlock basicBlock : reversePostOrder){
            instructions.addAll(basicBlock.getInstructions());
        }

        for(Instruction instruction : instructions){
            scheduleEarly(instruction, function);
        }

        // 清空遍历集
        visited.clear();
        Collections.reverse(instructions);
        for(Instruction instruction : instructions){
            scheduleLate(instruction);
        }
    }

    // Schedule early 算法需要将指令移动到被所有操作数所支配的最浅基本块
    private void scheduleEarly(Instruction inst, Function function) {
        // visited或pinned, return即可
        if (visited.contains(inst) || isPinned(inst)) {
            return;
        }
        // 标记已经处理了
        visited.add(inst);

        // 初始移动到入口块的最后一条指令前 入口块的domLV最小
        BasicBlock entry = function.getFirstBlock();
        inst.eraseFromParent();
        entry.insertBefore(inst, entry.getTailInstruction());
        inst.setParent(entry);

        for(Value value : inst.getOperators()) {
            if(value instanceof Instruction operator) {
                scheduleEarly(operator, function);
                if(inst.getParent().getDomLevel() < operator.getParent().getDomLevel()){
                    // 将指令插在操作数(operator)所在基本块的最后一条指令的前面
                    inst.eraseFromParent();
                    operator.getParent().insertBefore(inst, operator.getParent().getTailInstruction());
                    inst.setParent(operator.getParent());
                }
            }
        }
    }

    private void scheduleLate(Instruction inst) {
        if (visited.contains(inst) || isPinned(inst)) {
            return;
        }
        visited.add(inst);
        // 所有user共同的祖先
        BasicBlock LCABasicBlock = null;

        for (User user : inst.getUsers()) {
            if (user instanceof Instruction userInst){
                scheduleLate(userInst);
                BasicBlock useBasicblock;

                if (userInst instanceof Phi phi){
                    // 遍历 phi 指令的所有输入
                    for (int j = 0; j < phi.getPrecursorNum(); j++ ){
                        Value value = phi.getOperator(j);
                        if (value instanceof Instruction && value.equals(inst)){
                            useBasicblock = (BasicBlock) userInst.getOperator(j + phi.getPrecursorNum());
//                             useBasicblock = userInst.getParent().getPrecursors().get(j);
                            LCABasicBlock = findLCA(LCABasicBlock, useBasicblock);
                        }
                    }
                } else { // 对于非 phi 指令
                    useBasicblock = userInst.getParent();
                    LCABasicBlock = findLCA(LCABasicBlock, useBasicblock);
                }

            }
        }

        // 寻找一个最终位置
        if(!inst.getUsers().isEmpty()) {
            assert LCABasicBlock != null;
            BasicBlock finalBasicBlock = LCABasicBlock;

            while (!LCABasicBlock.equals(inst.getParent())) {
                LCABasicBlock = LCABasicBlock.getIDomer();
                if(LCABasicBlock.getLoopDepth() < finalBasicBlock.getLoopDepth() ) {
                    finalBasicBlock = LCABasicBlock;
                }
            }

            // finalBasicBlock 是最后插入的块
            inst.eraseFromParent();
            finalBasicBlock.insertBefore(inst, finalBasicBlock.getTailInstruction());
            inst.setParent(finalBasicBlock);
        }

        BasicBlock finalBasicBlock = inst.getParent();
        // 遍历最终插入的块的指令
        ArrayList<Instruction> instructions = finalBasicBlock.getInstructionsArray();
        for (Instruction instruction : instructions){
            if (!instruction.equals(inst)) {
                if (!(instruction instanceof Phi) && instruction.getOperators().contains(inst)){
                    inst.eraseFromParent();
                    finalBasicBlock.insertBefore(inst, instruction);
                    inst.setParent(finalBasicBlock);
                }
            }
        }
    }

    private BasicBlock findLCA(BasicBlock a, BasicBlock b) {
        if (a == null)
            return b;
        while (a.getDomLevel() < b.getDomLevel()){
            b = b.getIDomer();
        }
        while (b.getDomLevel() < a.getDomLevel()){
            a = a.getIDomer();
        }
        while (!a.equals(b)){
            a = a.getIDomer();
            b = b.getIDomer();
        }
        return a;
    }

    // 像运算符一样简单的 call 指令才可以提升
    private boolean isPure(Call call) {
        Function target = call.getFunction();
        // 有副作用的不行
        if (target.getSideEffect()) {
            return false;
        }
        if (call.getUsers().isEmpty()) {
            return false;
        }
        // 遍历实参
        for (Value input : call.getOperators()) {
            // 参数是一个简单的单变量才行
            if (input instanceof GEP || input instanceof Load || input.getValueType() instanceof PointerType) {
                return false;
            }
        }
        return true;
    }
}

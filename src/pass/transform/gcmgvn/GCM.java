package pass.transform.gcmgvn;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;

public class GCM {
    private final Module module = Module.getModule();
    Dom dom = new Dom();

    private final HashSet<Instruction> visited = new HashSet<>();
    LoopAnalysis loopAnalysis = new LoopAnalysis();

    // 是否是被 Pin 住的指令
    private boolean isPinnedInst(Instruction inst) {
        return inst instanceof Br || inst instanceof Phi
                || inst instanceof Ret || inst instanceof Store
                || inst instanceof Load || inst instanceof Call;
    }

    public void run(){
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions ){
            if (!function.getIsBuiltIn() && function.getBasicBlocksArray().size() > 1)  {
                loopAnalysis.analyzeLoopInfo(function);
                runGCM(function);
            }
        }
    }

    private void runGCM(Function function) {
        visited.clear();
        ArrayList<BasicBlock> reversePostOrder = dom.getDomTreePostOrder(function);
        Collections.reverse(reversePostOrder);
        ArrayList<Instruction> instructions = new ArrayList<>();
        for (BasicBlock basicBlock : reversePostOrder){
            instructions.addAll(basicBlock.getInstructionsArray());
        }
        for (Instruction instruction : instructions){
            if (isPinnedInst(instruction)){
                visited.add(instruction);
            } else {
                scheduleEarly(instruction, function);
            }
        }
        visited.clear();
        Collections.reverse(instructions);
        for (Instruction instruction : instructions){
            if (isPinnedInst(instruction)) {
                visited.add(instruction);
            } else {
                scheduleLate(instruction);
            }
        }
    }

    private void scheduleEarly(Instruction inst, Function function) {
        if (visited.contains(inst) || isPinnedInst(inst)) {
            return;
        }
        visited.add(inst);
        BasicBlock entry = function.getFirstBlock();
        inst.eraseFromParent();
        entry.insertBefore(inst, entry.getTailInstruction());

        for (Value value : inst.getOperators()) {
            if (value instanceof Instruction operator) {
                scheduleEarly(operator, function);
                if (inst.getParent().getDomLevel() < operator.getParent().getDomLevel()){
                    inst.eraseFromParent();
                    operator.getParent().insertBefore(inst, operator.getParent().getTailInstruction());
                }
            }
        }
    }

    private void scheduleLate(Instruction inst) {
        if (visited.contains(inst) || isPinnedInst(inst)) {
            return;
        }
        visited.add(inst);
        BasicBlock lca = null;
        for (User user : inst.getUsers()) {
            if (user instanceof Instruction userInst) {
                scheduleLate(userInst);
                BasicBlock userbb = userInst.getParent();
                if (userInst instanceof Phi phi) {
                    for (int i = 0; i < phi.getPrecursorNum(); i++){
                        Value value = phi.getOperator(i);
                        if (value instanceof Instruction && value.equals(inst)){
                            userbb = (BasicBlock) userInst.getOperator(i + phi.getPrecursorNum());
                            lca = findLca(lca, userbb);
                        }
                    }
                } else {
                    lca = findLca(lca, userbb);
                }
            }
        }
        if (!inst.getUsers().isEmpty()) {
            BasicBlock bestBB = lca;
            BasicBlock curBB = lca;
            while (curBB != inst.getParent()) {
                curBB = curBB.getIDomer();
                if (curBB.getLoopDepth() < bestBB.getLoopDepth()) {
                    bestBB = curBB;
                }
            }
            inst.eraseFromParent();
            bestBB.insertBefore(inst, bestBB.getTailInstruction());
        }
        BasicBlock bestBB = inst.getParent();
        ArrayList<Instruction> instructions = bestBB.getInstructionsArray();
        for (Instruction instruction : instructions){
            if (instruction != inst) {
                if (!(instruction instanceof Phi) && instruction.getOperators().contains(inst)){
                    inst.eraseFromParent();
                    bestBB.insertBefore(inst, instruction);
                    break;
                }
            }
        }
    }

    private BasicBlock findLca(BasicBlock a, BasicBlock b) {
        if (a == null)
            return b;
        while (a.getDomLevel() < b.getDomLevel()) {
            b = b.getIDomer();
        }
        while (b.getDomLevel() < a.getDomLevel()) {
            a = a.getIDomer();
        }
        while (a != b) {
            a = a.getIDomer();
            b = b.getIDomer();
        }
        return a;
    }
}

package pass.transform.gcmgvn;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;

public class GCM {

    private final Module module = Module.getModule();

    private final HashMap<Function, HashSet<Instruction>> pinned = new HashMap<>();
    private final HashMap<BasicBlock,Instruction> insertPosition = new HashMap<>();

    private HashSet<Instruction> visited = new HashSet<>();
    private BasicBlock root;

    // 是否是被 Pin 住的指令
    private boolean isPinnedInst(Instruction inst) {
        return inst instanceof Br || inst instanceof Ret
                || inst instanceof Store || inst instanceof Load
                || inst instanceof Phi || inst instanceof Call;
    }

    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        init();
        for (Function function : functions) {
            if (!function.getIsBuiltIn()) {
                scheduleEarlyForFunction(function);
            }
        }
        for (Function function : functions) {
            if (!function.getIsBuiltIn()) {
                scheduleLateForFunction(function);
            }
        }
        codeMotion();
    }

    private void init() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            // 寻找所有被 Pinned 住的指令
            HashSet<Instruction> pinnedInsts = new HashSet<>();
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if (isPinnedInst(instruction)) {
                        pinnedInsts.add(instruction);
                    }
                }
                insertPosition.put(block, block.getTailInstruction());
            }
            pinned.put(function, pinnedInsts);
        }
    }

    private void scheduleEarlyForFunction(Function function) {
        HashSet<Instruction> pinnedInsts = pinned.get(function);
        visited = new HashSet<>();
        root = function.getFirstBlock();
        for (Instruction instruction : pinnedInsts) {
            instruction.setEarliestBlock(instruction.getParent());
            visited.add(instruction);
        }
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if (!visited.contains(instruction)) {
                    scheduleEarly(instruction);
                } else if (pinnedInsts.contains(instruction)) {
                    for (Value value : instruction.getOperators()) {
                        if (value instanceof Instruction instr) {
                            scheduleEarly(instr);
                        }
                    }
                }
            }
        }
    }

    private void scheduleEarly(Instruction instruction) {
        if (visited.contains(instruction)){
            return;
        }
        visited.add(instruction);
        instruction.setEarliestBlock(root);
        for (Value value : instruction.getOperators()) {
            if (value instanceof Instruction operator) {
                scheduleEarly(operator);
                if (instruction.getEarliestBlock().getDomLevel() < operator.getEarliestBlock().getDomLevel()) {
                    instruction.setEarliestBlock(operator.getEarliestBlock());
                }
            }
        }
    }

    private void scheduleLateForFunction(Function function) {
        HashSet<Instruction> pinnedInstructions = pinned.get(function);
        visited = new HashSet<>();
        for (Instruction instruction : pinnedInstructions) {
            instruction.setLatestBlock(instruction.getParent());
            visited.add(instruction);
        }
        for (Instruction instruction : pinnedInstructions) {
            for (Value value : instruction.getUsers()) {
                if (value instanceof Instruction instr) {
                    scheduleLate(instr);
                }
            }
        }
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            // 倒序遍历
            Collections.reverse(instructions);
            for (Instruction instruction : instructions) {
                if (!visited.contains(instruction)) {
                    scheduleLate(instruction);
                }
            }
        }
    }

    private void scheduleLate(Instruction inst) {
        if (inst.getUsers().isEmpty()) {
            return;
        }
        if (visited.contains(inst)) {
            return;
        }
        visited.add(inst);
        BasicBlock lca = null;
        for (Value user : inst.getUsers()) {
            if (user instanceof Instruction instr) {
                scheduleLate(instr);
                BasicBlock usedBlock = instr.getLatestBlock();
                if (instr instanceof Phi phi) {
                    for (int i = 0; i < phi.getPrecursorNum(); i++){
                        Value value = phi.getOperator(i);
                        if (value instanceof Instruction && value.equals(inst)){
                            usedBlock = (BasicBlock) phi.getOperator(i + phi.getPrecursorNum());
                            lca = findLCA(lca, usedBlock);
                            break;
                        }
                    }
                } else {
                    lca = findLCA(lca, usedBlock);
                }
            }
        }
        BasicBlock best = lca;
        assert lca != null;
        while (!lca.equals(inst.getEarliestBlock())) {
            if (lca.getLoopDepth() < best.getLoopDepth()) {
                best = lca;
            }
            lca = lca.getIDomer();
            assert lca != null;
        }
        if (lca.getLoopDepth() < best.getLoopDepth()) {
            best = lca;
        }
        inst.setLatestBlock(best);
        if (!inst.getLatestBlock().equals(inst.getParent())) {
            inst.eraseFromParent();
            BasicBlock block = inst.getLatestBlock();
            Instruction pos = findInsertPosition(inst,block);
            block.insertBefore(inst,pos);
        }
    }

    private Instruction findInsertPosition(Instruction instr, BasicBlock block) {
        ArrayList<Value> users = new ArrayList<>(instr.getUsers());
        Instruction later = null;
        ArrayList<Instruction> instructions = block.getInstructionsArray();
        for (Instruction pos : instructions ){
            if (pos instanceof Phi) {
                continue;
            }
            if (users.contains(pos)) {
                later = pos;
                break;
            }
        }
        if (later != null) {
            return later;
        } else {
            return block.getTailInstruction();
        }
    }

    private void codeMotion() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions ){
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if (!instruction.getLatestBlock().equals(block)) {
                        instruction.eraseFromParent();
                        BasicBlock basicBlock = instruction.getLatestBlock();
                        Instruction pos = findInsertPosition(instruction,basicBlock);
                        basicBlock.insertBefore(instruction,pos);
                    }
                }
            }
        }
    }

    private BasicBlock findLCA(BasicBlock a, BasicBlock b) {
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

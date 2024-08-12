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
import pass.Pass;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;

public class newGCM{

    private final Module module = Module.getModule();

    private HashMap<Function, HashSet<Instruction>> pinned = new HashMap<>();
    private HashMap<BasicBlock,Instruction> insertPos = new HashMap<>();

    private HashSet<Instruction> visited = new HashSet<>();
    private BasicBlock root;

    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        init();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            scheduleEarlyOnFunc(function);
        }
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            scheduleLateOnFunc(function);
        }
        move();
    }

    private void init() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            HashSet<Instruction> pinnedInstructions = new HashSet<>();

            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( isPinnedInst(instruction) ){
                        pinnedInstructions.add(instruction);
                    }
                }
                insertPos.put(block,block.getTailInstruction());
            }
            pinned.put(function,pinnedInstructions);
        }
    }

    private void scheduleEarlyOnFunc(Function function) {
        HashSet<Instruction> pinnedInstructions = pinned.get(function);
        visited = new HashSet<>();
        root = function.getFirstBlock();

        for (Instruction instruction : pinnedInstructions) {
            instruction.setEarliestBlock(instruction.getParent());
            visited.add(instruction);
        }

        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( !visited.contains(instruction) ){
                    scheduleEarly(instruction);
                } else if( pinnedInstructions.contains(instruction) ){
                    for(Value value : instruction.getOperators() ){
                        if( value instanceof Instruction instr ){
                            scheduleEarly(instr);
                        }
                    }
                }
            }
        }
    }

    private void scheduleEarly(Instruction instruction) {
        if( visited.contains(instruction) ){
            return;
        }
        visited.add(instruction);
        instruction.setEarliestBlock(root);
        for (Value value : instruction.getOperators()) {
            if( value instanceof Instruction operator ){
                scheduleEarly(operator);
                if (instruction.getEarliestBlock().getDomLevel() < operator.getEarliestBlock().getDomLevel()){
                    instruction.setEarliestBlock(operator.getEarliestBlock());
                }
            }
        }
    }

    private void scheduleLateOnFunc(Function function) {
        HashSet<Instruction> pinnedInstructions = pinned.get(function);
        visited = new HashSet<>();
        for (Instruction instruction : pinnedInstructions) {
            instruction.setLatestBlock(instruction.getParent());
            visited.add(instruction);
        }

        for (Instruction instruction : pinnedInstructions) {
            for( Value value : instruction.getUsers() ){
                if( value instanceof Instruction instr ){
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
                if( !visited.contains(instruction) ){
                    scheduleLate(instruction);
                }
            }
        }
    }

    private void scheduleLate(Instruction instruction) {
        if( instruction.getUsers().isEmpty() )return;

        if( visited.contains(instruction) ){
            return;
        }
        visited.add(instruction);
        BasicBlock LCA = null;
        for( Value user : instruction.getUsers() ){
            if( user instanceof Instruction instr ){

                scheduleLate(instr);
                BasicBlock use = instr.getLatestBlock();
                if( instr instanceof Phi phi ){
                    for (int i = 0; i < phi.getPrecursorNum(); i++){
                        Value value = phi.getOperator(i);
                        if (value instanceof Instruction && value.equals(instruction)){
                            use = (BasicBlock) phi.getOperator(i + phi.getPrecursorNum());
                            LCA = findLCA(LCA, use);
                            break;
                        }
                    }
                } else LCA = findLCA(LCA, use);
            }
        }

        BasicBlock best = LCA;
        assert LCA != null;

        while (!LCA.equals(instruction.getEarliestBlock())){
            if( LCA.getLoopDepth() < best.getLoopDepth() ){
                best = LCA;
            }
            LCA = LCA.getIDomer();
            assert LCA != null;
        }
        if( LCA.getLoopDepth() < best.getLoopDepth() ){
            best = LCA;
        }
        instruction.setLatestBlock(best);

        if( !instruction.getLatestBlock().equals(instruction.getParent()) ){
            instruction.eraseFromParent();
            BasicBlock block = instruction.getLatestBlock();
            Instruction pos = findInsertPos(instruction,block);
            block.insertBefore(instruction,pos);
        }
    }

    private Instruction findInsertPos( Instruction instr, BasicBlock block ){
        ArrayList<Value> users = new ArrayList<>(instr.getUsers());
        Instruction later = null;
        ArrayList<Instruction> instructions = block.getInstructionsArray();
        for (Instruction pos : instructions ){
            if( pos instanceof Phi ) continue;
            if( users.contains(pos) ){
                later = pos;
                break;
            }
        }

        if( later != null ){
            return later;
        } else return block.getTailInstruction();
    }

    private void move() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions ){
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for( BasicBlock block : blocks ){
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for( Instruction instruction : instructions ){
                    if( !instruction.getLatestBlock().equals(block) ){
                        instruction.eraseFromParent();
                        BasicBlock basicBlock = instruction.getLatestBlock();
                        Instruction pos = findInsertPos(instruction,basicBlock);
                        basicBlock.insertBefore(instruction,pos);
                    }
                }
            }
        }
    }

    // 是否是被 Pin 住的指令
    private boolean isPinnedInst(Instruction inst) {
        return inst instanceof Br || inst instanceof Phi
                || inst instanceof Ret || inst instanceof Store
                || inst instanceof Load || inst instanceof Call;
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

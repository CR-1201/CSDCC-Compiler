package pass.transform;

import ir.*;
import ir.constants.Constant;
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

public class ArrayGVNGCM implements Pass {

    private HashSet<Instruction> pinned;
    private HashMap<BasicBlock,Instruction> insertPos;

    private static HashSet<Instruction> know;
    private BasicBlock root;

    HashMap<String,Instruction> GVNMap = new HashMap<>();
    HashMap<String, Integer> GVNCount = new HashMap<>();
    private Function function;
    private HashSet<Instruction> canGVNGCM;


    public ArrayGVNGCM(Function function, HashSet<Instruction> canGVNGCM) {
        this.function = function;
        this.pinned = new HashSet<>();
        this.insertPos = new HashMap<>();
        this.canGVNGCM = canGVNGCM;
    }

    @Override
    public void run() {
        Init();
        runGVN();
        runGCM();
    }

    private void Init() {
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock basicBlock : blocks) {
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( isPinned(instruction) ){
                    pinned.add(instruction);
                }
            }
            insertPos.put(basicBlock,basicBlock.getTailInstruction());
        }
    }

    private void runGVN() {
        GVNMap.clear();
        GVNCount.clear();
        GlobalArrayGVN();
    }

    private void runGCM() {
        scheduleEarlyForFunction();
        scheduleLateForFunction();
        finalMove();
    }

    private void scheduleEarlyForFunction() {
        know = new HashSet<>();
        root = function.getFirstBlock();
        for( Instruction instruction : pinned ){
            instruction.setEarliestBlock(instruction.getParent());
            know.add(instruction);
        }

        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock basicBlock : blocks) {
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( !know.contains(instruction) ){
                    scheduleEarly(instruction);
                } else if( pinned.contains(instruction) ){
                    for( Value value : instruction.getOperators() ){
                        if( value instanceof Constant || value instanceof BasicBlock || value instanceof GlobalVariable
                           || value instanceof Function || value instanceof Argument ){
                            continue;
                        }
                        assert value instanceof Instruction;
                        scheduleEarly((Instruction)value);
                    }
                }
            }
        }
    }

    private void scheduleEarly(Instruction instruction) {
        if( know.contains(instruction) ){
            return;
        }
        know.add(instruction);
        instruction.setEarliestBlock(root);
        for( Value value : instruction.getOperators() ){
            if( value instanceof Instruction instr){
                scheduleEarly(instr);
                if( instruction.getEarliestBlock().getDomLevel() < instruction.getEarliestBlock().getDomLevel() ){
                    instruction.setEarliestBlock(instr.getEarliestBlock());
                }
            }
        }
    }

    private void scheduleLateForFunction() {
        know.clear();
        for( Instruction instruction : pinned ){
            instruction.setLatestBlock(instruction.getParent());
            know.add(instruction);
        }
        for( Instruction instruction : pinned ){
            for( User user : instruction.getUsers() ){
                if( user instanceof Instruction instr ){
                    scheduleLate(instr);
                }
            }
        }
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock basicBlock : blocks) {
            ArrayList<Instruction> instructions = new ArrayList<>(basicBlock.getInstructionsArray());
            Collections.reverse(instructions);
            for( Instruction instruction : instructions ){
                if( !know.contains(instruction) ){
                    scheduleLate(instruction);
                }
            }
        }
    }

    private void scheduleLate(Instruction instruction) {
        if( know.contains(instruction) ){
            return;
        }
        know.add(instruction);
        BasicBlock LCA = null;
        for( User user : instruction.getUsers() ){
            if( user instanceof Instruction instr ){
                scheduleLate(instr);

                BasicBlock use = instr.getLatestBlock();
                if( instr instanceof Phi phi ){
                    for (int i = 0; i < phi.getPrecursorNum(); i++){
                        Value value = phi.getOperator(i);
                        if (value instanceof Instruction && value.equals(instruction)){
                            use = (BasicBlock) instr.getOperator(i + phi.getPrecursorNum());
                            LCA = findLca(LCA, use);
                        }
                    }
                } else {
                    LCA = findLca(LCA, use);
                }
            }
        }

        BasicBlock best = LCA;
        if( LCA == null ){
            System.err.println("ERROR ARRAY GCM!");
            assert true;
        }

        if (LCA != null) {
            while( !LCA.equals(instruction.getEarliestBlock()) ){
                if( LCA.getLoopDepth() < best.getLoopDepth() ){
                    best = LCA;
                }
                LCA = LCA.getIDomer();
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

    private BasicBlock findLca( BasicBlock a, BasicBlock b ){
        if( a == null ) return b;

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

    private void GlobalArrayGVN() {
        BasicBlock basicBlock = function.getFirstBlock();
        RPOSearch(basicBlock);
    }

    private void RPOSearch(BasicBlock basicBlock) {
          HashSet<Instruction> loads = new HashSet<>();
          ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
          for (Instruction instruction : instructions) {
              if( canGVNGCM.contains(instruction) ){
                  if( !addLoadToGVN(instruction) ){
                      loads.add(instruction);
                  }
              }
          }

          HashSet<BasicBlock> blocks = basicBlock.getIdoms();
          for (BasicBlock next : blocks) {
              RPOSearch(next);
          }

          for( Instruction instruction : loads ){
              removeLoadFromGVN(instruction);
          }
    }

    private void removeLoadFromGVN(Instruction instruction) {
        if( instruction instanceof Load load ){
            String hash = load.getAddr().getName();
            remove(hash);
        }
    }

    private boolean addLoadToGVN(Instruction instruction) {
        if( !(instruction instanceof Load load) ){
            return true;
        }
        String hash = load.getAddr().getName();
        if( GVNMap.containsKey(hash) ){
            load.replaceAllUsesWith(GVNMap.get(hash));
            load.removeSelf();
            return true;
        }
        add(hash,load);
        return false;
    }

    private void add(String hash,Instruction instruction) {
        if( !GVNCount.containsKey(hash) ){
            GVNCount.put(hash,1);
        } else {
            GVNCount.put(hash,GVNCount.get(hash)+1);
        }
        if( !GVNMap.containsKey(hash) ){
            GVNMap.put(hash,instruction);
        }
    }

    private void remove(String hash) {
        GVNCount.put(hash,GVNCount.get(hash)-1);
        if( GVNCount.get(hash) == 0 ){
            GVNCount.remove(hash);
            GVNMap.remove(hash);
        }
    }

    private void finalMove(){
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

    private boolean isPinned(Instruction instruction) {
        if( canGVNGCM.contains(instruction) ){
            return true;
        }
        return instruction instanceof Br || instruction instanceof Ret || instruction instanceof Phi
                || instruction instanceof Store || instruction instanceof Load || instruction instanceof Call;
    }
}

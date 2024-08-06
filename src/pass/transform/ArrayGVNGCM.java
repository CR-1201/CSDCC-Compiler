package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import pass.Pass;

import java.util.ArrayList;
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
        scheduleEarly();
    }

    private void scheduleEarly() {
        know = new HashSet<>();
        root = function.getFirstBlock();
        for( Instruction instruction : pinned ){

        }
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

    private boolean isPinned(Instruction instruction) {
        if( canGVNGCM.contains(instruction) ){
            return true;
        }
        return instruction instanceof Br || instruction instanceof Ret || instruction instanceof Phi
                || instruction instanceof Store || instruction instanceof Load || instruction instanceof Call;
    }
}

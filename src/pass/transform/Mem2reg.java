package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Phi;
import ir.types.DataType;
import ir.types.IntType;
import pass.Pass;

import java.util.*;

public class Mem2reg implements Pass {
    private final Module module = Module.getModule();
    private final IrBuilder irBuilder = new IrBuilder();
    private ArrayList<Alloca> promotableAllocaInsts = new ArrayList<>();
    // 对于 alloca 指令，其 store 所在的块
    private final HashMap<Alloca, ArrayList<BasicBlock>> alloca2DefBlocks = new HashMap<>();
    private HashMap<Alloca, Value> alloca2value = new HashMap<>();
    // Phi 指令对应指向的 Alloca 指令
    private final HashMap<Phi, Alloca> phi2Alloca = new HashMap<>();
    private final HashSet<BasicBlock> visited = new HashSet<>();

    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn())  {
                mem2reg(function);
            }
        }
    }
    private void clear() {
        promotableAllocaInsts.clear();
        phi2Alloca.clear();
        visited.clear();
        alloca2DefBlocks.clear();
        alloca2value.clear();
    }
    private void mem2reg(Function function) {
        clear();
        BasicBlock entry = function.getFirstBlock();
        for (Instruction inst : entry.getInstructionsArray()) {
            if (inst instanceof Alloca alloca && alloca.isPromotable()) {
                promotableAllocaInsts.add(alloca);
                alloca2DefBlocks.put(alloca, new ArrayList<>());
            }
        }
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction inst : block.getInstructionsArray()) {
                if (inst instanceof Store store && store.getAddr() instanceof Alloca alloca && alloca2DefBlocks.containsKey(alloca)) {
                    alloca2DefBlocks.get(alloca).add(block);
                }
            }
        }
        ArrayList<Alloca> tmpPromotable = new ArrayList<>(promotableAllocaInsts);
        for (Alloca alloca : promotableAllocaInsts) {
            if (alloca2DefBlocks.get(alloca).isEmpty()) {
                tmpPromotable.remove(alloca);
                alloca2DefBlocks.remove(alloca);
                alloca.removeSelf();
            }
        }
        promotableAllocaInsts = tmpPromotable;
        for (Alloca alloca : promotableAllocaInsts) {
            HashSet<BasicBlock> phiBlocks = computeDFClosure(alloca2DefBlocks.get(alloca));
            phiBlocks.removeIf(block -> !isPhiAlive(alloca, block));
            for (BasicBlock phiBlock : phiBlocks) {
                Phi phi = irBuilder.buildPhi((DataType) alloca.getAllocatedType(), phiBlock);
                phi2Alloca.put(phi, alloca);
            }
        }
        for (Alloca alloca : promotableAllocaInsts) {
            if (alloca.getAllocatedType() instanceof IntType) {
                alloca2value.put(alloca, ConstInt.ZERO);
            } else {
                alloca2value.put(alloca, ConstFloat.ZERO);
            }
        }
        renamePhiNode(entry);
        for (Instruction inst : promotableAllocaInsts) {
            inst.removeSelf();
        }
    }

    private void renamePhiNode(BasicBlock entry) {
        visited.clear();
        Stack<BasicBlock> blockStack = new Stack<>();
        Stack<HashMap<Alloca, Value>> mapStack = new Stack<>();
        blockStack.push(entry);
        mapStack.push(alloca2value);
        while (!blockStack.isEmpty()) {
            BasicBlock curBlock = blockStack.pop();
            alloca2value = mapStack.pop();
            if (visited.contains(curBlock)) {
                continue;
            }
            ArrayList<Instruction> insts = curBlock.getInstructionsArray();
            for (Instruction inst : insts) {
                if (inst instanceof Phi phi) {
                    alloca2value.put(phi2Alloca.get(phi), phi);
                } else if (inst instanceof Load li) {
                    if (li.getAddr() instanceof Alloca ai && ai.isPromotable()) {
                        li.replaceAllUsesWith(alloca2value.get(ai));
                        li.removeSelf();
                    }
                } else if (inst instanceof Store si) {
                    if (si.getAddr() instanceof Alloca ai && ai.isPromotable()) {
                        alloca2value.put(ai, si.getValue());
                        si.removeSelf();
                    }
                }
            }
            for (BasicBlock successor : curBlock.getSuccessors()) {
                insts = successor.getInstructionsArray();
                int i = 0;
                while (insts.get(i) instanceof Phi phi) {
                    Alloca ai = phi2Alloca.get(phi);
                    // alloca 不为 null，说明才是当前这次 mem2reg 产生的 phi，而不是以前已经有的 phi
                    if (ai != null) {
                        phi.addIncoming(alloca2value.get(ai), curBlock);
                    }
                    i++;
                }
                if (!visited.contains(successor)) {
                    blockStack.push(successor);
                    mapStack.push(new HashMap<>(alloca2value));
                }
            }
            visited.add(curBlock);
        }
    }

    private HashSet<BasicBlock> computeDFClosure(ArrayList<BasicBlock> defBlocks) {
        HashSet<BasicBlock> ans = new HashSet<>();
        for (BasicBlock defBlock : defBlocks) {
            ans.addAll(defBlock.getDominanceFrontier());
        }
        boolean flag = true;
        while (flag) {
            flag = false;
            HashSet<BasicBlock> newAns = new HashSet<>(ans);
            for (BasicBlock block : ans) {
                newAns.addAll(block.getDominanceFrontier());
            }
            if (newAns.size() > ans.size()) {
                flag = true;
                ans = newAns;
            }
        }
        return ans;
    }

    private boolean isPhiAlive(Alloca alloca, BasicBlock block) {
        for (Instruction inst : block.getInstructionsArray()) {
            if (inst instanceof Load load && load.getAddr() == alloca) {
                return true;
            }
            if (inst instanceof Store store && store.getAddr() == alloca) {
                return false;
            }
        }
        return true;
    }
}


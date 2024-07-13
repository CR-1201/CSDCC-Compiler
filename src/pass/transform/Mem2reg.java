package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Phi;
import ir.types.DataType;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;

public class Mem2reg implements Pass {
    private final Module module = Module.getModule();
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn())  {
                handleMem2Reg(function);
            }
        }
    }
    private ArrayList<Alloca> promotableAlloca = new ArrayList<>();
    // 当前分析的 alloca 唯一一个 store 指令
    private Store onlyStore;
    // 如果 store 和 load 在同一个块
    private BasicBlock onlyBlock;
    // 对于特定的 alloca 指令，其 load 所在的块
    private final HashSet<BasicBlock> usingBlocks = new HashSet<>();
    // 对于特定的 alloca 指令，其 store 所在的块
    private final HashSet<BasicBlock> definingBlocks = new HashSet<>();
    private void handleMem2Reg(Function function) {
        BasicBlock entry = function.getFirstBlock();
        // 在中端ir生成时，就将所有的alloca指令全部放在了entry基本块中
        for (Instruction inst : entry.getInstructions()) {
            if (inst instanceof Alloca && ((Alloca) inst).isPromotable()) {
                promotableAlloca.add((Alloca) inst);
            }
        }

        Iterator<Alloca> iterator = promotableAlloca.iterator();
        while (iterator.hasNext()) {
            Alloca alloca = iterator.next();
            // 如果出现 alloca 指令没有使用者，将其删除
            if (alloca.getUsers().isEmpty()) {
                alloca.removeAllOperators();
                alloca.eraseFromParent();
                iterator.remove();
                continue;
            }
            analyzeAlloca(alloca);
            // 对于一个alloca指令而言，没有任何一条store指令
            // 那么其对应的load指令也是没有意义的，因为不可以读取没有存储过的值。
            if (definingBlocks.isEmpty()) {
                ArrayList<User> loadClone = new ArrayList<>(alloca.getUsers());
                for (User user : loadClone) {
                    Load load = (Load) user;
                    load.replaceAllUsesWith(ConstInt.ZERO);
                    load.removeAllOperators();
                    load.eraseFromParent();
                }
                alloca.removeAllOperators();
                alloca.eraseFromParent();
                iterator.remove();
                continue;
            }
            // 处理完只有一个 Store 的情况
            if (onlyStore != null && dealOnlyStore(alloca)) {
                iterator.remove();
                continue;
            }
            if (onlyBlock != null)  {
                dealOnlyBlock(alloca);
                iterator.remove();
                continue;
            }
            // 所有 definingBlocks 的递归支配边界（递归边界的闭包）都是需要插入 phi 节点的
            HashSet<BasicBlock> phiBlocks = computeIDF(definingBlocks);
            // 去掉不需要插入的节点
            phiBlocks.removeIf(block -> !isPhiAlive(alloca, block));
        }
    }

    private void clear() {
        onlyStore = null;
        onlyBlock = null;
        definingBlocks.clear();
        usingBlocks.clear();
    }

    private void analyzeAlloca(Alloca alloca) {
        clear();
        int cnt = 0;
        for (User user : alloca.getUsers()) {
            if (user instanceof Store si) {
                definingBlocks.add(si.getParent());
                onlyStore = si;
                cnt++;
            } else if (user instanceof Load li) {
                usingBlocks.add(li.getParent());
            }
        }
        onlyStore = cnt > 1 ? null : onlyStore;
        if (definingBlocks.size() == 1 && definingBlocks.equals(usingBlocks)) {
            onlyBlock = definingBlocks.iterator().next();
        }
    }

    /**
     * 只有一个 store 的情况
     * @param alloca
     */
    private Boolean dealOnlyStore(Alloca alloca) {
        Value storeValue = onlyStore.getValue();
        for (User user : alloca.getUsers()) {
            if (user instanceof Load li) {
                if (onlyStore.getParent() != li.getParent() && onlyBlock.isDominator(li.getParent())) {
                    li.replaceAllUsesWith(storeValue);
                    li.removeAllOperators();
                    li.eraseFromParent();
                } else {
                    usingBlocks.add(li.getParent());
                }
            }
        }
        if (usingBlocks.isEmpty()) {
            onlyStore.removeAllOperators();
            onlyStore.eraseFromParent();
            alloca.removeAllOperators();
            alloca.eraseFromParent();
        }
        return usingBlocks.isEmpty();
    }

    private void dealOnlyBlock(Alloca alloca) {
        boolean encounterStore = false;
        for (Instruction inst : onlyBlock.getInstructions()) {
            // 在该 Load 指令之前，没有 Store 指令；
            if (inst instanceof Load && inst.getOperator(0) == alloca) {
                inst.replaceAllUsesWith(ConstInt.ZERO);
                inst.removeAllOperators();
                inst.eraseFromParent();
            } else if (inst instanceof Store && inst.getOperator(1) == alloca) {
                if (encounterStore)  {
                    inst.removeAllOperators();
                    inst.eraseFromParent();
                } else {
                    encounterStore = true;
                }
            }
            alloca.removeAllOperators();
            alloca.eraseFromParent();
        }
    }

    private HashSet<BasicBlock> computeIDF(HashSet<BasicBlock> definingBlocks) {
        HashSet<BasicBlock> ans = new HashSet<>();
        for (BasicBlock definingBlock : definingBlocks) {
            ans.addAll(definingBlock.getDominanceFrontier());
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
        for (Instruction inst : block.getInstructions()) {
            if (inst instanceof Load && inst.getOperator(0) == alloca) {
                return true;
            }
            if (inst instanceof Store && inst.getOperator(1) == alloca) {
                return false;
            }
        }
        return true;
    }

    private void insertPhiNode(Alloca alloca, HashSet<BasicBlock> phiBlocks) {
        for (BasicBlock phiBlock : phiBlocks)
        {
            Phi phi = IrBuilder.getIrBuilder().buildPhi((DataType) alloca.getAllocatedType(), phiBlock);
            phi2Alloca.put(phi, alloca);
        }
    }
}

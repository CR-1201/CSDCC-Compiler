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
import ir.types.FloatType;
import ir.types.IntType;
import pass.Pass;
import utils.IOFunc;

import java.util.*;

public class Mem2reg implements Pass {
    private final Module module = Module.getModule();
    // 可以提升的 alloca 指令
    private ArrayList<Alloca> promotableAllocaInsts = new ArrayList<>();
    // 当前分析的 alloca 唯一一个 store 指令
    private Store onlyStore;
    // 如果 store 和 load 在同一个块
    private BasicBlock onlyBlock;
    // 对于特定的 alloca 指令，其 load 所在的块
    private final HashSet<BasicBlock> usingBlocks = new HashSet<>();
    // 对于特定的 alloca 指令，其 store 所在的块
    private final HashSet<BasicBlock> definingBlocks = new HashSet<>();
    // Phi 指令对应指向的 Alloca 指令
    private final HashMap<Phi, Alloca> phi2Alloca = new HashMap<>();

    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn())  {
                dealMem2Reg(function);
            }
        }
        IOFunc.clear("checkir/ir_after_mem2reg");
        IOFunc.output(Module.getModule().toString(),"checkir/ir_after_mem2reg");
    }
    private void dealMem2Reg(Function function) {
        BasicBlock entry = function.getFirstBlock();
        // 在中端ir生成时，就将所有的alloca指令全部放在了entry基本块中
        for (Instruction inst : entry.getInstructions()) {
            if (inst instanceof Alloca ai && ai.isPromotable()) {
                promotableAllocaInsts.add(ai);
            }
        }
        for (BasicBlock block : function.getBasicBlocksArray()) {
            sweepBlock(function.getFirstBlock(), block);
        }
        Iterator<Alloca> iterator = promotableAllocaInsts.iterator();
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
            // 对于一个 Alloca 指令而言，如果没有任何一条 Store 指令，那么其对应的 Load 指令也是没有意义的，因为不可以读取没有存储过的值。
            if (definingBlocks.isEmpty()) {
                ArrayList<User> loadClone = new ArrayList<>(alloca.getUsers());
                for (User user : loadClone) {
                    Load load = (Load) user;
                    if (load.getValueType() instanceof IntType) {
                        load.replaceAllUsesWith(ConstInt.ZERO);
                    } else if (load.getValueType() instanceof FloatType) {
                        load.replaceAllUsesWith(ConstFloat.ZERO);
                    }
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
            // 插入 Phi 节点
            for (BasicBlock phiBlock : phiBlocks) {
                Phi phi = IrBuilder.getIrBuilder().buildPhi((DataType) alloca.getAllocatedType(), phiBlock);
                phi2Alloca.put(phi, alloca);
            }
        }
        if (promotableAllocaInsts.isEmpty()) {
            return;
        }
        renamePhiNode(function);
        for (Alloca ai : promotableAllocaInsts) {
            ai.removeAllOperators();
            ai.eraseFromParent();
        }
        promotableAllocaInsts.clear();
        phi2Alloca.clear();
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
     * 处理只有一个 store 的情况
     * @param alloca
     */
    private Boolean dealOnlyStore(Alloca alloca) {
        Value storeValue = onlyStore.getValue();
        ArrayList<User> users = alloca.getUsers();
        for (int i = 0; i < users.size(); i++) {
            User user = users.get(i);
            if (user instanceof Load li) {
                // 如果 store 所在的块是 load 的支配者，那么就将用到 load 读入值的地方换成 store
                if (onlyStore.getParent() != li.getParent() && onlyStore.getParent().isDominator(li.getParent())) {
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
        ArrayList<Instruction> insts = onlyBlock.getInstructionsArray();
        for (Instruction inst : insts) {
            // 在该 Load 指令之前，没有 Store 指令；
            if (inst instanceof Load && inst.getOperator(0) == alloca) {
                if (inst.getValueType() instanceof IntType) {
                    inst.replaceAllUsesWith(ConstInt.ZERO);
                } else if (inst.getValueType() instanceof FloatType) {
                    inst.replaceAllUsesWith(ConstFloat.ZERO);
                }
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

    private void renamePhiNode(Function function) {
        BasicBlock entry = function.getFirstBlock();
        HashMap<BasicBlock, Boolean> visitMap = new HashMap<>();
        HashMap<Alloca, Value> variableVersion = new HashMap<>();
        for (BasicBlock block : function.getBasicBlocksArray()) {
            visitMap.put(block, false);
        }
        for (Alloca alloca : promotableAllocaInsts) {
            if (alloca.getAllocatedType() instanceof IntType) {
                variableVersion.put(alloca, ConstInt.ZERO);
            } else if (alloca.getAllocatedType() instanceof FloatType) {
                variableVersion.put(alloca, ConstFloat.ZERO);
            }
        }
        Stack<BasicBlock> blockStack = new Stack<>();
        Stack<HashMap<Alloca, Value>> mapStack = new Stack<>();
        blockStack.push(entry);
        mapStack.push(variableVersion);
        while (!blockStack.isEmpty()) {
            BasicBlock curBlock = blockStack.pop();
            variableVersion = mapStack.pop();
            if (visitMap.get(curBlock)) {
                continue;
            }
            int i = 0;
            ArrayList<Instruction> insts = curBlock.getInstructionsArray();
            while (insts.get(i) instanceof Phi phi) {
                variableVersion.put(phi2Alloca.get(phi), phi);
                i++;
            }
            while (i < insts.size()) {
                Instruction inst = insts.get(i);
                if (inst instanceof Load li) {
                    if (li.getAddr() instanceof Alloca ai) {
                        inst.replaceAllUsesWith(variableVersion.get(ai));
                        inst.removeAllOperators();
                        inst.eraseFromParent();
                    }
                } else if (inst instanceof Store si) {
                    if (si.getAddr() instanceof Alloca ai) {
                        variableVersion.put(ai, si.getValue());
                        inst.removeAllOperators();
                        inst.eraseFromParent();
                    }
                }
                i++;
            }
            for (BasicBlock successor : curBlock.getSuccessors()) {
                insts = successor.getInstructionsArray();
                i = 0;
                while (insts.get(i) instanceof Phi phi) {
                    Alloca ai = phi2Alloca.get(phi);
                    phi.addIncoming(variableVersion.get(ai), curBlock);
                    i++;
                }
                if (!visitMap.get(successor)) {
                    blockStack.push(successor);
                    mapStack.push(new HashMap<>(variableVersion));
                }
            }
            visitMap.put(curBlock, true);
        }
    }

    private void sweepBlock(BasicBlock entry, BasicBlock block) {
        HashMap<Alloca, Store> alloca2store = new HashMap<>();
        ArrayList<Instruction> insts = block.getInstructionsArray();
        for (Instruction inst : insts) {
            // 如果当前指令是 store 指令，而且地址是 alloca 分配的，那么就存到 alloca2store 中
            if (inst instanceof Store si && si.getAddr() instanceof Alloca ai) {
                alloca2store.put(ai, si);
            } else if (inst instanceof Load li && li.getAddr() instanceof Alloca ai) {
                // 如果当前指令是 load，而且地址是 alloca
                Store store = alloca2store.get(ai);
                // 没有赋初值就 load 的情况，直接删除
                if (store == null && block == entry) {
                    if (li.getValueType() instanceof IntType) {
                        inst.replaceAllUsesWith(ConstInt.ZERO);
                    } else if (li.getValueType() instanceof FloatType) {
                        inst.replaceAllUsesWith(ConstFloat.ZERO);
                    }
                    inst.removeAllOperators();
                    inst.eraseFromParent();
                } else if (store != null) {
                    // 用 store 的要存入的值代替 load 要读入的值
                    inst.replaceAllUsesWith(store.getValue());
                    inst.removeAllOperators();
                    inst.eraseFromParent();
                }
            }
        }
        alloca2store.clear();
        insts = block.getInstructionsArray();
        for (int i = insts.size() - 1; i >= 0; i--) {
            Instruction inst = insts.get(i);
            // 如果是 store 指令 并且 store 的地址是 alloca 出来的
            if (inst instanceof Store si && si.getAddr() instanceof Alloca ai) {
                Store store = alloca2store.get(ai);
                // 不是最后一条对于 alloca 这个地址的写，那么就删除
                if (store != null) {
                    inst.removeAllOperators();
                    inst.eraseFromParent();
                } else {
                    alloca2store.put(ai, si);
                }
            }
        }
    }
}

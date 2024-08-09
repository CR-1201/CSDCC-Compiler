package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.types.VoidType;
import pass.Pass;
import pass.analysis.PureFunction;

import java.util.*;

/**
 * 指令重排
 * 块内版本：
 * 只在每一个块内执行指令重排的操作，因此，不需要进行额外的dom分析等
 */
public class InstRearrange implements Pass {
    /**
     * 内部类，待重排的指令
     * 需要保存的主要信息是：指令本身、指令的得分以及指令的时间戳
     */
    private static class PendingInst implements Comparable<PendingInst>{
        public Instruction inst;
        public int score;
        public int timestamp;
        public PendingInst(Instruction inst, int score, int timestamp) {
            this.inst = inst;
            this.score = score;
            this.timestamp = timestamp;
        }
        public int compareTo(PendingInst o) {
            if (score != o.score) return Integer.compare(score, o.score);
            if (timestamp != o.timestamp) return Integer.compare(timestamp, o.timestamp);
            return 0;
        }
    }
    private final HashSet<Instruction> exitLiveInsts = new HashSet<>();
    private HashSet<Function> pureFunctions = new HashSet<>();
    private final PureFunction pureFunctionAnalyze = new PureFunction();

    private final Map<Instruction, Integer> inst2Score = new HashMap<>();

    // 对每一个块进行指令重排时，需要记录的相关信息
    /**
     * 对于最后一次使用在当前块内的变量，记录其目前还被哪些指令使用，以便在剩余单个使用时为对应指令加分
     */
    private final HashMap<Instruction, HashSet<Instruction>> liveValueUseSet = new HashMap<>();
    /**
     * 指令依赖图：记录每个指令依赖哪些当前块内的前置语句
     */
    private final Map<Instruction, HashSet<Instruction>> dependencyUseeMap = new HashMap<>();
    /**
     * 指令依赖图：记录每个指令被哪些后续语句依赖
     */
    private final Map<Instruction, HashSet<Instruction>> dependencyUserMap = new HashMap<>();

    // 将 phi 指令的 use 挂载到对应基本块的末尾
    private final Map<BasicBlock, Set<Instruction>> phiUsages = new HashMap<>();

    private final HashSet<Instruction> pendingInsts = new HashSet<>();
    private final PriorityQueue<PendingInst> pendingInstQueue = new PriorityQueue<>();

    private int timeStamp = Integer.MAX_VALUE;

    public void run() {
        pureFunctionAnalyze.markPure();
        pureFunctions = pureFunctionAnalyze.getPureFunctions();
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                exitLiveInsts.clear();
                phiUsages.clear();
                relocatePhiUses(function);
                dfsDomTree(function.getFirstBlock());
            }
        }
    }

    private void clear() {
        liveValueUseSet.clear();
        dependencyUseeMap.clear();
        dependencyUserMap.clear();
        inst2Score.clear();
        pendingInsts.clear();
        pendingInstQueue.clear();
        timeStamp = Integer.MAX_VALUE;
    }

    private void relocatePhiUses(Function function) {
        for (BasicBlock basicBlock : function.getBasicBlocksArray()) {
            phiUsages.put(basicBlock, new HashSet<>());
        }
        for (BasicBlock basicBlock : function.getBasicBlocksArray()) {
            for (Instruction inst : basicBlock.getInstructionsArray()) {
                if (inst instanceof Phi phi) {
                    for (int i = 0; i < phi.getPrecursorNum(); i++) {
                        Value value = phi.getOperator(i);
                        if (value instanceof Instruction usedInst) {
                            phiUsages.get(basicBlock).add(usedInst);
                        }
                    }
                }
            }
        }
    }

    private HashSet<Instruction> dfsDomTree(BasicBlock block) {
        clear();
        HashSet<Instruction> liveInsts = new HashSet<>(phiUsages.get(block));
        for (Value operator : block.getTailInstruction().getOperators()) {
            if (operator instanceof Instruction inst) {
                liveInsts.add(inst);
            }
        }
        for (BasicBlock idom : block.getIdoms()) {
            HashSet<Instruction> idomLiveInsts = dfsDomTree(idom);
            if (idomLiveInsts.size() > liveInsts.size()) {
                idomLiveInsts.addAll(liveInsts);
                liveInsts = idomLiveInsts;
            } else {
                liveInsts.addAll(idomLiveInsts);
            }
        }
        instRearrange(block);
        return liveInsts;
    }

    private void buildLiveValueUseSet(BasicBlock block) {
        for (Instruction inst : block.getMainInstsArray()) {
            for (Value operator : inst.getOperators()) {
                if (operator instanceof Instruction usedInst) {
                    if (!exitLiveInsts.contains(usedInst)) {
                        if (!liveValueUseSet.containsKey(usedInst)) {
                            liveValueUseSet.put(usedInst, new HashSet<>());
                        }
                        liveValueUseSet.get(usedInst).add(inst);
                    }
                }
            }
        }
    }

    private void buildInstructionDependencyMap(BasicBlock basicBlock) {
        for (Instruction inst : basicBlock.getMainInstsArray()) {
            dependencyUseeMap.put(inst, new HashSet<>());
            dependencyUserMap.put(inst, new HashSet<>());
        }
        Set<Instruction> prevInsts = new HashSet<>();
        Instruction lastFixedInstruction = null;
        for (Instruction inst : basicBlock.getMainInstsArray()) {
            for (Value operator : inst.getOperators()) {
                if (operator instanceof Instruction usedInst && prevInsts.contains(usedInst)) {
                    dependencyUseeMap.get(inst).add(usedInst);
                    dependencyUserMap.get(usedInst).add(inst);
                }
            }
            // 固定顺序的指令，依次依赖前序值
            if (isFixed(inst)) {
                if (lastFixedInstruction != null) {
                    dependencyUseeMap.get(inst).add(lastFixedInstruction);
                    dependencyUserMap.get(lastFixedInstruction).add(inst);
                }
                lastFixedInstruction = inst;
            }
            // 维护本基本块已经产生的值
            prevInsts.add(inst);
        }
    }

    /**
     * 判断一个指令是否需要被固定调用顺序 <br>
     * 需要固定调用顺序的指令包括：内存指令，Call指令 <br>
     *
     * @param inst 被判断的指令
     * @return 需要固定返回true；否则返回false。
     */
    private boolean isFixed(Instruction inst) {
        if (inst instanceof Alloca || inst instanceof Load || inst instanceof Store) return true;
        if (inst instanceof Call call) {
            return !pureFunctions.contains(call.getFunction());
        }
        return false;
    }

    private void instRearrange(BasicBlock basicBlock) {
        // 收集新增的活跃变量，记录这些变量被哪些语句使用
        buildLiveValueUseSet(basicBlock);
        // 建立指令依赖图
        buildInstructionDependencyMap(basicBlock);
        // 执行重排过程
        ArrayList<Instruction> insts = basicBlock.getMainInstsArray();
        for (Instruction inst : insts) {
            inst.eraseFromParent();
            // 给予所有指令基本分数
            inst2Score.put(inst, 0);
            // 加入初始可用的指令
            if (dependencyUserMap.get(inst).isEmpty()) {
                setPending(inst);
            }
            // 产生活跃变量的减1分
            if (!(inst.getValueType() instanceof VoidType)) {
                updateScore(inst, -1);
            }
        }
        // 扫描活跃变量，检查是否存在可以加分的活跃变量
        for (Map.Entry<Instruction, HashSet<Instruction>> entry : liveValueUseSet.entrySet()) {
            Iterator<Instruction> iterator = entry.getValue().iterator();
            if (iterator.hasNext()) {
                updateScore(iterator.next(), 1);
            }
        }

        // 更新 exitLiveInstructions ，将本基本块内用到的外部值加入其中，并删除已经在本基本块内定义的值
        exitLiveInsts.addAll(liveValueUseSet.keySet());
        for (Instruction instruction : basicBlock.getInstructionsArray()) {
            // set的特性：如果不存在就不移除，不需要额外检查
            exitLiveInsts.remove(instruction);
        }
        // 放回指令
        Instruction lastPlacedInstruction = null;
        while (true) {
            var inst = getNextInst();
            if (inst == null) break;
            if (lastPlacedInstruction == null) {
                basicBlock.addInst(inst);
            } else {
                basicBlock.insertBefore(inst, lastPlacedInstruction);
            }
            lastPlacedInstruction = inst;
            onInstructionPlaced(inst);
        }
    }

    private void onInstructionPlaced(Instruction instruction) {
        // 维护 liveValueUseSet
        for (Value operand : instruction.getOperators()) {
            if (operand instanceof Instruction usedInstruction) {
                if (liveValueUseSet.containsKey(usedInstruction)) {
                    var users = liveValueUseSet.get(usedInstruction);
                    users.remove(instruction);
                    for (Instruction user : users) {
                        updateScore(user, -1);
                    }
                }
            }
        }
        // 维护 dependencyUseeMap
        for (Instruction useeInstruction : dependencyUseeMap.get(instruction)) {
            var users = dependencyUserMap.get(useeInstruction);
            users.remove(instruction);
            if (users.isEmpty()) {
                setPending(useeInstruction);
            }
        }
    }

    private Instruction getNextInst() {
        while (!pendingInstQueue.isEmpty()) {
            PendingInst pendingInstruction = pendingInstQueue.remove();
            if (pendingInstruction.score != inst2Score.get(pendingInstruction.inst))
                continue;
            if (!pendingInsts.contains(pendingInstruction.inst))
                continue;
            pendingInsts.remove(pendingInstruction.inst);
            return pendingInstruction.inst;
        }
        return null;
    }

    private int getTimeStamp() {
        return timeStamp--;
    }

    private void setPending(Instruction inst) {

        pendingInstQueue.add(new PendingInst(inst, inst2Score.get(inst), getTimeStamp()));
        pendingInsts.add(inst);
    }

    private void updateScore(Instruction inst, int change) {
        inst2Score.compute(inst, (k, oldScore) -> oldScore + change);
        if (pendingInsts.contains(inst)) {
            pendingInstQueue.add(new PendingInst(inst, inst2Score.get(inst), getTimeStamp()));
        }
    }
}

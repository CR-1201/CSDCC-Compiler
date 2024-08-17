package pass.transform.parallel;

import config.Config;
import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import pass.Pass;
import pass.analysis.Loop;

import java.util.HashSet;

public class AdvancedMark implements Pass {

    public static final boolean ENABLE_PARALLEL = Config.enableParallel;
    public static int PARALLEL_NUM = Config.parallelProcessNum;
    public static int MAX_PARALLEL_DEPTH = Config.maxParallelDepth;

    private static final Module irModule = Module.getModule();
    private static final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    private static final HashSet<BasicBlock> knownBlocks = new HashSet<>();

    private static final HashSet<BasicBlock> bbs = new HashSet<>();
    private static final HashSet<Value> idcVars = new HashSet<>();
    private static final HashSet<Loop> loops = new HashSet<>();

    @Override
    public void run() {
        for (Function function : irModule.getFunctionsArray()) {
            if (function.getIsBuiltIn()) {
                continue;
            }

            knownBlocks.clear();

            for (BasicBlock block : function.getBasicBlocksArray()) {
                if (!knownBlocks.contains(block) && block.isLoopHeader()) {
                    mark(block.getLoop());
                }
            }
        }
    }

    private void mark(Loop loop) {
        if (checkBeforeMark(loop)) {
            init(loop);
            if (checkIfMark(loop)) {
                System.out.println("passed");
                modify(loop);
            } else {
                System.out.println("failed");
            }
        }
    }

    private boolean checkBeforeMark(Loop loop) {
        if (loop.getDepth() > MAX_PARALLEL_DEPTH) {  // 限制并行的循环深度
            return false;
        }
        if (loop.getEnterings().size() > 1) {  // 限制并行循环的进入数量
            return false;
        }
        if (!isSoftIdcInfoSet(loop)) {  // 要求并行循环变量的Var, Init, End能够分析
            return false;
        }
        BasicBlock loopEntering = loop.getEnterings().iterator().next();  // 要求不能为已经被标记为并行的循环
        for (Instruction instruction : loopEntering.getInstructionsArray()) {
            if (instruction instanceof Call callInstr && callInstr.getFunction().getName().equals("@startparallel")) {
                knownBlocks.addAll(loop.getAllBlocks());
                return false;
            }
        }
        return true;
    }

    private void init(Loop loop) {
        bbs.clear();
        idcVars.clear();
        loops.clear();
        dfs(loop);
    }

    /*
        TODO <1> 数组写操作 -> 数组下标必须包含直接并行循环变量 ( a[i][...][...] = ... )
        TODO <2> 数组读操作 -> <1> 读数组与写数组一致 -> 必须与写数组在直接循环变量上一致 ( a[i][...] = a[i][...] + ... )
        TODO                 <2> 读数组与写数组不一致 -> 无限制 ( a[i] = b[...] + ... )
        TODO <3> 非数组写操作 -> <1> 对并行循环变量的写操作的user只能唯一是并行循环变量
        TODO                   <2> 并行循环后被使用 -> 计算过程不能包含并行循环变量(循环不变表达式外提导致自动满足)，不能包含数组，不能包含自己 [ a = i + ... , a = b[1], a = a + ... ]
        TODO <4> 非数组读操作 -> 无限制 ( ... = t )
     */
    private boolean checkIfMark(Loop loop) {
        Phi currentLoopVar = (Phi) loop.getIdcVar();
        HashSet<Value> storeGepBase = new HashSet<>();
        HashSet<GEP> storeGeps = new HashSet<>();
        System.out.println("ready to check parallel");

        // TODO <1> 数组写操作 -> 数组下标必须包含直接并行循环变量 ( a[i][...][...] = ... )
        for (BasicBlock block : loop.getAllBlocks()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Store storeInstr && storeInstr.getAddr() instanceof GEP storeGepInstr) {
                    int idcVarCnt = 0;
                    for (Value index : storeGepInstr.getIndex()) {
                        if (index == currentLoopVar) {
                            idcVarCnt ++;
                        }
                    }
                    if (idcVarCnt == 0) {
                        return false;
                    }
                    storeGepBase.add(storeGepInstr.getBase());
                    storeGeps.add(storeGepInstr);
                }
            }
        }
        System.out.println("passed condition 1");

        // TODO <2> 数组读操作 -> <1> 读数组与写数组一致 -> 必须与写数组在直接循环变量上一致 ( a[i][...] = a[i][...] + ... )
        // TODO                 <2> 读数组与写数组不一致 -> 无限制 ( a[i] = b[...] + ... )
        for (BasicBlock block : loop.getAllBlocks()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Load loadInstr && loadInstr.getAddr() instanceof GEP loadGep) {
                    if (storeGepBase.contains(loadGep.getBase())) {
                        HashSet<Store> stores = load2Stores(loadInstr);
                        HashSet<GEP> geps = stores2Geps(stores);
                        if (geps.size() > 1) {
                            return false;
                        }
                        GEP storeGep = geps.iterator().next();
                        for (int i = 0 ; i < loadGep.getIndex().size() ; i ++) {
                            if (loadGep.getIndex().get(i) == currentLoopVar && storeGep.getIndex().get(i) != currentLoopVar ||
                                    loadGep.getIndex().get(i) != currentLoopVar && storeGep.getIndex().get(i) == currentLoopVar) {
                                return false;
                            }
                        }
                    }
                }
            }
        }
        System.out.println("passed condition 2");

        // TODO <3> 非数组写操作 -> <1> 对并行循环变量的写操作的user只能唯一是并行循环变量
        // TODO                   <2> 并行循环后被使用 -> 计算过程不能包含并行循环变量(循环不变表达式外提导致自动满足)，不能包含数组，不能包含自己 [ a = i + ... , a = b[1], a = a + ... ]
        for (User user : currentLoopVar.getUsers()) {
            if (user instanceof Add || user instanceof Sub || user instanceof Mul || user instanceof Sdiv) {
                Instruction instruction = (Instruction) user;
                if (instruction.getUsers().size() != 1) {
                    return false;
                }
                if (instruction.getUsers().iterator().next() != currentLoopVar) {
                    return false;
                }
            } else if (user instanceof Store storeInstr) {
                if (!(storeInstr.getAddr() instanceof GEP)) {
                    return false;
                }
            } else if (!(user instanceof Icmp || user instanceof GEP)) {
                return false;
            }
        }
        for (BasicBlock block : loop.getAllBlocks()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Phi phiInstr && !idcVars.contains(phiInstr)) {
                    return false;  // TODO 需要加强
                }
            }
        }
        System.out.println("passed condition 3");

        return true;
    }

    private void modify(Loop loop) {

    }

    // =========================================== below are util functions ===========================================

    private HashSet<GEP> stores2Geps(HashSet<Store> stores) {
        HashSet<GEP> res = new HashSet<>();
        for (Store store : stores) {
            if (store.getAddr() instanceof GEP gepInstr) {
                res.add(gepInstr);
            }
        }
        return res;
    }

    HashSet<Store> storeSet = new HashSet<>();
    private HashSet<Store> load2Stores(Load loadInstr) {
        helper1(loadInstr);
        return storeSet;
    }
    private void helper1(Instruction instruction) {
        for (User user : instruction.getUsers()) {
            if (user instanceof Instruction instruction1) {
                if (user instanceof Store storeInstr) {
                    storeSet.add(storeInstr);
                }
                helper1(instruction1);
            }
        }
    }

    private void dfs(Loop loop) {
        loops.add(loop);
        bbs.addAll(loop.getCurrentLoopLevelBlocks());
        idcVars.add(loop.getIdcVar());
        for (Loop child : loop.getChildren()) {
            dfs(child);
        }
    }

    private static boolean isSoftIdcInfoSet(Loop loop) {
        return loop.getIdcEnd() != null && loop.getIdcInit() != null && loop.getIdcVar() != null;
    }

}

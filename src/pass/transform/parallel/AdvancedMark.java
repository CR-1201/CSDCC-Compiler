package pass.transform.parallel;

import config.Config;
import ir.*;
import ir.Module;
import ir.instructions.binaryInstructions.Icmp;
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

    /*
        TODO <1> 数组写操作 -> 数组下标必须包含直接并行循环变量 ( a[i][...][...] = ... )
        TODO <2> 数组读操作 -> <1> 读数组与写数组一致 -> 必须与写数组在直接循环变量上一致 ( a[i][...] = a[i][...] + ... )
        TODO                 <2> 读数组与写数组不一致 -> 无限制 ( a[i] = b[...] + ... )
        TODO <3> 非数组写操作 -> <1> 对并行循环变量的写操作的user只能唯一是并行循环变量
        TODO                   <2> 并行循环后被使用 -> 计算过程不能包含并行循环变量，不能包含数组 [ a = i + ... , a = b[1] ]
        TODO <4> 非数组读操作 -> 无限制 ( ... = t )
     */

    private void mark(Loop loop) {
        if (checkBeforeMark(loop)) {
            init(loop);
            if (checkIfMark(loop)) {
                modify(loop);
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
        return true;
    }

    private void init(Loop loop) {

    }

    private boolean checkIfMark(Loop loop) {
        return false;
    }

    private void modify(Loop loop) {

    }

    // =========================================== below are util functions ===========================================

    private static boolean isSoftIdcInfoSet(Loop loop) {
        return loop.getIdcEnd() != null && loop.getIdcInit() != null && loop.getIdcVar() != null;
    }

}

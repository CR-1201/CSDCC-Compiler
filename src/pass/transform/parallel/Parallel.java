package pass.transform.parallel;

import config.Config;
import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Add;
import ir.instructions.binaryInstructions.Icmp;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.binaryInstructions.Sdiv;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.types.IntType;
import pass.Pass;
import pass.analysis.*;
import pass.transform.DeadCodeEmit;
import pass.transform.LocalArrayLift;

import java.util.ArrayList;
import java.util.HashSet;

// TODO <1> 扩展循环上下界及比较符号
// TODO <2> 带常函数的数组下标 22:43 -> 03_sort1.sy
// TODO <3> 带循环内不变的变量的数组下标 23:01-1
// TODO <4> 带循环内不变的数组元素的数组下标 23:01-2 -> 04_spmv1.sy
// TODO <5> 数组下标为循环变量与循环内不变变量或常数的算术表达式  23:15 -> crypto1.sy fft0.sy

public class Parallel implements Pass {

    private static final Module irModule = Module.getModule();

    @Override
    public void run() {
        if (!Config.enableParallel) {
            Config.parallelProcessNum = 1;
        }

        new CFG().run();
        new Dom().run();
        new LocalArrayLift().run();
        new LoopAnalysis().run();
        new DeadCodeEmit().run();

        for (Function function : irModule.getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                new LoopVarAnalysis().loopVarAnalysis(function);
            }
        }

        new BasicMark().run();
        new AdvancedMark().run();
    }

}

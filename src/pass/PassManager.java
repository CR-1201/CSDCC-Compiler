package pass;

import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;
import pass.analysis.SideEffect;
import pass.transform.*;
import pass.transform.branch.Branch2Switch;
import pass.transform.emituseless.SimpleBlockEmit;
import pass.transform.emituseless.UselessPhiEmit;
import pass.transform.emituseless.UselessStoreEmit;
import pass.transform.gcmgvn.GCMGVN;
import pass.transform.loop.*;
import pass.transform.other.ConstFunctionReplace;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {

        passes.add(new Pattern.Pattern1());
        passes.add(new Pattern.Pattern2());

        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LoopAnalysis());
        passes.add(new SideEffect());
        passes.add(new GlobalValueLocalize());
        passes.add(new SimpleBlockEmit());
//        passes.add(new Sroa());
        Mem2RegPass();
        passes.add(new MemoryOptimize());
        passes.add(new GepFuse());
        passes.add(new LocalArrayLift());
        passes.add(new ConstArrayFold()); // ConstArrayFlod 前面必须有Gep Fuse

        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new CSE());
        passes.add(new CFG());
        passes.add(new TailRecursionElimination());
//        passes.add(new LoopMemset()); // 后端测的时候记得打开, 中端版本过低, 不要打开
        passes.add(new ConstFunctionReplace());
        passes.add(new InlineFunction());
        passes.add(new GlobalMemorizeFunc()); // inline后理论上只剩递归函数
        passes.add(new GlobalValueLocalize());

        Mem2RegPass();
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new CSE());
        passes.add(new CFG());
//
        passes.add(new MergeBlocks());
        passes.add(new SideEffect());
        passes.add(new DeadCodeEmit());
        passes.add(new UselessReturnEmit());
        passes.add(new ADCE());
        passes.add(new UselessStoreEmit());
        EmitSimpleBrPass();
        BasicPass();
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LICM());
        passes.add(new LCSSA());
        passes.add(new LoopUnroll());
        passes.add(new LoopFold());
        passes.add(new MergeBlocks());
        passes.add(new DeadCodeEmit());
//        passes.add(new MemSetOptimize());
        passes.add(new LoopStrengthReduction());

        passes.add(new GepSplit());
        EmitSimpleBrPass();

        BasicPass();
        passes.add(new SCCP());
        passes.add(new UselessPhiEmit());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new GepFuse());
        passes.add(new CSE());
        passes.add(new CFG());

        BasicPass();
        passes.add(new Peephole());
        passes.add(new GepFuse());
        passes.add(new UselessArrayStoreEmit());

        passes.add(new Pattern.Pattern5());

        passes.add(new LoopGEPCombine()); // 循环展开后要常数传播才能合并GEP

        BasicPass();
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());

        passes.add(new DeadCodeEmit());
        passes.add(new SideEffect());
        passes.add(new UselessStoreEmit());  // UselessStoreEmit 前面，一定要进行函数副作用的分析

        passes.add(new Peephole());
        passes.add(new DeadCodeEmit());

        passes.add(new SideEffect());
        passes.add(new UselessStoreEmit());  // UselessStoreEmit 前面，一定要进行函数副作用的分析
        EmitSimpleBrPass();

        passes.add(new LoopGEPCombine()); // 循环展开后要常数传播才能合并GEP,最好加一个Fuse

        passes.add(new InstructionCleanUp());
        passes.add(new GepSplit());

        BasicPass();
        EmitSimpleBrPass();
        passes.add(new Pattern.Pattern3());
        BasicPass();
        passes.add(new Pattern.Pattern4());

        passes.add(new ParallelMark());

        passes.add(new Branch2Switch()); // Branch2Switch 前面一定要有一个 SCCP / BasicPass
        passes.add(new CFG());
        passes.add(new Dom());


        for (Pass pass : passes) {
            pass.run();
        }
    }


    /**
     * 这个是专门用来处理 GVN 和 GCM 的 Pass
     * GVN 和 GCM 之前一定要先进行副作用判断，来确定某一个函数是否可以被处理
     */
    private void GVNGCMPass() {
        passes.add(new LoopAnalysis());
        passes.add(new SideEffect());
        passes.add(new GCMGVN());
    }

    private void Mem2RegPass() {
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new Mem2reg());
    }

    private void BasicPass() {
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new MergeBlocks());
        passes.add(new SCCP());
        passes.add(new DeadCodeEmit());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new DeadCodeEmit());
        GVNGCMPass();
        passes.add(new MergeBlocks());
    }

    private void EmitSimpleBrPass() {
        passes.add(new SimpleBlockEmit());
        // 由于消除简单的挑战块之后，可能会导致很多 cond 不会被使用，因此可以执行死代码删除
        passes.add(new DeadCodeEmit());
    }
    public void run2() {
        passes.add(new GepFuse());
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LoopAnalysis());
        passes.add(new GlobalValueLocalize());
        passes.add(new Mem2reg());
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new CFG());
        passes.add(new InlineFunction());
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new MergeBlocks());
        passes.add(new SideEffect());
        passes.add(new DeadCodeEmit());
        passes.add(new UselessStoreEmit());  // UselessStoreEmit 前面，一定要进行函数副作用的分析
        passes.add(new LCSSA());
        passes.add(new MergeBlocks());
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new GAVN());
        passes.add(new SCCP());
        passes.add(new SideEffect());
        passes.add(new UselessPhiEmit());
        passes.add(new SimplifyInst());
        passes.add(new UselessStoreEmit());
        passes.add(new MathOptimize());
        passes.add(new InstructionCleanUp());
        passes.add(new MathOptimize());
        passes.add(new GepSplit());
        passes.add(new InstructionCleanUp());
        passes.add(new CFG());
        passes.add(new Dom());
        for (Pass pass : passes) {
            pass.run();
        }
    }

}

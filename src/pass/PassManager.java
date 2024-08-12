package pass;

import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;
import pass.analysis.SideEffect;
import pass.transform.*;
import pass.transform.emituseless.SimpleBlockEmit;
import pass.transform.emituseless.UselessPhiEmit;
import pass.transform.emituseless.UselessStoreEmit;
import pass.transform.gcmgvn.GCMGVN;
import pass.transform.loop.*;

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
        Mem2RegPass();
        passes.add(new MemoryOptimize());
        passes.add(new LocalArrayLift());
        passes.add(new ConstArrayFold());
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new CSE());
        passes.add(new CFG());
        passes.add(new TailRecursionElimination());
        passes.add(new InlineFunction());
        passes.add(new GlobalValueLocalize());

        Mem2RegPass();
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
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
        passes.add(new GepFuse());
        passes.add(new LICM());
        passes.add(new LCSSA());
        passes.add(new LoopUnroll());
        passes.add(new LoopFold());
        passes.add(new MergeBlocks());
        passes.add(new DeadCodeEmit());
//        passes.add(new MemSetOptimize());

        passes.add(new LoopStrengthReduction());
        EmitSimpleBrPass();

        passes.add(new GepSplit());
        BasicPass();
        passes.add(new SCCP());
        passes.add(new UselessPhiEmit());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        BasicPass();
        passes.add(new Peephole());
        passes.add(new GepFuse());
        passes.add(new UselessArrayStoreEmit());
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

        passes.add(new InstructionCleanUp());

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

}

package pass;

import ir.BasicBlock;
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
import pass.transform.loop.LCSSA;
import pass.transform.loop.LICM;
import pass.transform.loop.LoopFold;
import pass.transform.loop.LoopUnroll;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {

        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LoopAnalysis());
        passes.add(new SideEffect());
        passes.add(new GlobalValueLocalize());
        passes.add(new SimpleBlockEmit());
        Mem2RegPass();
        passes.add(new MemoryOptimize());
////
        passes.add(new LocalArrayLift());
////         LocalArrayLift只用一次
//
        passes.add(new ConstArrayFold());
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new CFG());
        passes.add(new InlineFunction());
        Mem2RegPass();
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());
        passes.add(new MergeBlocks());
        passes.add(new SideEffect());
        passes.add(new DeadCodeEmit());
        passes.add(new UselessReturnEmit());
        passes.add(new ADCE());
        passes.add(new UselessStoreEmit());  // UselessStoreEmit 前面，一定要进行函数副作用的分析
////
        BasicPass();
//
        passes.add(new CFG());
        passes.add(new Dom());
//        passes.add(new GAVN());  // GAVN前需要最新的CFG和Dom, 放在GVN GCM后面较好
//
        passes.add(new GepFuse());

        passes.add(new LICM());

        passes.add(new LCSSA());
        passes.add(new LoopUnroll());
////
        passes.add(new LoopFold());
        passes.add(new MergeBlocks());
        passes.add(new DeadCodeEmit());
////
        passes.add(new GepSplit());
        BasicPass();
////
////        passes.add(new CSE());
////        // SCCP后可能出现没有value的phi
        passes.add(new SCCP());
        passes.add(new UselessPhiEmit());
        passes.add(new SimplifyInst());
//////
        passes.add(new MathOptimize());
        BasicPass();
        passes.add(new Peephole());
        BasicPass();


//        GVNGCMPass();

//        passes.add(new CFG());
//        passes.add(new Dom());
//        passes.add(new GAVN());  // GAVN前需要最新的CFG和Dom, 放在GVN GCM后面较好
//
//        passes.add(new InstructionCleanUp());
//
//        passes.add(new CFG());
//        passes.add(new Dom());
//        passes.add(new GepFuse());

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
}

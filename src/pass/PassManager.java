package pass;

import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;
import pass.analysis.SideEffect;
import pass.transform.*;
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
        passes.add(new MergeBlocks());
        passes.add(new Mem2reg());

        passes.add(new LocalArrayLift());
//         LocalArrayLift只用一次

        passes.add(new ());

        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());

        MyPass();

        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());

        passes.add(new GepFuse());

        MyPass();

        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new GAVN());  // GAVN前需要最新的CFG和Dom, 放在GVN GCM后面较好

        passes.add(new CFG());
        passes.add(new InlineFunction());
        passes.add(new Mem2reg());

        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());

        passes.add(new GepFuse());

        MyPass();

        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());

        // Br

        passes.add(new LoopAnalysis());
        passes.add(new LCSSA());
        passes.add(new LoopUnroll());

        passes.add(new CFG());
        passes.add(new Dom());

        MyPass();

        passes.add(new UselessPhiEmit());

        passes.add(new LoopFold());
        passes.add(new LoopFold());

        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());

        MyPass();

        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MathOptimize());

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

    private void MyPass() {
        passes.add(new SideEffect());
        passes.add(new DeadCodeEmit());
        passes.add(new SimplifyInst());
        passes.add(new SCCP());
        passes.add(new DeadCodeEmit());
        passes.add(new UselessStoreEmit());
        GVNGCMPass();
    }
}

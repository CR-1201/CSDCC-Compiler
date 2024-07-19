package pass;

import config.Config;
import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;
import pass.analysis.SideEffect;
import pass.transform.*;
import pass.transform.emituseless.UselessPhiEmit;
import pass.transform.emituseless.UselessStoreEmit;
import pass.transform.gcmgvn.GCMGVN;
import utils.IOFunc;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LoopAnalysis());
        passes.add(new GlobalValueLocalize());
        passes.add(new Mem2reg());
        passes.add(new SCCP());
        passes.add(new SimplifyInst());
        passes.add(new MergeRedundantBr());
        passes.add(new SideEffect());
        passes.add(new UselessReturnEmit());
        passes.add(new UselessPhiEmit());
        // UselessStoreEmit 前面，一定要进行函数副作用的分析
        passes.add(new UselessStoreEmit());
//        passes.add(new DeadCodeEmit());

        GVNGCMPass();
        for (Pass pass : passes) {
            pass.run();
        }
    }

    /**
     * 这个是专门用来处理 GVN 和 GCM 的 Pass
     * GVN 和 GCM 之前一定要先进行副作用判断，来确定某一个函数是否可以被处理
     */
    private void GVNGCMPass() {
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LoopAnalysis());
        passes.add(new SideEffect());
        passes.add(new GCMGVN());
    }
}

package pass;

import config.Config;
import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;
import pass.analysis.SideEffect;
import pass.transform.*;
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
//        passes.add(new SCCP());
//
//        passes.add(new MergeRedundantBr());
        passes.add(new SideEffect());
//        passes.add(new UselessReturnEmit());
//        passes.add(new DeadCodeEmit());
//
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LoopAnalysis());
        passes.add(new GCMGVN());

        for (Pass pass : passes) {
            pass.run();
        }
    }
}

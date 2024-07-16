package pass;

import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;
import pass.analysis.SideEffect;
import pass.transform.DeadCodeEmit;
import pass.transform.Mem2reg;
import pass.transform.UselessReturnEmit;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {
        passes.add(new CFG());
        passes.add(new Dom());
//        passes.add(new LoopAnalysis());
//        passes.add(new Mem2reg());
        passes.add(new SideEffect());
//        passes.add(new DeadCodeEmit());
        passes.add(new UselessReturnEmit());
        for (Pass pass : passes) {
            pass.run();
        }
    }
}

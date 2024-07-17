package pass;

import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.analysis.LoopAnalysis;
import pass.transform.*;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new LoopAnalysis());
//        passes.add(new Mem2reg());
//        passes.add(new SCCP());
//        passes.add(new CFG());
//        passes.add(new Dom());
//        passes.add(new LoopAnalysis());
        passes.add(new GVN());
        passes.add(new GCM());
//        passes.add(new UselessReturnEmit());
        for (Pass pass : passes) {
            pass.run();
        }
    }
}

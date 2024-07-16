package pass;

import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;
import pass.transform.Mem2reg;
import pass.transform.SCCP;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {
        passes.add(new CFG());
        passes.add(new Dom());
        passes.add(new Mem2reg());
        passes.add(new SCCP());
//        passes.add(new SCCP());
        for (Pass pass : passes) {
            pass.run();
        }
    }
}

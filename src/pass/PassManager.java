package pass;

import ir.Module;
import pass.analysis.CFG;
import pass.analysis.Dom;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {
        passes.add(new CFG());
        passes.add(new Dom());
        for (Pass pass : passes) {
            pass.run();
        }
    }
}

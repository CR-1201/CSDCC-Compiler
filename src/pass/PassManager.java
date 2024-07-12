package pass;

import ir.Module;
import pass.analysis.CFG;

import java.util.ArrayList;

public class PassManager {
    private Module module = Module.getModule();
    private ArrayList<Pass> passes = new ArrayList<>();

    public void run() {
        passes.add(new CFG());
        for (Pass pass : passes) {
            pass.run();
        }
    }
}

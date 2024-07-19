package pass.transform.loop;

import ir.Function;
import ir.Module;
import pass.Pass;

public class LoopUnroll implements Pass {
    public void run() {
        for (Function func : Module.getModule().getFunctionsArray()) {
            if (!func.getIsBuiltIn()) {
                runLoopUnroll(func);
            }
        }
    }

    private void runLoopUnroll(Function func) {

    }
}

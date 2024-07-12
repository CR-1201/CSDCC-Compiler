package pass.analysis;

import ir.Function;
import ir.Module;
import pass.Pass;

/**
 * CFG: 控制流图，是每一个函数内部的，每一个函数内都有一个CFG
 */
public class CFG implements Pass {
    private Module module = Module.getModule();
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                // 针对每一个函数去新建CFG

            }
        }
    }
    private void buildCFG(Function function) {
        //
    }
}

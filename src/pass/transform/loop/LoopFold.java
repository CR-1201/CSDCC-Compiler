package pass.transform.loop;

import ir.Function;
import ir.IrBuilder;
import ir.Module;
import pass.Pass;

/**
 * 把重复计算的循环给进行折叠
 */
public class LoopFold implements Pass {
    private final IrBuilder irBuilder = IrBuilder.getIrBuilder();
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {

            }
        }
    }
}

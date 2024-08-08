package pass.transform;

import ir.Function;
import ir.Module;
import pass.Pass;

/**
 * 指令重排
 */
public class InstRearrange implements Pass {
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {

            }
        }
    }




}

package pass.transform.loop;

import ir.Function;
import ir.Module;
import pass.Pass;

/**
 * 把 while 循环转换成 if-do-while 的模式
 * while (i < n) {
 *     ans += i;
 *     i = i + 1;
 * }
 * =>
 * if (i < n) {
 *     do {
 *         ans += i;
 *         i = i + 1;
 *     } while (i < n)
 * }
 */
public class LoopRotate implements Pass {
    @Override
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                runLoopRotate(function);
            }
        }
    }

    private void runLoopRotate(Function function) {

    }

}

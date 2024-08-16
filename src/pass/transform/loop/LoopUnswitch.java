package pass.transform.loop;

import ir.Function;
import ir.Module;
import pass.Pass;
import pass.analysis.Loop;

import java.util.HashSet;

public class LoopUnswitch implements Pass {
    private final HashSet<Loop> loops = new HashSet<>();
    @Override
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                loops.clear();
                loops.addAll(function.getAllLoops());
            }
        }
    }

    /*
    Loop 中间所有的判断的 cond 除了 head之外，都必须可以被提升到循环外才行 -> 说明不在 loop 中
     */
}

package pass.transform.other;

import ir.Function;
import ir.Module;
import ir.types.*;
import pass.Pass;

public class ConstFunctionReplace implements Pass {
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                runConstFunctionReplace(function);
            }
        }
    }

    private void runConstFunctionReplace(Function function) {
        if (canReplace(function)) {

        }
    }

    private Boolean canReplace(Function function) {
        if (!function.getCallees().isEmpty()) {
            return false;
        }
        if (function.getReturnType() instanceof VoidType) {
            return false;
        } else if (function.getReturnType() instanceof IntType) {
            return false;
        }
        if (!(function.getArgument(0).getValueType() instanceof PointerType)) {
            return false;
        } else {
            if (!(((PointerType) function.getArgument(0).getValueType()).getPointeeType() instanceof FloatType)) {
                return false;
            }
        }
        if (!(function.getArgument(1).getValueType() instanceof PointerType)) {
            return false;
        } else {
            if (!(((PointerType) function.getArgument(1).getValueType()).getPointeeType() instanceof FloatType)) {
                return false;
            }
        }
        if (!(function.getArgument(2).getValueType() instanceof IntType)) {
            return false;
        }
        return true;
    }
}

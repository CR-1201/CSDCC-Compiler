package pass.transform;

import com.sun.jdi.VoidType;
import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.FloatType;
import ir.types.IntType;
import ir.types.PointerType;
import pass.Pass;

import java.util.ArrayList;

public class UselessReturnEmit implements Pass {

    private final Module irModule = Module.getModule();

    private final ArrayList<Function> uselessFunctions = new ArrayList<>();

    private final ArrayList<Call> uselessCalls = new ArrayList<>();

    private boolean changed = true;

    @Override
    public void run() {
        while (changed) {
            changed = false;
            uselessCalls.clear();
            uselessFunctions.clear();

            removeCalls();

            new DeadCodeEmit().run();
        }
    }

    private void removeCalls() {
        for (Function func : irModule.getFunctionsArray()) {
            if (!func.getIsBuiltIn() &&
                    !func.getName().equals("@main") &&
                    !(func.getReturnType() instanceof VoidType)) {
                visitFunc(func);
            }
        }
        for (Call call : uselessCalls) {
            changed = true;
            call.removeAllOperators();
            call.eraseFromParent();
        }
        for (Function func : uselessFunctions) {
            changed = true;
            func.eraseFromParent();
        }
    }

    private void visitFunc(Function func) {
        ArrayList<Call> potential = new ArrayList<>();

        for (User user : func.getUsers()) {
            if (user instanceof Call callInstr) {
                if (callInstr.getParent().getParent().equals(func)) {  // 递归函数不分析
                    return;
                } else if (!user.getUsers().isEmpty()) {  // Call指令有使用者不分析
                    return;
                } else if (withoutStrongSideEffect(func)) {
                    potential.add(callInstr);
                }
            }
        }

        uselessCalls.addAll(potential);

        // 函数的返回值没有在任何地方被使用，将返回值设为0
        for (BasicBlock block : func.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Ret retInstr) {
                    if (func.getReturnType() instanceof IntType) {
                        if (retInstr.getOperator(0) != ConstInt.ZERO) {
                            changed = true;
                            instruction.setOperator(0, ConstInt.ZERO);
                        }
                    }
                    if (func.getReturnType() instanceof FloatType) {
                        if (retInstr.getOperator(0) != ConstFloat.ZERO) {
                            changed = true;
                            instruction.setOperator(0, ConstFloat.ZERO);
                        }
                    }
                }
            }
        }

        if (withoutStrongSideEffect(func)) {
            uselessFunctions.add(func);
        }
    }

    private boolean withoutStrongSideEffect(Function function) {
        for (Argument argument : function.getArguments()) {
            if (argument.getValueType() instanceof PointerType) {
                return false;
            }
        }

        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                for (Value value : instruction.getOperators())  {
                    if (value.getName().charAt(0) == '@') {  // 说明是全局变量或函数
                        return false;  // TODO 只有对全局变量的store才有强副作用
                    }
                }
            }
        }

        // 没有参数数组，未使用全局变量
        return true;
    }

}

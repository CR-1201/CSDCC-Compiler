package pass.transform;

import com.sun.jdi.VoidType;
import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Ret;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashSet;

public class UselessReturnEmit implements Pass {

    private final Module irModule = Module.getModule();

    private final HashSet<Value> visitedRecursiveFunctions = new HashSet<>();

    private final ArrayList<Function> uselessFunctions = new ArrayList<>();

    private final ArrayList<Call> uselessCalls = new ArrayList<>();

    @Override
    public void run() {
        visitedRecursiveFunctions.clear();
        uselessCalls.clear();
        uselessFunctions.clear();

        for (Function func : irModule.getFunctionsArray()) {
            if (!func.getIsBuiltIn() &&
                    !func.getName().equals("@main") &&
                    !(func.getReturnType() instanceof VoidType)) {
                helper(func);
            }
        }

        for (Function func : uselessFunctions) {
            func.eraseFromParent();
        }

        for (Call call : uselessCalls) {
            call.removeAllOperators();
            call.eraseFromParent();
        }
    }

    private void helper(Function func) {
        if (!visitedRecursiveFunctions.contains(func)) {
            ArrayList<Call> calls = new ArrayList<>();
            boolean recursive = false;

            for (User user : func.getUsers()) {
                if (user instanceof Call) {
                    if (((Call) user).getParent().getParent().equals(func)) {
                        recursive = true;
                        calls.add((Call) user);
                    } else if (!user.getUsers().isEmpty()) {
                        return ;
                    } else if (!((Call) user).getFunction().getSideEffect()) {
                        uselessCalls.add((Call) user);
                    }
                }
            }

            if (recursive) {
                for (Call call : calls)
                {
                    if (call.getUsers().size() > 1) {
                        return;
                    }
                    else if (call.getUsers().size() == 1 && !(call.getUsers().get(0) instanceof Ret)) {
                        return;
                    }
                }

                visitedRecursiveFunctions.add(func);
            }

            for (BasicBlock bb : func.getBasicBlocksArray()) {
                for (Instruction inst : bb.getInstructionsArray())
                {
                    if (inst instanceof Ret && !((Ret) inst).getOperators().isEmpty())
                    {
                        inst.setOperator(0, ConstInt.ZERO);
                    }
                }
            }

            if (!func.getSideEffect()) {
                uselessFunctions.add(func);
            }
        }
    }

}

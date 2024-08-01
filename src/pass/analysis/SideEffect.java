package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Objects;

public class SideEffect implements Pass {

    private final Module irModule = Module.getModule();

    private final HashMap<Function, Boolean> processedFunctions = new HashMap<>();

    private final HashMap<Function, Boolean> visitedFunctions = new HashMap<>();

    @Override
    public void run() {
        initCallGraph();
        ArrayList<Function> functions = irModule.getFunctionsArray();
        Function mainFunction = null;
        for (Function func : functions) {
            if (Objects.equals(func.getName(), "@main")) {
                mainFunction = func;
            }
        }
        if (mainFunction != null) {
            process(mainFunction);
            mainFunction.setSideEffect(true);
        }
    }

    private void initCallGraph() {
        for (Function func : irModule.getFunctionsArray()){
            func.clearCallees();
            func.clearCallers();
        }
        for (Function func : irModule.getFunctionsArray()) {
            func.setSideEffect(false);
            visitedFunctions.put(func, false);

            if (func.getIsBuiltIn()) {
                processedFunctions.put(func, true);
                func.setSideEffect(true);
            } else {
                processedFunctions.put(func, false);

                for (BasicBlock basicBlock : func.getBasicBlocksArray()) {
                    for (Instruction instruction : basicBlock.getInstructionsArray()) {
                        if (instruction instanceof Call) {
                            Function calledFunction = ((Call) instruction).getFunction();

                            if (!calledFunction.getIsBuiltIn()) {
                                func.addCallee(calledFunction);
                                calledFunction.addCaller(func);
                            } else {
                                func.setSideEffect(true);
                                processedFunctions.put(func, true);
                            }
                        }

                        if (instruction instanceof Store) {
                            func.setSideEffect(true);
                            processedFunctions.put(func, true);
                        }
                    }
                }
            }
        }
    }

    private boolean process(Function func) {
        boolean hasSideEffect = false;
        visitedFunctions.put(func, true);

        if (processedFunctions.get(func)) {
            hasSideEffect = func.getSideEffect();

            for (Function caller : func.getCallersArray()) {
                if (!processedFunctions.get(caller) && !visitedFunctions.get(caller)) {
                    process(caller);
                }
            }
        } else {
            for (Function caller : func.getCallersArray()) {
                if (caller.getSideEffect() ||
                        (!processedFunctions.get(caller) && !visitedFunctions.get(caller) && process(caller))) {
                    hasSideEffect = true;
                }
            }
        }

        visitedFunctions.put(func, false);
        func.setSideEffect(hasSideEffect);
        processedFunctions.put(func, true);
        return hasSideEffect;
    }

}

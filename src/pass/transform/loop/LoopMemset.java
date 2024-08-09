package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.types.ArrayType;
import ir.types.DataType;
import ir.types.IntType;
import ir.types.PointerType;
import pass.Pass;
import pass.analysis.*;
import utils.HandlePrintf;

import java.util.ArrayList;

/**
 * 单层循环
 * while (i < n) {
 *     arr[i] = const;
 *     i = i + 1;
 * }
 * 双层循环
 * while (i < a) {
 *     int j = 0;
 *     while (j < b) {
 *         arr[i][j] = const;
 *         j = j + 1;
 *     }
 *     i = i + 1;
 * }
 */
public class LoopMemset implements Pass {
    private final CFG cfg = new CFG();
    private final Dom dom = new Dom();
    private final LoopAnalysis loopAnalysis = new LoopAnalysis();
    private final LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
    private final IrBuilder irBuilder = new IrBuilder();
    private GEP gepInst = null;
    private Store storeInst = null;
    private Value loopSize;
    private boolean changed = false;
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                changed = true;
                while (changed) {
                    changed = false;
                    cfg.buildCFG(function);
                    dom.buildDom(function);
                    loopAnalysis.analyzeLoopInfo(function);
                    loopVarAnalysis.loopVarAnalysis(function);
                    for (Loop loop : function.getAllLoops()) {
                        runLoopMemset(loop);
                        if (changed) {
                            break;
                        }
                    }
                }
            }
        }
    }
    private void runLoopMemset(Loop loop) {
        if (isMemsetableSingleLoop(loop)) {
            BasicBlock entering = loop.getEnterings().iterator().next();
            Instruction br = entering.getTailInstruction();
            Value gepPtr = gepInst.getBase();
            ArrayList<Value> argList = new ArrayList<>();
            if (gepPtr instanceof Argument) {
                argList.add(gepPtr);
            } else {
                ArrayList<Value> values = new ArrayList<>();
                values.add(ConstInt.ZERO);
                values.add(ConstInt.ZERO);
                GEP basePtr = irBuilder.buildGEPBeforeInst(entering, gepPtr, values, entering.getTailInstruction());
                argList.add(basePtr);
            }
            argList.add(storeInst.getValue());
            if (loopSize instanceof ConstInt) {
                argList.add(new ConstInt(((ConstInt) loopSize).getValue() * 4));
            } else {
                Mul mi = irBuilder.buildMulBeforeTail(entering, (DataType) loopSize.getValueType(), loopSize, new ConstInt(4));
                argList.add(mi);
            }
            irBuilder.buildCallBeforeTail(entering, Function.memset, argList);
            br.setOperator(br.getOperators().indexOf(loop.getHeader()), loop.getExits().iterator().next());
            loop.getHeader().replaceAllUsesWith(entering);
            changed = true;
        }
    }

    private Boolean isMemsetableSingleLoop(Loop loop) {
        if (!(loop.isSimpleLoop() && loop.isInductorVarSet())) {
            return false;
        }
        if (!(loop.getIdcInit() instanceof ConstInt init && init.getValue() == 0)) {
            return false;
        }
        if (loop.getAllBlocks().size() != 2) {
            return false;
        }
        int gepCount = 0;
        int storeCount = 0;
        for (BasicBlock block : loop.getAllBlocks()) {
            for (Instruction inst : block.getInstructionsArray()) {
                if (inst instanceof GEP gep) {
                    gepCount++;
                    gepInst = gep;
                } else if (inst instanceof Store store) {
                    storeCount++;
                    storeInst = store;
                }
            }
        }
        if (gepCount * storeCount != 1) {
            return false;
        }
        if (!(storeInst.getValue() instanceof ConstInt storeValue && storeValue.getValue() == 0)) {
            return false;
        }
        if (storeInst.getAddr() != gepInst) {
            return false;
        }
        loopSize = loop.getIdcEnd();
        return true;
    }
}

package pass.transform.parallel;

import config.Config;
import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Add;
import ir.instructions.binaryInstructions.Icmp;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.binaryInstructions.Sdiv;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.types.IntType;
import pass.Pass;
import pass.analysis.*;
import pass.transform.DeadCodeEmit;
import pass.transform.LocalArrayLift;

import java.util.ArrayList;
import java.util.HashSet;

public class BasicMark implements Pass {

    public static final boolean ENABLE_PARALLEL = Config.enableParallel;
    public static int PARALLEL_NUM = Config.parallelProcessNum;
    public static int MAX_PARALLEL_DEPTH = Config.maxParallelDepth;

    private static final Module irModule = Module.getModule();
    private static final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    private static final HashSet<BasicBlock> knownBlocks = new HashSet<>();

    private static final HashSet<BasicBlock> bbs = new HashSet<>();
    private static final HashSet<Value> idcVars = new HashSet<>();
    private static final HashSet<Loop> loops = new HashSet<>();

    private static Value idcVar;
    private static Value idcInit;
    private static Value idcStep;
    private static Value idcAlu;
    private static Value idcEnd;
    private static Icmp cond;

    private static BasicBlock loopEntering;
    private static BasicBlock loopHeader;
    private static BasicBlock loopLatch;
    private static BasicBlock loopExiting;
    private static BasicBlock loopExit;

    @Override
    public void run() {
        for (Function function : irModule.getFunctionsArray()) {
            if (function.getIsBuiltIn()) {
                continue;
            }

            knownBlocks.clear();

            for (BasicBlock block : function.getBasicBlocksArray()) {
                if (!knownBlocks.contains(block) && block.isLoopHeader()) {
                    mark(block.getLoop());
                }
            }
        }
    }

    private void mark(Loop loop) {
        if (!isPureLoop(loop)) {
            return;
        }
        if (loop.getDepth() > MAX_PARALLEL_DEPTH) {
            return;
        }

        bbs.clear();
        idcVars.clear();
        loops.clear();

        dfs(loop);

        for (Loop tmp : loops) {
            for (Instruction instruction : tmp.getHeader().getInstructionsArray()) {
                if (instruction instanceof Phi && !instruction.equals(tmp.getIdcVar())) {
                    return;  // 循环内不能有其他phi
                }
            }
        }

        for (BasicBlock block : bbs) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Call) {
                    return;
                }
                if (useOuterLoop(instruction)) {
                    return;
                }
                if (instruction instanceof GEP gepInstr) {
                    for (Value idx : gepInstr.getIndex()) {
                        if (idx instanceof ConstInt constIntIdx && constIntIdx.getValue() == 0) {
                            continue;
                        }
                        if (!idcVars.contains(idx)) {
                            return;
                        }
                    }
                }
            }
        }

        idcVar = loop.getIdcVar();
        idcInit = loop.getIdcInit();
        idcStep = loop.getIdcStep();
        idcAlu = loop.getIdcAlu();
        idcEnd = loop.getIdcEnd();
        cond = loop.getCond();

        if (!(idcInit instanceof ConstInt)) {
            return;
        }
        if (((ConstInt) idcInit).getValue() != 0) {
            return;
        }
        if (idcEnd instanceof Constant) {
            return;
        }
        if (loop.getEnterings().size() > 1) {
            return;
        }

        loopEntering = loop.getEnterings().iterator().next();
        loopHeader = loop.getHeader();
        loopLatch = loop.getLatches().iterator().next();
        loopExiting = loop.getExitings().iterator().next();
        loopExit = loop.getExits().iterator().next();

        Function function = loop.getHeader().getParent();

        BasicBlock parallelStartBlock = irBuilder.buildBasicBlock(function);
        BasicBlock parallelEndBlock = irBuilder.buildBasicBlock(function);
        parallelStartBlock.setLoop(loop);
        loop.addBlock(parallelStartBlock);
        parallelEndBlock.setLoop(loop);
        loop.addBlock(parallelEndBlock);

        if (!cond.getCondition().equals(Icmp.Condition.LT)) {  // FIXME <bug> consider n > i
            return;
        }

        Call startCall = prepareParallelStart(parallelStartBlock);
        prepareParallelEnd(parallelEndBlock, startCall);

        loop.setParallel();

        knownBlocks.addAll(bbs);
    }

    private Call prepareParallelStart(BasicBlock startBlock) {
        Call startCall = null;
        Mul mul1;
        Add add1;
        if (ENABLE_PARALLEL) {
            startCall = irBuilder.buildCall(startBlock, Function.startparallel, new ArrayList<>());
            mul1 = irBuilder.buildMul(startBlock, new IntType(32), startCall, idcEnd);
            add1 = irBuilder.buildAdd(startBlock, new IntType(32), startCall, new ConstInt(1));
        } else {
            mul1 = irBuilder.buildMul(startBlock, new IntType(32), new ConstInt(0), idcEnd);
            add1 = irBuilder.buildAdd(startBlock, new IntType(32), new ConstInt(0), new ConstInt(1));
        }
        Sdiv div1 = irBuilder.buildSdiv(startBlock, new IntType(32), mul1, new ConstInt(PARALLEL_NUM));
        modifyPhi(idcVar, loopEntering, div1);
        Mul mul2 = irBuilder.buildMul(startBlock, new IntType(32), add1, idcEnd);
        Sdiv div2 = irBuilder.buildSdiv(startBlock, new IntType(32), mul2, new ConstInt(PARALLEL_NUM));
        cond.setOperator(1, div2);
        irBuilder.buildBr(startBlock, loopHeader);

        modifyBr(loopEntering, loopHeader, startBlock);
        loopEntering.addSuccessor(startBlock);
        loopEntering.removeSuccessor(loopHeader);
        startBlock.addPrecursor(loopEntering);
        startBlock.addSuccessor(loopHeader);
        loopHeader.addPrecursor(startBlock);
        loopHeader.removePrecursor(loopEntering);

        return startCall;
    }

    private void prepareParallelEnd(BasicBlock endBlock, Call startCall) {
        if (ENABLE_PARALLEL) {
            ArrayList<Value> args = new ArrayList<>();
            args.add(startCall);
            irBuilder.buildCall(endBlock, Function.endparallel, args);
        }
        irBuilder.buildBr(endBlock, loopExit);

        modifyBr(loopExiting, loopExit, endBlock);
        loopExiting.addSuccessor(endBlock);
        loopExiting.removeSuccessor(loopExit);
        endBlock.addPrecursor(loopExiting);
        endBlock.addSuccessor(loopExit);
        loopExit.addPrecursor(endBlock);
        loopExit.removePrecursor(loopExiting);
    }

    private void modifyPhi(Value instr, BasicBlock fromBlock, Value toValue) {
        Phi phiInstr = (Phi) instr;
        Value fromValue = phiInstr.getIncomingFrom(fromBlock);
        phiInstr.replaceOperator(fromValue, toValue, (BasicBlock) toValue.getParent());
    }

    private void modifyBr(BasicBlock block, BasicBlock from, BasicBlock to) {
        Br br = (Br) block.getTailInstruction();
        int index = br.getOperators().indexOf(from);
        br.setOperator(index, to);
    }

    private boolean useOuterLoop(Instruction instruction) {
        for (User user : instruction.getUsers()) {
            if (!loops.contains(((BasicBlock) user.getParent()).getLoop())) {
                return true;
            }
        }
        return false;
    }

    private void dfs(Loop loop) {
        loops.add(loop);
        bbs.addAll(loop.getCurrentLoopLevelBlocks());
        idcVars.add(loop.getIdcVar());
        for (Loop child : loop.getChildren()) {
            dfs(child);
        }
    }

    private boolean isPureLoop(Loop loop) {
        if (!loop.hasChildLoop()) {
            return true;
        }
        if (loop.getChildren().size() > MAX_PARALLEL_DEPTH) {
            return false;
        }

        // 到此为拥有一个子循环的循环
        if (!loop.isSimpleLoop() || !isIdcInfoSet(loop)) {
            return false;
        }
        return isPureLoop(loop.getChildren().iterator().next());
    }

    private static boolean isIdcInfoSet(Loop loop) {
        return loop.getIdcEnd() != null && loop.getIdcAlu() != null && loop.getIdcStep() != null && loop.getIdcInit() != null && loop.getIdcVar() != null;
    }

}

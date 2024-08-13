package backend.pass;

import backend.Utils.ImmediateUtils;
import backend.instruction.*;
import backend.module.ObjBlock;
import backend.module.ObjFunction;
import backend.module.ObjModule;
import backend.operand.*;
import utils.Pair;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

public class PeepHole implements ObjPass {
    ObjModule module;

    public PeepHole() {
        module = ObjModule.getModule();
    }

    @Override
    public void run() {
        for (ObjFunction mf : module.getFunctions()) {
            clearNotUseInst(mf);
            boolean unDone = true;
            while (unDone) {
                unDone = oneStage(mf);
                unDone |= clearNotUseInst(mf);
            }
            threeStage(mf);
        }
    }

    ObjBlock curMB = null;

    public boolean oneStage(ObjFunction mf) {
        boolean unDone = false;
        for (ObjBlock mb : mf.getBlocks()) {
            curMB = mb;
            var live = calcBlockLiveRange(mb);
            LinkedList<ObjInstruction> instructions = new LinkedList<>(mb.getInstructions());
            for (ObjInstruction mi : instructions) {
                int idx = instructions.indexOf(mi);
                ObjInstruction prevInst = (idx == 0 ? null : instructions.get(instructions.indexOf(mi) - 1));
                ObjInstruction nextInst = (idx == instructions.size() - 1 ? null : instructions.get(instructions.indexOf(mi) + 1));
                if (mi instanceof Binary binary) {
                    if (binary.getType() == Binary.BinaryType.add || binary.getType() == Binary.BinaryType.sub) {
                        if (binary.getRhs() instanceof ObjImmediate oimm && oimm.getImmediate() == 0) {
                            unDone = true;
                            if (binary.getDst().equals(binary.getLhs())) {
                                mb.removeInstruction(binary);
                            } else {
                                mb.addInstructionBefore(binary, new ObjMove(binary.getDst(), binary.getLhs(), false, false));
                                mb.removeInstruction(binary);
                            }
                        }
                    }
                    var isAddSub = binary.getType().equals(Binary.BinaryType.add)
                            || binary.getType().equals(Binary.BinaryType.sub)
                            || binary.getType().equals(Binary.BinaryType.mul)
                            || binary.getType().equals(Binary.BinaryType.rsb)
                            || binary.getType().equals(Binary.BinaryType.sdiv);
                    // mov a, b shift
                    // sub/add/rsb/mul/div d, c, a
                    // add/mul d, a, c
                    // =>
                    // mov a, b shift
                    // sub/add/rsb/mul/div d, c, b shift
                    // add/mul d, c, b shift
                    if (prevInst != null && prevInst instanceof ObjMove move && isAddSub) {
                        boolean isReg = move.getRhs() instanceof ObjRegister;
                        boolean isEqualLhs = move.getDst().equals(binary.getLhs());
                        boolean isEqualRhs = move.getDst().equals(binary.getRhs());
                        boolean isNoShift = !binary.hasShift();
                        boolean isNoCond = move.getCond().equals(ObjInstruction.ObjCond.any);
                        boolean canFix = (!move.getDst().equals(move.getRhs())
                                && !binary.getLhs().equals(binary.getRhs()))
                                || (move.getDst().equals(move.getRhs())
                                && binary.equals(live.getOrDefault(new Pair<>(move.getDst(), move), null))
                                && !binary.getLhs().equals(binary.getRhs()));
                        if (isReg && isEqualLhs && isNoShift && isNoCond && canFix
                                && (binary.getType().equals(Binary.BinaryType.add)
                                || (binary.getType().equals(Binary.BinaryType.mul)))
                                && binary.getRhs() instanceof ObjRegister) {
//                            var binary2 = new Binary(binary.getDst(),
//                                    binary.getRhs(), move.getRhs(), binary.getType());
                            binary.setShift(move.getShiftO());
//                            mb.addInstructionBefore(binary, binary2);
                            binary.replaceLhs(binary.getRhs());
                            binary.replaceRhs(move.getRhs());
//                            mb.removeInstruction(binary);
                            if (binary.equals(live.getOrDefault(new Pair<>(move.getDst(), move), null))) {
                                mb.removeInstruction(move);
                            }
                            unDone = true;
                        } else if (isReg && isEqualRhs && isNoShift && isNoCond && canFix) {
//                            var binary2 = new Binary(binary.getDst(),
//                                    binary.getLhs(), move.getRhs(), binary.getType());
                            binary.setShift(move.getShiftO());
//                            mb.addInstructionBefore(binary, binary2);
                            binary.replaceRhs(move.getRhs());
//                            mb.removeInstruction(binary);
                            if (binary.equals(live.getOrDefault(new Pair<>(move.getDst(), move), null))) {
                                mb.removeInstruction(move);
                            }
                            unDone = true;
                        }

                    }
                }
                if (mi instanceof ObjLoad load) {
                    var isOffsetZero = load.getOff() == null || new ObjImmediate(0).equals(load.getOff());
                    if (isOffsetZero && prevInst != null && prevInst instanceof Binary binary) {
                        if (binary.getType().equals(Binary.BinaryType.add)) {
                            boolean canPre = (binary.getRhs() instanceof ObjRegister || (binary.getRhs() instanceof ObjImmediate &&
                                    ImmediateUtils.checkOffsetRange(((ObjImmediate) binary.getRhs()).getImmediate(),
                                            ((ObjRegister) load.getDst()).isFloat())))
                                    && load.equals(live.getOrDefault(new Pair<>(binary.getDst(), binary), null));
                            boolean isEqualAddr = binary.getDst().equals(load.getAdd());
                            boolean isFloat = ((ObjRegister) load.getDst()).isFloat();
                            boolean isNoCond = binary.getCond().equals(ObjInstruction.ObjCond.any);
//                            if (binary.hasShift())
//                                load.setShift(binary.getShiftO());
//                                boolean isNoShift = (binary.getShift() == null || binary.getShift().isNoPrint());
                            if (canPre && isEqualAddr && isNoCond && !isFloat) {
                                load.replaceAdd(binary.getLhs());
                                load.replaceOff(binary.getRhs());
                                if (binary.hasShift())
                                    load.setShift(binary.getShiftO());
                                mb.removeInstruction(binary);
                                unDone = true;
                            }
                        }
                    }
                }
                if (mi instanceof ObjStore store) {
                    var isOffsetZero = store.getOff() == null || new ObjImmediate(0).equals(store.getOff());
                    if (isOffsetZero && prevInst != null && prevInst instanceof Binary binary) {
                        if (binary.getType().equals(Binary.BinaryType.add)) {
                            boolean canPre = (binary.getRhs() instanceof ObjRegister || (binary.getRhs() instanceof ObjImmediate &&
                                    ImmediateUtils.checkOffsetRange(((ObjImmediate) binary.getRhs()).getImmediate(),
                                            ((ObjRegister) store.getSrc()).isFloat())))
                                    && store.equals(live.getOrDefault(new Pair<>(binary.getDst(), binary), null));
                            boolean isEqualAddr = binary.getDst().equals(store.getAdd());
                            boolean isFloat = ((ObjRegister) store.getSrc()).isFloat();
                            boolean isNoCond = binary.getCond().equals(ObjInstruction.ObjCond.any);
//                                boolean isNoShift = (binary.getShift() == null || binary.getShift().isNoPrint());
                            if (canPre && isEqualAddr && isNoCond && !isFloat) {
                                store.replaceAdd(binary.getLhs());
                                store.replaceOff(binary.getRhs());
                                if (binary.hasShift())
                                    store.setShift(binary.getShiftO());
                                mb.removeInstruction(binary);
                                unDone = true;
                            }
                        }
                    }
                }
                if (mi instanceof ObjJump jump) {
                    if (jump.isJump() && mf.getNextBlock(curMB) != null && jump.getTarget().getName().equals(mf.getNextBlock(curMB).getName())) {
                        unDone = true;
                        mb.removeInstruction(jump);
                    }
                }
                if (mi instanceof ObjLoad) {
                    if (oneStageLdr(mi, prevInst)) unDone = true;
                }
                if (mi instanceof ObjMove) {
                    if (oneStageMov(mi, nextInst)) unDone = true;
                }
            }
        }
        return unDone;
    }

    private Map<Pair<ObjOperand, ObjInstruction>, ObjInstruction> calcBlockLiveRange(ObjBlock block) {
        Map<Pair<ObjOperand, ObjInstruction>, ObjInstruction> ret = new HashMap<>();
        Map<Pair<ObjOperand, ObjInstruction>, ObjInstruction> temp = new HashMap<>();
        Map<ObjOperand, ObjInstruction> regMap = new HashMap<>();
        for (var inst : block.getInstructions()) {
            for (var use : inst.getUse()) {
                if (regMap.containsKey(use)) {
                    temp.put(new Pair<>(use, regMap.get(use)), inst);
                }
            }
            for (var def : inst.getDef()) {
                ret.put(new Pair<>(def, regMap.get(def)), temp.getOrDefault(new Pair<>(def, regMap.get(def)), regMap.get(def)));
                regMap.put(def, inst);
            }
            // for (var def : inst.getRegDef()) {
            // temp.put(new Pair<>(def, inst), null);
            // }
        }
        return ret;
    }

    private boolean oneStageMov(ObjInstruction mi, ObjInstruction nextInst) {
        if (!mi.hasShift()) {
            ObjMove curMov = (ObjMove) mi;
            if (curMov.getDst().equals(curMov.getRhs())) {
                curMB.removeInstruction(curMov);
                return true;
            } else if (curMov.getCond() == ObjInstruction.ObjCond.any && nextInst instanceof ObjMove nextMov) {
                if (nextMov.getDst().equals(nextMov.getRhs())) {
                    curMB.removeInstruction(nextMov);
                    return true;
                } else if (nextMov.getDst().equals(curMov.getDst())) {
                    curMB.removeInstruction(curMov);
                    return true;
                }
            }
        }
        return false;
    }

    private boolean oneStageLdr(ObjInstruction mi, ObjInstruction prevInst) {
        ObjLoad ldr = (ObjLoad) mi;
        if (prevInst instanceof ObjStore str && str.isVFP() == ldr.isVFP()) {
            if (ldr.getAdd().equals(str.getAdd())
                    && ldr.getOff().equals(str.getOff())
                    && ldr.getShift().equals(str.getShift())) {
                if (!ldr.isVFP()) {
                    curMB.addInstructionBefore(ldr, new ObjMove(ldr.getDst(), str.getSrc(), false, false));
                } else {
                    curMB.addInstructionBefore(ldr, new ObjMove(ldr.getDst(), str.getSrc(), true, false));
                }
                curMB.removeInstruction(ldr);
                return true;
            }
        }
        return false;
    }

    private boolean clearNotUseInst(ObjFunction mf) {
        boolean done = true;
        for (var mb : mf.getBlocks()) {
            Map<ObjOperand, ObjInstruction> instMap = new HashMap<>();
            LinkedList<ObjInstruction> instructions = new LinkedList<>(mb.getInstructions());
            for (var inst : instructions) {
                for (var use : inst.getUse()) {
                    instMap.remove(use);
                }
                for (var def : inst.getDef()) {
                    if (instMap.containsKey(def)) {
                        var pre = instMap.get(def);
                        instMap.remove(def);
                        if (!(pre instanceof ObjCall)) {
                            mb.removeInstruction(pre);
                            done = false;
                        }
                    }
                }
                for (var def : inst.getDef()) {
                    instMap.put(def, inst);
                }
            }
        }
        return !done;
    }

    public void threeStage(ObjFunction mf) {
        for (ObjBlock mb : mf.getBlocks()) {
            curMB = mb;
            ObjOperand[] GPRConstPool = new ObjOperand[17];
            ArrayList<ObjInstruction> removeList = new ArrayList<>();
            LinkedList<ObjInstruction> instructions = new LinkedList<>(mb.getInstructions());
            for (ObjInstruction i : instructions) {
                if (i instanceof ObjMove mi && mi.hasNoShiftAndCond()) {
                    if (mi.getRhs() instanceof ObjImmediate && mi.getDst() instanceof ObjPhyRegister dst) {
                        ObjOperand gpr = GPRConstPool[dst.getRegisterNum()];
                        if (gpr == mi.getDst()) {
                            removeList.add(mi);
                        } else {
                            GPRConstPool[dst.getRegisterNum()] = mi.getRhs();
                        }
                    }
                } else {
                    for (ObjOperand def : i.getDef()) {
                        if (def instanceof ObjPhyRegister dst) {
                            GPRConstPool[dst.getRegisterNum()] = null;
                        }
                    }
                }
            }
            for (ObjInstruction mi : removeList) {
                mb.removeInstruction(mi);
            }
        }
    }
}

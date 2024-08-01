package backend.LivenessAnalyze;

import backend.ObjBuilder;
import backend.instruction.ObjInstruction;
import backend.module.ObjBlock;
import backend.module.ObjFunction;
import backend.operand.ObjRegister;

import java.util.HashMap;
import java.util.HashSet;

public class LivenessAnalyzer {
    private ObjFunction objFunction;

    private LivenessAnalyzer() {
    }

    private static LivenessAnalyzer instance = new LivenessAnalyzer();

    public static LivenessAnalyzer getInstance() {
        return instance;
    }

    public HashMap<ObjBlock, LivenessInfo> analyze(ObjFunction objFunction) {
        this.objFunction = objFunction;
        HashMap<ObjBlock, LivenessInfo> liveInfoMap = new HashMap<>();
        for (ObjBlock block : objFunction.getBlocks()) { // 计算 use 和 def
            LivenessInfo livenessInfo = new LivenessInfo();
            liveInfoMap.put(block, livenessInfo);
            for (ObjInstruction instr : block.getInstructions()) {
                HashSet<ObjRegister> use = instr.getUse();
                HashSet<ObjRegister> def = instr.getDef();
                for (ObjRegister r : use) {
                    if (!r.isAllocated() && !livenessInfo.getDef().contains(r)) {
                        livenessInfo.getUse().add(r);
                    }
                }
                for (ObjRegister r : def) {
                    if (!r.isAllocated()) {
                        livenessInfo.getDef().add(r);
                    }
                }
            }
            livenessInfo.getIn().addAll(livenessInfo.getUse());
        }

        // in[B] = use[B] ∪ (out[B] - def[B])    out[B] = ∪succ IN[S];
        /**
         * while(out 发生变化)
         * */
        boolean changed = true;
        while (changed) {
            changed = false;
            for (ObjBlock block : objFunction.getBlocks()) {
                LivenessInfo livenessInfo = liveInfoMap.get(block);
                HashSet<ObjRegister> newLiveOut = new HashSet<>();
                ObjBlock[] succs = ObjBuilder.getSucc(block.getName());
                if (succs[0] != null) {
                    LivenessInfo succBlockInfo = liveInfoMap.get(succs[0]);
                    newLiveOut.addAll(succBlockInfo.getIn());
                }
                if (succs[1] != null) {
                    LivenessInfo succBlockInfo = liveInfoMap.get(succs[1]);
                    newLiveOut.addAll(succBlockInfo.getIn());
                }
                HashSet<ObjRegister> oldin = new HashSet<>(livenessInfo.getIn());
                livenessInfo.setOut(newLiveOut);
                livenessInfo.setIn(new HashSet<>(livenessInfo.getUse()));
                livenessInfo.getOut().stream()
                        .filter(objOperand -> !livenessInfo.getDef().contains(objOperand))
                        .forEach(livenessInfo.getIn()::add);
                if (!oldin.equals(livenessInfo.getIn())) {
                    changed = true;
                }
            }
        }

        return liveInfoMap;
    }
}

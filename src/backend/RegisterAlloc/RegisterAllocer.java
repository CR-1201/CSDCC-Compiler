package backend.RegisterAlloc;

import backend.LivenessAnalyze.LivenessAnalyzer;
import backend.LivenessAnalyze.LivenessInfo;
import backend.instruction.ObjInstruction;
import backend.instruction.ObjLoad;
import backend.instruction.ObjMove;
import backend.instruction.ObjStore;
import backend.module.ObjBlock;
import backend.module.ObjFunction;
import backend.module.ObjModule;
import backend.operand.*;


import java.util.*;
import java.util.stream.Collectors;

/**
 * 这部分照着虎书实现的，慢慢再理解。。。。。
 */
public class RegisterAllocer {
    ObjModule mipsModule;
    private int K;
    HashSet<ObjRegister> precolored;
    HashSet<ObjRegister> initial;
    HashSet<ObjRegister> simplifyWorklist;
    HashSet<ObjRegister> freezeWorklist;
    HashSet<ObjRegister> spillWorklist;
    HashSet<ObjRegister> spilledNodes;
    HashSet<ObjRegister> coalescedNodes;
    HashSet<ObjRegister> coloredNodes;
    Stack<ObjRegister> selectStack;
    HashSet<ObjInstruction> coalescedMoves;
    HashSet<ObjInstruction> constrainedMoves;
    HashSet<ObjInstruction> frozenMoves;
    HashSet<ObjInstruction> worklistMoves;
    HashSet<ObjInstruction> activeMoves;
    HashSet<Edge> adjSet;
    HashMap<ObjRegister, HashSet<ObjRegister>> adjList;
    HashMap<ObjRegister, Integer> degree;
    HashMap<ObjRegister, HashSet<ObjInstruction>> moveList;
    HashMap<ObjRegister, ObjRegister> alias;
    HashMap<ObjRegister, Integer> color;
    HashMap<ObjBlock, LivenessInfo> livenessMap;

    private boolean type = true;    // float ?

    public void initDS(ObjFunction objFunction) {
        adjList = new HashMap<>();
        adjSet = new HashSet<>();
        alias = new HashMap<>();
        moveList = new HashMap<>();
        simplifyWorklist = new HashSet<>();
        freezeWorklist = new HashSet<>();
        spillWorklist = new HashSet<>();
        spilledNodes = new HashSet<>();
        coalescedNodes = new HashSet<>();
        selectStack = new Stack<>();
        worklistMoves = new HashSet<>();
        activeMoves = new HashSet<>();
        coalescedMoves = new HashSet<>();
        frozenMoves = new HashSet<>();
        constrainedMoves = new HashSet<>();
        degree = new HashMap<>();
        for (int i = 0; i < 16; i++) {
            degree.put(getRegister(i, type), Integer.MAX_VALUE);
            color.put(getRegister(i, type), i);
        }
    }

    private void init(ObjFunction objFunction) {
        precolored = new HashSet<>(getCanAllocRegister(type));
        initial = objFunction.getRegs(type);
        coloredNodes = new HashSet<>();
        color = new HashMap<>();
    }

    public RegisterAllocer(ObjModule mipsModule) {
        this.mipsModule = mipsModule;

    }

    public void alloc(boolean type) {
        this.type = type;
        if (type) K = ObjPhyRegister.getCanAllocRegister().size();
        else K = ObjFloatPhyReg.getCanAllocRegister().size();
        for (ObjFunction objFunction : mipsModule.getFunctions()) {
            init(objFunction);
            allocInFunc(objFunction);
            switchV2R(objFunction);
            storeReg(objFunction); // 用于记录现场，便于以后回复
            objFunction.refreshArgOff();
        }
    }

    private void storeReg(ObjFunction objFunction) {
        if (objFunction.getName().equals("main")) return;
        for (ObjBlock block : objFunction.getBlocks()) {
            for (ObjInstruction instr : block.getInstructions()) {
                for (ObjRegister reg : instr.getDef()) {
                    String rname = reg.getName();
                    if (needSave(rname, type)) {
                        objFunction.addToSavedRegisters(rname, type);
                    }
                }
            }
        }
    }

    private void switchV2R(ObjFunction func) {
        for (ObjBlock block : func.getBlocks()) {
            for (ObjInstruction instr : block.getInstructions()) {
                ArrayList<ObjRegister> defs = new ArrayList<>(instr.getDef());
                ArrayList<ObjRegister> uses = new ArrayList<>(instr.getUse());

                for (ObjRegister def : defs) {
                    if (color.containsKey(def) && !precolored.contains(def)) {
                        instr.updateReg(def, getRegister(color.get(def), type), false);
                    }
                }
                for (ObjRegister use : uses) {
                    if (color.containsKey(use) && !precolored.contains(use)) {
                        instr.updateReg(use, getRegister(color.get(use), type), true);
                    }
                }
            }

        }
    }

    private void allocInFunc(ObjFunction objFunction) {
        initDS(objFunction);
        livenessMap = LivenessAnalyzer.getInstance().analyze(objFunction);
        build(objFunction);
        makeWorklist();
        do {
            if (!simplifyWorklist.isEmpty()) Simplify();
            else if (!worklistMoves.isEmpty()) Coalesce();
            else if (!freezeWorklist.isEmpty()) Freeze();
            else if (!spillWorklist.isEmpty()) SelectSpill();
        } while (!simplifyWorklist.isEmpty() || !worklistMoves.isEmpty() || !freezeWorklist.isEmpty() || !spillWorklist.isEmpty());
        AssignColors();
        if (!spilledNodes.isEmpty()) {
            RewriteProgram(objFunction);
//            System.out.println(objFunction.toString());
            allocInFunc(objFunction);
        }
    }


    private void build(ObjFunction objFunction) {
        for (ObjBlock b : objFunction.getBlocks()) {
            HashSet<ObjRegister> live = new HashSet<>(livenessMap.get(b).getOut());
            for (int i = b.getInstructions().size() - 1; i >= 0; i--) {
                ObjInstruction I = b.getInstructions().get(i);
                if (I instanceof ObjMove && !((ObjMove) I).isHasImm()
                        && ((ObjMove) I).getRhs() instanceof Vir && ((ObjMove) I).getDst() instanceof Vir
                        && ((ObjMove) I).getRhs().getClass() ==  ((ObjMove) I).getDst().getClass()) {
                    ObjRegister rs = (ObjRegister) ((ObjMove) I).getRhs();
                    ObjRegister rd = (ObjRegister) ((ObjMove) I).getDst();
                    live.remove(rs);
                    moveList.putIfAbsent(rs, new HashSet<>());
                    moveList.putIfAbsent(rd, new HashSet<>());
                    moveList.get(rs).add(I);
                    moveList.get(rd).add(I);
                    worklistMoves.add(I);
                }
                for (ObjRegister d : I.getDef()) {
                    for (ObjRegister l : live) {
                        AddEdge(l, d);
                    }
                }
                HashSet<ObjRegister> def = I.getDef();
                HashSet<ObjRegister> use = I.getUse();
                def.forEach(live::remove);
                live.addAll(use);
            }
        }
    }

    private void AddEdge(ObjRegister u, ObjRegister v) {
        if (u.getClass() != v.getClass())
            return;
        Edge e = new Edge(u, v);
        if (!adjSet.contains(e) && !u.equals(v)) {
            adjSet.add(e);
            adjSet.add(e.reverse());
            if (!precolored.contains(u)) {
                adjList.putIfAbsent(u, new HashSet<>());
                adjList.get(u).add(v);
                if (degree.containsKey(u)) {
                    degree.compute(u, (key, value) -> value + 1);
                } else {
                    degree.put(u, 1);
                }
            }
            if (!precolored.contains(v)) {
                adjList.putIfAbsent(v, new HashSet<>());
                adjList.get(v).add(u);
                if (degree.containsKey(v)) {
                    degree.compute(v, (key, value) -> value + 1);
                } else {
                    degree.put(v, 1);
                }
            }
        }
    }

    private void makeWorklist() {
        HashSet<ObjRegister> temp = new HashSet<>(initial);
        for (ObjRegister n : temp) {
            initial.remove(n);
            if (degree.containsKey(n) && degree.get(n) >= K) {
                spillWorklist.add(n);
            } else if (MoveRelated(n)) {
                freezeWorklist.add(n);
            } else {
                simplifyWorklist.add(n);
            }
        }
    }

    private Set<ObjRegister> Adjacent(ObjRegister n) {
        if (adjList.containsKey(n))
            return adjList.get(n).stream()
                    .filter(v -> !(selectStack.contains(v) || coalescedNodes.contains(v)))
                    .collect(Collectors.toSet());
        else {
            return new HashSet<>();
        }
    }

    private Set<ObjInstruction> NodeMoves(ObjRegister n) {
        return moveList.getOrDefault(n, new HashSet<>()).stream().filter(v -> activeMoves.contains(v) || worklistMoves.contains(v)).collect(Collectors.toSet());
    }

    private boolean MoveRelated(ObjRegister n) {
        return !NodeMoves(n).isEmpty();
    }

    private void Simplify() {
        ObjRegister n = simplifyWorklist.stream().findFirst().get();
        simplifyWorklist.remove(n);
        selectStack.push(n);
        for (ObjRegister m : Adjacent(n)) {
            DecrementDegree(m);
        }
    }

    private void DecrementDegree(ObjRegister m) {
        int d = degree.getOrDefault(m, 0);
        degree.compute(m, (k, v) -> v - 1);
        if (d == K) {
            Set<ObjRegister> a = Adjacent(m);
            a.add(m);
            EnableMoves(a);
            spillWorklist.remove(m);
            if (MoveRelated(m)) {
                freezeWorklist.add(m);
            } else simplifyWorklist.add(m);
        }
    }

    private void EnableMoves(Set<ObjRegister> nodes) {
        for (ObjRegister n : nodes) {
            for (ObjInstruction m : NodeMoves(n)) {
                if (activeMoves.contains(m)) {
                    activeMoves.remove(m);
                    worklistMoves.add(m);
                }
            }
        }
    }

    private void Coalesce() {
        ObjInstruction m = worklistMoves.stream().findFirst().get();
        ObjRegister x = (ObjRegister) ((ObjMove) m).getDst();
        ObjRegister y = (ObjRegister) ((ObjMove) m).getRhs();
        x = GetAlias(x);
        y = GetAlias(y);
        ObjRegister u, v;
        if (precolored.contains(y)) {
            u = y;
            v = x;
        } else {
            u = x;
            v = y;
        }
        worklistMoves.remove(m);
        if (u.equals(v)) {
            coalescedMoves.add(m);
            AddWorkList(u);
        } else if (precolored.contains(v) || adjSet.contains(new Edge(u, v))) {
            constrainedMoves.add(m);
            AddWorkList(u);
            AddWorkList(v);
        } else if ((precolored.contains(u) && Adjacent(v).stream().allMatch(t -> OK(t, v))) || (!(precolored.contains(u) && Conservative(Adjacent(u), Adjacent(v))))) {
            coalescedMoves.add(m);
            Combine(u, v);
            AddWorkList(u);
        } else activeMoves.add(m);
    }


    private ObjRegister GetAlias(ObjRegister n) {
        if (coalescedNodes.contains(n)) {
            return GetAlias(alias.get(n));
        } else
            return n;
    }

    private void AddWorkList(ObjRegister u) {
        if (!precolored.contains(u) && !MoveRelated(u) && (!degree.containsKey(u) || degree.get(u) < K)) {
            freezeWorklist.remove(u);
            simplifyWorklist.add(u);
        }
    }

    private boolean OK(ObjRegister t, ObjRegister v) {
        return degree.getOrDefault(t, 0) < K || precolored.contains(t) || adjSet.contains(new Edge(t, v));
    }

    private boolean Conservative(Set<ObjRegister> nodes1, Set<ObjRegister> nodes2) {
        Set<ObjRegister> nodes = new HashSet<>(nodes1);
        nodes.addAll(nodes2);
        int k = 0;
        for (ObjRegister n : nodes) {
            if (degree.get(n) >= K)
                k++;
        }
        return k < K;
    }

    private void Combine(ObjRegister u, ObjRegister v) {
        if (freezeWorklist.contains(v)) {
            freezeWorklist.remove(v);
        } else
            spillWorklist.remove(v);
        coalescedNodes.add(v);
        alias.put(v, u);
        moveList.get(u).addAll(moveList.get(v));
        EnableMoves(new HashSet<>() {{
            add(v);
        }});
        for (ObjRegister t : Adjacent(v)) {
            AddEdge(t, u);
            DecrementDegree(t);
        }
        if (degree.getOrDefault(u, 0) >= K && freezeWorklist.contains(u)) {
            freezeWorklist.remove(u);
            spillWorklist.add(u);
        }
    }

    private void Freeze() {
        ObjRegister u = freezeWorklist.iterator().next();
        freezeWorklist.remove(u);
        simplifyWorklist.add(u);
        FreezeMoves(u);
    }

    private void FreezeMoves(ObjRegister u) {
        for (ObjInstruction m : NodeMoves(u)) {
            ObjRegister x = (ObjRegister) ((ObjMove) m).getDst();
            ObjRegister y = (ObjRegister) ((ObjMove) m).getRhs();
            ObjRegister v;
            ObjRegister ay = GetAlias(y), au = GetAlias(u);
            if (ay.equals(au)) {
                v = GetAlias(x);
            } else v = ay;
            activeMoves.remove(m);
            frozenMoves.add(m);
            if (NodeMoves(v).isEmpty() && degree.getOrDefault(v, 0) < K) {
                freezeWorklist.remove(v);
                simplifyWorklist.add(v);
            }
        }
    }

    private void SelectSpill() {
        ObjRegister m = spillWorklist.stream().findAny().get(); // 先随便找吧
        spillWorklist.remove(m);
        simplifyWorklist.add(m);
        FreezeMoves(m);
    }

    private void AssignColors() {
        while (!selectStack.isEmpty()) {
            ObjRegister n = selectStack.pop();
            HashSet<Integer> okColors = new HashSet<>(getCanIndexAllocRegister(type));
            for (ObjRegister w : adjList.getOrDefault(n, new HashSet<>())) {
                ObjRegister aw = GetAlias(w);
                if (coloredNodes.contains(aw) || precolored.contains(aw)) {
                    okColors.remove(color.get(aw));
                }
            }
            if (okColors.isEmpty()) spilledNodes.add(n);
            else {
                coloredNodes.add(n);
                int c = okColors.stream().findFirst().get();
                color.put(n, c);
            }
        }
        for (ObjRegister n : coalescedNodes) {
            ObjRegister an = GetAlias(n);
            color.put(n, color.get(an));
        }
    }

    private void RewriteProgram(ObjFunction objFunction) {
        HashSet<ObjRegister> newTemp = new HashSet<>();
        for (ObjRegister n : spilledNodes) {
//            int cntInstr = 0;
            for (ObjBlock block : objFunction.getBlocks()) {
                LinkedList<ObjInstruction> temp = new LinkedList<>(block.getInstructions());
                for (ObjInstruction instr : temp) {
                    ObjVirRegister vReg = null;
                    ObjInstruction firstUse = null;
                    ObjInstruction lastDef = null;
                    HashSet<ObjRegister> defs = new HashSet<>(instr.getDef());
                    HashSet<ObjRegister> uses = new HashSet<>(instr.getUse());
                    for (ObjRegister use : uses) {
                        if (use.equals(n)) {
                            if (firstUse == null && lastDef == null)
                                firstUse = instr;
                            if (vReg == null) {
                                vReg = new ObjVirRegister();
                                newTemp.add(vReg);
                            }
                            instr.updateReg(use, vReg, true);
                        }
                    }
                    for (ObjRegister def : defs) {
                        if (def.equals(n)) {
                            lastDef = instr;
                            if (vReg == null) {
                                vReg = new ObjVirRegister();
                                newTemp.add(vReg);
                            }
                            instr.updateReg(def, vReg, false);
                        }
                    }
                    if (lastDef != null) {
                        ObjStore store = new ObjStore(ObjPhyRegister.getRegister("sp"), vReg, new ObjImmediate(objFunction.getAllocSize()), false);
                        block.addInstructionAfter(lastDef, store);
                    }
                    if (firstUse != null) {
                        ObjLoad load = new ObjLoad(vReg, ObjPhyRegister.getRegister("sp"), new ObjImmediate(objFunction.getAllocSize()), false);
                        block.addInstructionBefore(firstUse, load);
                    }
                }
            }
            objFunction.addAllocSize(4);   // 开始以为在前面先加栈空间，后面发现会导致，寄存器溢出的时候可能会有一个保存的栈和新分配的位置重合,相当于往后位移了4
        }
        spilledNodes.clear();
        initial.clear();
        coalescedNodes.addAll(newTemp);
        coloredNodes.addAll(coalescedNodes);
        initial.addAll(coloredNodes);
        coalescedNodes.clear();
        coloredNodes.clear();
    }

    private ObjRegister getRegister(int num, boolean type) {
        if (type) {
            return ObjPhyRegister.getRegister(num);
        } else {
            return ObjFloatPhyReg.getRegister(num);
        }
    }

    private ObjRegister getRegister(String name, boolean type) {
        if (type) {
            return ObjPhyRegister.getRegister(name);
        } else {
            return ObjFloatPhyReg.getRegister(name);
        }
    }

    private static HashSet<ObjRegister> getCanAllocRegister(boolean type) {
        if (type) {
            return ObjPhyRegister.getCanAllocRegister();
        } else {
            return ObjFloatPhyReg.getCanAllocRegister();
        }
    }

    private boolean needSave(String name, boolean type) {
        if (type) {
            return ObjPhyRegister.needSave(name);
        } else {
            return ObjFloatPhyReg.needSave(name);
        }
    }
    private HashSet<Integer> getCanIndexAllocRegister(boolean type) {
        if (type) {
            return ObjPhyRegister.getCanIndexAllocRegister();
        } else {
            return ObjFloatPhyReg.getCanIndexAllocRegister();
        }
    }

}

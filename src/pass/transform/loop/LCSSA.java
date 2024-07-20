package pass.transform.loop;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import ir.types.DataType;
import pass.Pass;
import pass.analysis.Loop;
import utils.IOFunc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class LCSSA implements Pass {

    @Override
    public void run() {
        for (Function func : Module.getModule().getFunctionsArray()) {
            if (!func.getIsBuiltIn()) {
                runLCSSA(func);
            }
        }
    }

    /**
     * 在 LCSSA 之前一定要先进行循环分析和支配关系分析，不然可能会有问题
     * @param func 进行 lcssa 分析的函数
     */
    private void runLCSSA(Function func) {
        for (Loop topLoop : func.getTopLoops()) {
            addLoopPhi(topLoop);
        }
    }

    /**
     * dfs 遍历循环树，给每个循环添加循环 phi，实现 lcssa
     * @param loop 需要添加循环 phi 的循环
     */
    private void addLoopPhi(Loop loop) {
        for (Loop child : loop.getChildren()) {
            addLoopPhi(child);
        }
        if (!loop.getExits().isEmpty()) {
            for (BasicBlock block : loop.getAllBlocks()) {
                ArrayList<Instruction> insts = new ArrayList<>(block.getInstructions());
                for (Instruction inst : insts) {
                    if (isUsedOutside(inst, loop)) {
                        addPhiAtExit(inst, loop);
                    }
                }
            }
        }
    }

    /**
     * 指令 inst 是否在 循环外被使用
     * @param inst 指令
     * @param loop 循环
     * @return true/false
     */
    private Boolean isUsedOutside(Instruction inst, Loop loop) {
        for (User user : inst.getUsers()) {
            if (user instanceof Instruction i) {
                BasicBlock usedBlock = i.getParent();
                if (i instanceof Phi phi) {
                    int idx = phi.getOperators().indexOf(inst);
                    usedBlock = (BasicBlock) phi.getOperator(idx + phi.getPrecursorNum());
                }
                if (!loop.getAllBlocks().contains(usedBlock)) {
                    return true;
                }
            }
        }
        return false;
    }

    HashMap<BasicBlock, Phi> exit2phi = new HashMap<>();
    private void addPhiAtExit(Instruction inst, Loop loop) {
        exit2phi.clear();
        BasicBlock block = inst.getParent();
        for (BasicBlock exit : loop.getExits()) {
            HashSet<BasicBlock> domers = exit.getDomers();
            if (!exit2phi.containsKey(exit) && domers.contains(block)) {
                Phi phi = IrBuilder.getIrBuilder().buildPhi((DataType) inst.getValueType(), exit);
                for (BasicBlock prec : exit.getPrecursors()) {
                    phi.addIncoming(inst, prec);
                }
                /**
                 * ATTENTION:
                 * 这里的 Phi 指令不需要 insertHead，因为构造方法里面已经 insert 了。
                 * 因为没看函数，虚空 Debug。
                 */
                exit2phi.put(exit, phi);
            }
        }
        ArrayList<User> users = new ArrayList<>(inst.getUsers());
        for (User user : users) {
            if (user instanceof Instruction i) {
                BasicBlock usedBlock = i.getParent();
                if (i instanceof Phi phi) {
                    int idx = phi.getOperators().indexOf(inst);
                    usedBlock = (BasicBlock) phi.getOperator(idx + phi.getPrecursorNum());
                }
                if (usedBlock == block || loop.getAllBlocks().contains(usedBlock)){
                    continue;
                }
                Phi phi = searchPhi(usedBlock, loop);
                i.replaceOperator(inst, phi);
            }
        }
    }

    private Phi searchPhi(BasicBlock usedBlock, Loop loop) {
        if (exit2phi.get(usedBlock) != null) {
            return exit2phi.get(usedBlock);
        }
        BasicBlock idomer = usedBlock.getIDomer();
        if (!loop.getAllBlocks().contains(idomer)) {
            Phi value = searchPhi(idomer, loop);
            exit2phi.put(usedBlock, value);
            return value;
        }
        Phi phi = IrBuilder.getIrBuilder().buildPhi(usedBlock);
        for (BasicBlock prec : usedBlock.getPrecursors()) {
            phi.addIncoming(searchPhi(prec, loop), prec);
        }
        exit2phi.put(usedBlock, phi);
        return phi;
    }
}

package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.IrBuilder;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.VoidType;
import pass.Pass;
import pass.transform.UselessReturnEmit;

import java.util.ArrayList;
import java.util.BitSet;
import java.util.Collections;
import java.util.HashSet;

public class RDOM implements Pass {

    private final Module irModule = Module.getModule();

    private final IrBuilder irBuilder = IrBuilder.getIrBuilder();

    @Override
    public void run() {

        for (Function function : irModule.getFunctionsArray()) {
            mergeExit(function);
        }

//        new CFG().run();
//        new Dom().run();
//
//        for (Function function : irModule.getFunctionsArray()) {
//            if (!function.getIsBuiltIn()) {
//                buildRDom(function);
//            }
//        }
    }

    private void buildRDom(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            block.getRDoms().clear();
            block.getIRdoms().clear();
            block.getRDominanceFrontier().clear();
        }
        rDomINfo(function);
        rDomLevel(function.getFinalExitBlock(), 0);
        rDominanceFrontier(function);
    }

    private ArrayList<BasicBlock> orders = new ArrayList<>();
    private ArrayList<BasicBlock> rpos = new ArrayList<>();
    private HashSet<BasicBlock> visited = new HashSet<>();

    private void rDomINfo(Function function) {
        BasicBlock entry = function.getFinalExitBlock();
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        ArrayList<BitSet> rDomers = new ArrayList<>();
        int size = blocks.size();

        rpos = computeReversePostOrder(entry);

        for (int i = 0; i < size; i++) {
            rDomers.add(new BitSet());
            if (i == 0) {
                rDomers.get(i).set(0);
            } else {
                rDomers.get(i).set(0, rpos.size());
            }
        }

        boolean flag = true;
        while (flag) {
            flag = false;
            for (BasicBlock rpo : rpos) {
                if (rpo == entry) {
                    continue;
                }
                BitSet temp = new BitSet();
                temp.set(0, size);
                for (BasicBlock prec : rpo.getRPrecursors()) {
                    int precIdx = rpos.indexOf(prec);
                    temp.and(rDomers.get(precIdx));
                }
                int idx = rpos.indexOf(rpo);
                temp.set(idx);
                if (!temp.equals(rDomers.get(idx))) {
                    flag = true;
                    rDomers.get(idx).clear();
                    rDomers.get(idx).or(temp);
                }
            }
        }
        for (int i = 0; i < rpos.size(); i++) {
            BasicBlock block = rpos.get(i);
            BitSet rDomer = rDomers.get(i);
            for (int domerIndex = rDomer.nextSetBit(0); domerIndex >= 0;
                 domerIndex = rDomer.nextSetBit(domerIndex + 1)) {
                BasicBlock domerBlock = rpos.get(domerIndex);
                block.addRDomer(domerBlock);
            }
        }
        for (BasicBlock block : blocks) {
            for (BasicBlock domer : block.getRDomers()) {
                if (isIRdomer(domer, block)) {
                    block.setIRdomer(domer);
                    domer.addIRdom(block);
                    break;
                }
            }
        }
    }

    public ArrayList<BasicBlock> computeReversePostOrder(BasicBlock entry) {
        visited.clear();
        orders.clear();
        dfsWalk(entry);
        Collections.reverse(orders);
        return orders;
    }

    private void dfsWalk(BasicBlock block) {
        visited.add(block);
        for (BasicBlock succ : block.getRSuccessors()) {
            if (!visited.contains(succ)) {
                dfsWalk(succ);
            }
        }
        orders.add(block);
    }

    private Boolean isIRdomer(BasicBlock domer, BasicBlock domee) {
        if (domer.equals(domee)) return false;
        for (BasicBlock bb : domee.getRDomers()) {
            if (!bb.equals(domer) && !bb.equals(domee) && bb.getRDomers().contains(domer)) {
                return false;
            }
        }
        return true;
    }

    private void rDomLevel(BasicBlock block, int level) {
        block.setRDomLevel(level);
        for (BasicBlock idom : block.getIRdoms()) {
            rDomLevel(idom, level + 1);
        }
    }

    private void rDominanceFrontier(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (BasicBlock prec : block.getRPrecursors()) {
                BasicBlock runner = prec;
                // 满足严格支配
                while (runner == block || !block.getRDomers().contains(runner)) {
                    runner.addRDominanceFrontier(block);
                    runner = runner.getIRDomer();
                }
            }
        }
    }

    private void mergeExit(Function function) {
        if (function.getIsBuiltIn()) {
            return;
        }

        HashSet<Ret> returns = new HashSet<>();

        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (Instruction instruction : block.getInstructionsArray()) {
                if (instruction instanceof Ret retInstr) {
                    returns.add(retInstr);
                }
            }
        }

        System.out.println(function.getName());
        System.out.println(returns.size());
        System.out.println();

        BasicBlock finalBlock = irBuilder.buildBasicBlock(function);

        for (Ret retInstr : returns) {
            Br brToExit = irBuilder.buildBr(retInstr.getParent(), finalBlock);
            retInstr.replaceAllUsesWith(brToExit);
        }

        if (function.getReturnType() instanceof VoidType) {
            irBuilder.buildRet(finalBlock);
        } else {
            Phi exitPhi = irBuilder.buildPhi(function.getReturnType(), finalBlock, returns.size());
            for (Ret retInstr : returns) {
                exitPhi.addIncoming(retInstr.getRetValue(), retInstr.getParent());
            }
            irBuilder.buildRet(finalBlock, exitPhi);
        }

        for (Ret retInstr : returns) {
            retInstr.removeSelf();
        }

        function.setFinalExitBlock(finalBlock);
    }

}

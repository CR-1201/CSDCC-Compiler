package pass.transform.branch;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Icmp;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Switch;
import pass.Pass;
import pass.analysis.CFG;
import pass.analysis.Dom;
import utils.IOFunc;
import utils.Pair;

import java.util.*;

/**
 * 还有一点 Bug，不是特别好处理这个问题。
 */
public class Branch2Switch implements Pass {
    private final CFG cfg = new CFG();
    private final Dom dom = new Dom();
    /**
     * caseChain: case 转移表
     * value: case 对应的跳转值
     * Pair<BasicBlock, BasicBlock>： 前一个 BasicBlock 代表 Equal 时跳转的块，后一个 BasicBlock 代表被忽略的块，但是由于可能涉及到提前需要计算一些东西，所以需要暂时存储记录
     */
    private final HashMap<Value, Pair<BasicBlock, BasicBlock>> caseChain = new HashMap<>();
    private final HashMap<Value, Pair<BasicBlock, BasicBlock>> caseCandidateChain = new HashMap<>();
    private Value switchCase = null;
    /**
     * if-else 终止的块
     * 1、如果有else -> 正常
     * 2、如果没有else，那么这个 endBlock 就是最后一个 else if 判断的块
     */
    private BasicBlock endBlock = null;
    private boolean changed = false;

    private HashSet<BasicBlock> visited = new HashSet<>();
    @Override
    public void run() {
        for (Function function : Module.getModule().getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                do {
                    changed = false;
                    visited.clear();
                    cfg.buildCFG(function);
                    dom.buildDom(function);
                    handleBranch2Switch(function);
                } while (changed);
            }
        }
    }

    private void handleBranch2Switch(Function function) {
        ArrayList<BasicBlock> blocks = dom.getDomTreePostOrder(function);
        Collections.reverse(blocks);
        for (BasicBlock block : blocks) {
            switchCase = null;
            if (visited.contains(block)) {
                continue;
            }
            if (canSwitch(block)) {
                endBlock = null;
                caseChain.clear();
                // 找到了可以被 switch 的第一个块
                matchCaseChain(block);
                if (changed) {
                    return;
                }
            }
        }
    }

    private void matchCaseChain(BasicBlock block) {
        BasicBlock defaultBlock = null;
        Br br = (Br) block.getTailInstruction();
        Icmp icmp = (Icmp) br.getCond();
        caseChain.put(getCaseEqualTo(icmp), new Pair<>(br.getTrueBlock(), br.getFalseBlock()));
        BasicBlock matchingBlock = br.getFalseBlock();
        endBlock = block;
        while (true) {
            if (!matchingBlock.getPhis().isEmpty()) {
                defaultBlock = matchingBlock;
                break;
            }
            if (!(matchingBlock.getTailInstruction() instanceof Br tmpBr && tmpBr.getHasCondition())) {
                defaultBlock = matchingBlock;
                break;
            }
            icmp = (Icmp) tmpBr.getCond();
            caseChain.put(getCaseEqualTo(icmp), new Pair<>(tmpBr.getTrueBlock(), tmpBr.getFalseBlock()));
            endBlock = matchingBlock;
            matchingBlock = tmpBr.getFalseBlock();
        }
        // 限制一下，4 个 if-else 以上再进行 branch2switch 的优化
        if (caseChain.size() < 3) {
            return;
        }
        // 下面就是开始操作 switch 指令
        // 先删除两个指令
        ArrayList<Instruction> insts = block.getInstructionsArray();
        int size = insts.size();
        for (int i = size - 2; i < size; i++) {
            Instruction inst = insts.get(i);
            if (!(inst instanceof Br || inst instanceof Icmp)) {
                continue;
            } else if (inst instanceof Icmp icmp1 && icmp1 != (Icmp) br.getCond()) {
                continue;
            }
            inst.removeSelf();
        }
        HashMap<Value, BasicBlock> case2block = new HashMap<>();
        for (Map.Entry<Value, Pair<BasicBlock, BasicBlock>> entry : caseChain.entrySet()) {
            case2block.put(entry.getKey(), entry.getValue().getFirst());
        }
        Switch si = new Switch(block, switchCase, defaultBlock, case2block);
        block.insertTail(si);
        if (!defaultBlock.getPhis().isEmpty()) {
            for (Phi phi : defaultBlock.getPhis()) {
                phi.replaceOperator(endBlock, block);
            }
        }
        changed = true;
    }

    private Value getCaseEqualTo(Icmp icmp) {
        return icmp.getOperator(0) == switchCase ? icmp.getOperator(1) : icmp.getOperator(0);
    }

    /**
     * 找到了可以作为被 switch 的 if 的第一个块
     */
    private Boolean canSwitch(BasicBlock block) {
        caseCandidateChain.clear();
        findCaseCandidate(block);
        for (Map.Entry<Value, Pair<BasicBlock, BasicBlock>> entry : caseCandidateChain.entrySet()) {
            visited.add(((Icmp) entry.getKey()).getParent());
            visited.add(entry.getValue().getFirst());
            visited.add(entry.getValue().getSecond());
        }
        if (block.isLoopHeader()) {
            return false;
        }
        if (!(block.getTailInstruction() instanceof Br br && br.getHasCondition())) {
            return false;
        }
        Icmp icmp = (Icmp) br.getCond();
        if (!icmp.getCondition().equals(Icmp.Condition.EQ)) {
            return false;
        }
        if (!(icmp.getOperator(0) instanceof ConstInt || icmp.getOperator(1) instanceof ConstInt)) {
            return false;
        }
        Value switchCandidate = icmp.getOperator(0) instanceof ConstInt ? icmp.getOperator(1) : icmp.getOperator(0);
        BasicBlock matchingBlock = br.getFalseBlock();
        boolean matchResult = true;
        while (true) {
            if (!matchingBlock.getPhis().isEmpty()) {
                break;
            }
            if (!(matchingBlock.getTailInstruction() instanceof Br tmpBr && tmpBr.getHasCondition())) {
                break;
            }
            if (!(icmp.getOperator(0) instanceof ConstInt || icmp.getOperator(1) instanceof ConstInt)) {
                matchResult = false;
            }
            icmp = (Icmp) tmpBr.getCond();
            if (icmp.getCondition().equals(Icmp.Condition.EQ) && icmp.getOperators().contains(switchCandidate)) {
                matchingBlock = tmpBr.getFalseBlock();
            } else if (!icmp.getCondition().equals(Icmp.Condition.EQ)) {
                matchResult = false;
                break;
            } else if (!icmp.getOperators().contains(switchCandidate)) {
                matchResult = false;
                break;
            }
        }
        if (matchResult) {
            switchCase = switchCandidate;
        }
        return matchResult;
    }

    private void findCaseCandidate(BasicBlock block) {
        if (!(block.getTailInstruction() instanceof Br br && br.getHasCondition())) {
            return;
        }
        Icmp icmp = (Icmp) br.getCond();
        BasicBlock matchingBlock = br.getFalseBlock();
        caseCandidateChain.put(icmp, new Pair<>(br.getTrueBlock(), br.getFalseBlock()));
        while (true) {
            if (!matchingBlock.getPhis().isEmpty()) {
                break;
            }
            if (!(matchingBlock.getTailInstruction() instanceof Br tmpBr && tmpBr.getHasCondition())) {
                break;
            }
            matchingBlock = tmpBr.getFalseBlock();
            icmp = (Icmp) tmpBr.getCond();
            caseCandidateChain.put(icmp, new Pair<>(tmpBr.getTrueBlock(), tmpBr.getFalseBlock()));
        }
    }
}

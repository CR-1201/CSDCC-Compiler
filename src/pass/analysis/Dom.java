package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import pass.Pass;

import java.util.*;

public class Dom implements Pass {
    private final Module module = Module.getModule();
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                buildDom(function);
            }
        }
    }

    /**
     * 支配树，是相对于每一个函数来说的，因此分别针对每一个函数来建立支配树即可
     * 设置为 public，是为了在某些情况下，只需要重新计算某一个函数的支配树。
     * @param function 建立支配树的函数
     */
    public void buildDom(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            block.getDoms().clear();
            block.getIdoms().clear();
            block.getDominanceFrontier().clear();
        }
        // 计算dom信息
        domInfo(function);
        // 计算每个块在支配树中的深度
        domLevel(function.getFirstBlock(), 0);
        // 计算支配边界
        dominanceFrontier(function);
//        printDOM(function);
    }

    // 用来存储遍历结果的列表
    private ArrayList<BasicBlock> orders = new ArrayList<>();
    // 图的逆后序 reserve post-order
    private ArrayList<BasicBlock> rpos = new ArrayList<>();
    // 进行标记
    private HashSet<BasicBlock> visited = new HashSet<>();
    /**
     * 支配(dominate)：
     * 如果 CFG 中从起始节点到基本块 y 的所有路径都经过了基本块 x，我们说 x 支配 y。
     * 【主要方法，参考https://oi-wiki.org/graph/dominator-tree/】
     * 一个点的支配点的点集为它所有前驱结点的支配点集的交集，再并上它本身。根据这个方程将每个结点上的支配点集不断迭代直至答案不变即可。
     * 为了提高效率，我们希望每轮迭代时，当前迭代的结点的所有前驱结点尽可能都已经执行完了这次迭代，
     * 因此我们要利用深度优先排序得出这个图的逆后序，根据这个顺序进行迭代。
     * 直接支配(i dominate)：
     * 严格支配 n，且不严格支配任何严格支配 n 的节点的节点(直观理解就是所有严格支配 n 的节点中离 n 最近的那一个)，我们称其为 n 的直接支配者
     * @param function 需要计算支配信息的函数
     */
    private void domInfo(Function function) {
        BasicBlock entry = function.getFirstBlock();
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        ArrayList<BitSet> domers = new ArrayList<>();
        int size = blocks.size();
        // 先建立图的逆后序
        /**
         * 为什么要使用逆后序：
         * 在对当前节点（BasicBlock）进行求值之前，当前节点的所有前驱节点（BasicBlock）在本次迭代中都应该求值完成，
         * 否则还要放到下次迭代来进行值的更新，这要会增加一次迭代过程。
         */
        rpos = computeReversePostOrder(entry);
        for (int i = 0; i < size; i++) {
            domers.add(new BitSet());
            if (i == 0) {
                domers.get(i).set(0);
            } else {
                domers.get(i).set(0, rpos.size());
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
                for (BasicBlock prec : rpo.getPrecursors()) {
                    int precIdx = rpos.indexOf(prec);
                    temp.and(domers.get(precIdx));
                }
                int idx = rpos.indexOf(rpo);
                temp.set(idx);
                if (!temp.equals(domers.get(idx))) {
                    flag = true;
                    domers.get(idx).clear();
                    domers.get(idx).or(temp);
                }
            }
        }
        // 设置每一个块的支配者
        for (int i = 0; i < rpos.size(); i++) {
            BasicBlock block = rpos.get(i);
            BitSet domer = domers.get(i);
            for (int domerIndex = domer.nextSetBit(0); domerIndex >= 0;
                 domerIndex = domer.nextSetBit(domerIndex + 1)) {
                BasicBlock domerBlock = rpos.get(domerIndex);
                block.addDomer(domerBlock);
            }
        }
        // 查找直接支配者
        for (BasicBlock block : blocks) {
            for (BasicBlock domer : block.getDomers()) {
                if (isIdomer(domer, block)) {
                    // 一个基本块的直接支配者有且仅有一个块
                    block.setIdomer(domer);
                    domer.addIdom(block);
                    break;
                }
            }
        }
    }

    /**
     * 获取逆后序
     * @param entry 入口基本块
     * @return 逆后序
     */
    public ArrayList<BasicBlock> computeReversePostOrder(BasicBlock entry) {
        visited.clear();
        orders.clear();
        dfsWalk(entry);
        Collections.reverse(orders);
        return orders;
    }

    /**
     * dfs
     * @param block dfs遍历的block
     */
    private void dfsWalk(BasicBlock block) {
        visited.add(block);
        for (BasicBlock succ : block.getSuccessors()) {
            if (!visited.contains(succ)) {
                dfsWalk(succ);
            }
        }
        orders.add(block);
    }

    /**
     * 判断domer是否是domee的直接支配者
     * @param domer 支配者
     * @param domee 被支配者
     * @return true or false
     */
    private Boolean isIdomer(BasicBlock domer, BasicBlock domee) {
        if (domer.equals(domee)) return false;
        for (BasicBlock bb : domee.getDomers()) {
            if (!bb.equals(domer) && !bb.equals(domee) && bb.getDomers().contains(domer)) {
                return false;
            }
        }
        return true;
    }

    private void domLevel(BasicBlock block, int level) {
        block.setDomLevel(level);
        for (BasicBlock idom : block.getIdoms()) {
            domLevel(idom, level + 1);
        }
    }

    /**
     * 支配边界：支配边界是一系列节点的集合，记为 W。某节点 x 的支配边界应满足如下条件，x 是 w 的前驱节点，但 x 不是 w 的严格支配节点
     * 直观解释支配边界就是所有最近不能被 n 严格支配的节点的集合
     * @param function 需要计算支配边界的函数
     */
    private void dominanceFrontier(Function function) {
        for (BasicBlock block : function.getBasicBlocksArray()) {
            for (BasicBlock prec : block.getPrecursors()) {
                BasicBlock runner = prec;
                // 满足严格支配
                while (runner == block || !block.getDomers().contains(runner)) {
                    runner.addDominanceFrontier(block);
                    runner = runner.getIDomer();
                }
            }
        }
    }

    /**
     * 获得支配树的后序遍历结果
     * @param function 待求解的函数
     * @return 支配树的后序遍历结果
     */
    public ArrayList<BasicBlock> getDomTreePostOrder(Function function) {
        ArrayList<BasicBlock> postOrder = new ArrayList<>();
        // 如果后继全部加进去了，那么就是 true，只有这样，才可以开始访问当前节点
        HashSet<BasicBlock> canVisit = new HashSet<>();
        Stack<BasicBlock> stack = new Stack<>();
        // 这是因为头块一定也是支配树的根节点
        stack.add(function.getFirstBlock());
        // 栈式 dfs
        while (!stack.isEmpty()) {
            BasicBlock parent = stack.peek();
            // 子节点被遍历完成
            if (canVisit.contains(parent)) {
                // 那么就加入结果
                postOrder.add(parent);
                stack.pop();
                continue;
            }
            // 如果没有遍历完成，就遍历 idomee
            for (BasicBlock idomee : parent.getIdoms()) {
                stack.push(idomee);
            }
            // 子节点已经全部入栈，表示已经遍历完成了
            canVisit.add(parent);
        }
        return postOrder;
    }

    private void printDOM(Function curFunction)
    {
        for (BasicBlock basicBlock : curFunction.getBasicBlocksArray())
        {
            System.out.println("blockName: " + basicBlock.getName());
            System.out.println("domers: ");
            for (BasicBlock predecessor : basicBlock.getDomers())
            {
                System.out.println("\t" + predecessor.getName());
            }
            System.out.println("idomer: ");
            if (basicBlock.getIDomer() != null) {
                System.out.println("\t" + basicBlock.getIDomer().getName());
            } else {
                System.out.println("NULL");
            }
            System.out.println("idoms: ");
            for (BasicBlock successor : basicBlock.getIdoms())
            {
                System.out.println("\t" + successor.getName());
            }
            System.out.println("DomLevel: " + basicBlock.getDomLevel());
            System.out.println("DominanceFrontiers: ");
            for (BasicBlock df : basicBlock.getDominanceFrontier()) {
                System.out.println("\t" + df.getName());
            }
        }
    }
}

package pass.transform;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.otherInstructions.Phi;
import pass.Pass;

import java.util.*;

import static pass.analysis.Dom.getDomTreePostOrder;

/**
 @author Conroy
 Global Value Numbering 全局值编号
 */
public class GVN implements Pass {

    private final Module module = Module.getModule();

    private final HashMap<Value, Value> valueNumber = new HashMap<>();

    // reverse post-order traversal
    ArrayList<BasicBlock> reversePostOrder = new ArrayList<>();
    // 后续 visited
    HashSet<BasicBlock> visited = new HashSet<>();

    @Override
    public void run(){
        for(Function function : module.getFunctionsArray() ){
            if (!function.getIsBuiltIn())  {
                functionGVN(function);
            }
        }
    }

    private void reversePostOrder(BasicBlock block){
        visited.add(block);
        for( BasicBlock temp : block.getSuccessors() ){
            if( !visited.contains(temp) ){
                reversePostOrder(temp);
            }
        }
        reversePostOrder.add(block);
    }
    /**
     * 对函数进行 GVN: 首先对函数中的块进行逆后序遍历
     * 在遍历指令的时候,不会出现未定义就使用的情况
     */
    private void functionGVN(Function function) {
        valueNumber.clear();

        // 这里做的是一个压栈，类似与手动 dfs
        Stack<BasicBlock> stack = new Stack<>();
        // pre oder
        ArrayList<BasicBlock> preOder = new ArrayList<>();
        // 后续 visited
        HashSet<BasicBlock> visited = new HashSet<>();
        // 入口块入栈
        stack.push(function.getFirstBlock());
        visited.add(function.getFirstBlock());
        while (!stack.isEmpty()) {
            BasicBlock curBlock = stack.pop();
            preOder.add(curBlock);
            for (BasicBlock child : curBlock.getSuccessors()) {
                if (!visited.contains(child)) {
                    stack.push(child);
                    visited.add(child);
                }
            }
        }
//        reversePostOrder(function.getFirstBlock());

//        Collections.reverse(reversePostOrder);
        // 逆后序遍历
        for(BasicBlock block : preOder){
            basicBlockGVN(block);
        }
    }

    private void basicBlockGVN(BasicBlock block) {
        // 当前块的最后一个指令
        Instruction tailInstruction = block.getTailInstruction();

        // 去掉一些没有必要的phi
        int i = 0, j;
        while( i < block.getInstructionsArray().size() ){
            Instruction curInstruction = block.getInstructionsArray().get(i);
            // 只在 phi 节点继续,消掉一些不必要的 phi
            // 因为 phi 指令只存在于块的开头
            if( !(curInstruction instanceof Phi) ){
                break;
            }

            j = i+1;
            while( j < block.getInstructionsArray().size() ){
                Instruction nextInstruction = block.getInstructionsArray().get(j);

                if( !(nextInstruction instanceof Phi) ){
                    break;
                }
                // 针对两条phi进行讨论
                if( ((Phi)curInstruction).getPrecursorNum() == ((Phi)nextInstruction).getPrecursorNum() ){
                    // 相同则删除多余的phi
                    boolean reduceFlag = true;
                    for( int k = 0 ; k < ((Phi)curInstruction).getPrecursorNum() ; k++ ){
                        if ( curInstruction.getOperator(k) != nextInstruction.getOperator(k) ) {
                            reduceFlag = false;
                            break;
                        }
                    }
                    // 如果phi相同, 删掉即可
                    if( reduceFlag ){
                        curInstruction.replaceAllUsesWith(nextInstruction);
                        curInstruction.removeAllOperators();
                        curInstruction.eraseFromParent();
                        break;
                    }
                }
                j++;
            }
            // FIXME 这里只能加1 类似于双层循环
            i++;
        }

        // 重新遍历,进行 instructionGVN
        i = 0;
        while(i < block.getInstructionsArray().size()){
            Instruction curInstruction = block.getHeadInstruction();
            instructionGVN(curInstruction);
            // FIXME 这里有必要break吗？
            if( curInstruction.equals(tailInstruction) )break;
            i++;
        }

    }

    /**
     * 根据指令类型进行讨论
     * @param curInstruction 遍历的指令
     */
    private void instructionGVN(Instruction curInstruction) {
        if( labeledCheck(curInstruction) ){
            Value value = findValueNumber(curInstruction);
            // 替代值
            replaceValue(curInstruction, value);
        }
    }

    /**
     * 最关键的方法，查找 valueNumber
     * @param lookUp 查询 value
     * @return 一个可以用的 value
     */
    private Value findValueNumber(Value lookUp) {
        // 通过遍历查找
        if (valueNumber.containsKey(lookUp)) {
            return valueNumber.get(lookUp);
        }
        // Not found, add
        Value value = allocNumber(lookUp);
        valueNumber.put(lookUp, value);
        return value;
    }

    private Value allocNumber(Value lookUp) {
        if( lookUp instanceof BinaryInstruction ){
            return allocNumber4Bin((BinaryInstruction)lookUp);
        } else if( lookUp instanceof GEP) {
            return allocNumber4GEP((GEP)lookUp);
        } else return lookUp;
    }

    private Value allocNumber4Bin(BinaryInstruction curInstruction) {
        Value leftValue = findValueNumber(curInstruction.getOp1());
        Value rightValue = findValueNumber(curInstruction.getOp2());

        for (Map.Entry<Value, Value> entry : valueNumber.entrySet()){
            Value key = entry.getKey();
            Value valueNumber = entry.getValue();
            // 如果同样是二进制指令
            if( key instanceof BinaryInstruction binaryInstruction && !key.equals(curInstruction)){
                Value _leftValue = findValueNumber(binaryInstruction.getOp1());
                Value _rightValue = findValueNumber(binaryInstruction.getOp2());
                boolean op = BinaryInstruction.isSameOp(binaryInstruction,curInstruction);
                boolean operand = (leftValue.equals(_leftValue) && rightValue.equals(_rightValue)) ||
                        (leftValue.equals(_rightValue) && rightValue.equals(_leftValue) && curInstruction.isCommutative());
                if( op && operand ){
                    return valueNumber;
                }
            }
        }
        return curInstruction;
    }

    private Value allocNumber4GEP(Instruction curInstruction) {
        for (Map.Entry<Value, Value> entry : valueNumber.entrySet()){
            Value value = entry.getValue();
            if( value instanceof GEP ){
                if( compareOperands((User) value, curInstruction) ){
                    return value;
                }
            }
        }
        return curInstruction;
    }

    private boolean compareOperands(User userA, User userB){
        if( userA.getNumOfOps() != userB.getNumOfOps() ){
            return false;
        } else{
            for( int i = 0 ; i < userA.getNumOfOps() ; i++ ){
                Value value1 = userA.getOperator(i);
                Value value2 = userB.getOperator(i);
                if( !value1.equals(value2) ){
                    return false;
                }
            }
            return true;
        }
    }

    private boolean labeledCheck(Instruction instruction) {
        return !instruction.getUsers().isEmpty();
    }

    private void replaceValue(Instruction instruction, Value replacement) {
        if( !instruction.equals(replacement) ){
            valueNumber.remove(instruction);
            instruction.replaceAllUsesWith(replacement);
            instruction.removeAllOperators();
            instruction.eraseFromParent();
        }
    }

}

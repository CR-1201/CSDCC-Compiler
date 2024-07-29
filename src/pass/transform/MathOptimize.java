package pass.transform;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Add;
import ir.types.FloatType;
import ir.types.IntType;
import pass.Pass;

import java.util.ArrayList;

import static ast.Node.builder;

/**
 @author Conroy
 (1) 连续的加法转化成乘法 ---> a + a + a + a = a * 4
 (2) TODO : a + 2 + a + 2 + a + 2 + a + 2 = a * 4 + 2 * 4
 */
public class MathOptimize implements Pass {
    private final Module module = Module.getModule();

    private ArrayList<Add> addsToMul = new ArrayList<>();

    @Override
    public void run() {
        continueAdd2Mul();
    }

    // 连续的加法转化成乘法 ---> a + a + a + a = a * 4
    // b + a + a + a + a = b + a * 4
    private void continueAdd2Mul() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                // 只针对一个块遍历
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (int i = 0; i < instructions.size(); i++) {
                    Instruction curInst = instructions.get(i);
                    if (curInst instanceof Add curAdd && i < instructions.size() - 1) {
                        Instruction nextInst = instructions.get(i + 1);
                        // 连续加法转乘法的启动条件
                        if (nextInst instanceof Add nextAdd) {
                            Value curLeftOp = curAdd.getOp1(),curRightOp = curAdd.getOp2();
                            Value nextLeftOp = nextAdd.getOp1(), nextRightOp = nextAdd.getOp2();
                            // %v19 = add i32 %v13, %v7
                            // %v25 = add i32 %v19, %v7
                            // 严谨一点的话需要检查每条add指令只有唯一user
                            if( curInst.equals(nextLeftOp) && curRightOp.equals(nextRightOp) ){
                                addsToMul.clear();
                                i = beginAdd2Mul(i,instructions,block);
                            }
                        }
                    }
                }
            }
        }
    }

    private int beginAdd2Mul(int i,ArrayList<Instruction> instructions,BasicBlock block) {
        int size = instructions.size(), j = i;
        Value beginLeftOp = ((Add)instructions.get(i)).getOp1();
        Value multer = ((Add)instructions.get(i)).getOp2();
        while( i < size ){
            Add curAdd = (Add) instructions.get(i), nextAdd;
            addsToMul.add(curAdd);
            if( i < size - 1 && instructions.get(i+1) instanceof Add ){
                nextAdd = (Add) instructions.get(i+1);
            } else break;

            Value curRightOp = curAdd.getOp2();
            Value nextLeftOp = nextAdd.getOp1(), nextRightOp = nextAdd.getOp2();

            if( curAdd.equals(nextLeftOp) && curRightOp.equals(nextRightOp) ){
                i++;
            } else break;
        }
        int num = addsToMul.size();

        // 加法次数太少,直接忽略
        if( num < 20 ){
            return j;
        }

        for( int k = 0; k < addsToMul.size() - 1; k++ ){
            Instruction curInst = addsToMul.get(k);
            curInst.removeSelf();
        }
        Instruction lastInst = addsToMul.get(num - 1);

        if( beginLeftOp.equals(multer) ){
            if( multer.getValueType() instanceof IntType ){
                Value value = builder.buildMulBeforeInstr(block, new IntType(32),multer,new ConstInt(num+1),lastInst);
                lastInst.replaceAllUsesWith(value);
                lastInst.removeSelf();
            } else if( multer.getValueType() instanceof FloatType){
                Value value = builder.buildMulBeforeInstr(block, new FloatType(),multer,new ConstFloat((float) (num+1)),lastInst);
                lastInst.replaceAllUsesWith(value);
                lastInst.removeSelf();
            }
        } else {
            if( multer.getValueType() instanceof IntType ){
                Value value = builder.buildMulBeforeInstr(block, new IntType(32),multer,new ConstInt(num),lastInst);
                // 需要考虑类型冲突吗
                lastInst.setOperator(0,beginLeftOp);
                lastInst.setOperator(1,value);
            } else if( multer.getValueType() instanceof FloatType){
                Value value = builder.buildMulBeforeInstr(block, new FloatType(),multer,new ConstFloat((float) num),lastInst);
                // 需要考虑类型冲突吗
                lastInst.setOperator(0,beginLeftOp);
                lastInst.setOperator(1,value);
            }
        }
        return i;
    }
}

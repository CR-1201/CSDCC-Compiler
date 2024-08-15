package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.constants.ZeroInitializer;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Icmp;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.ArrayType;
import ir.types.IntType;
import pass.Pass;
import pass.analysis.PureFunction;
import pass.utility.CloneUtil;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;


import static ast.Node.builder;

/*
* 典型的空间换时间
* 核心思想就是利用之前信息, 每次递归不用再重新计算了
* */
public class GlobalMemorizeFunc implements Pass {

    private final Module module = Module.getModule();

    private ArrayList<Function> needMemorizeFunc = new ArrayList<>();



    private final CloneUtil cloneUtil = new CloneUtil();

    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();


        for (Function function : functions) {
            if (function.getIsBuiltIn())continue;
            if( runOnFunction(function) ){
                needMemorizeFunc.add(function);
            }
        }

        for (Function function : needMemorizeFunc) {
            GlobalMemorize(function);
        }
    }

    private void GlobalMemorize(Function function) {

        BasicBlock entry = function.getFirstBlock(), phiBlock;

        if( !(entry.getInstructionsArray().size() == 1 && entry.getTailInstruction() instanceof Br br && !br.getHasCondition()) ){
            phiBlock = builder.buildBasicBlockAfter(function, entry);

            ArrayList<Instruction> instructions = entry.getInstructionsArray();

            for( Instruction instruction : instructions ){
                Instruction instr = cloneUtil.cloneInst(phiBlock,instruction);
                instruction.replaceAllUsesWith(instr);
                instruction.removeSelf();
            }

            entry.setPrecursors(new HashSet<>());
            entry.setSuccessors(new HashSet<>());

            entry.replaceAllUsesWith(phiBlock);
            builder.buildBr(entry,phiBlock);
        } else {
            if( !(br.getOperator(0) instanceof BasicBlock block) )return;
            phiBlock = block;
        }


        int hash = 300007, factor = 7;

        Instruction head = entry.getHeadInstruction();

        ArrayList<Argument> arguments = function.getArguments();
        if( arguments.isEmpty() )return;
        if( arguments.size() > 1 )return;
        for (Argument argument : arguments) {
            // TODO 这里有待提升
            if( !(argument.getValueType() instanceof IntType) ){
                return;
            }
        }

        ArrayType arrayType = new ArrayType(new IntType(32),hash+1);
        ZeroInitializer zeroInitializer = new ZeroInitializer(arrayType);
        String mul_name = "memorize_mul_" + function.getName().replace("@", "");
        GlobalVariable mul_globalVariable = builder.buildGlobalVariable(mul_name, zeroInitializer, false);


//        String add_name = "memorize_add_" + function.getName().replace("@", "");
//        GlobalVariable add_globalVariable = builder.buildGlobalVariable(add_name, zeroInitializer, false);

        Argument first = arguments.get(0);

        // 加法和乘法hash
//        Instruction add = builder.buildAddBeforeInstr(function.getFirstBlock(),new IntType(32), first, new ConstInt(0),head);
        Instruction mul = builder.buildMulBeforeInstr(function.getFirstBlock(),new IntType(32), first, new ConstInt(factor),head);
//        add = builder.buildSremBeforeInstr(function.getFirstBlock(),new IntType(32), add, new ConstInt(hash),head);
        mul = builder.buildSremBeforeInstr(function.getFirstBlock(),new IntType(32), mul, new ConstInt(hash),head);
        for (int i = 1 ; i < arguments.size() ; i++){
            Argument arg = arguments.get(i);

//            add = builder.buildAddBeforeInstr(function.getFirstBlock(),new IntType(32), add, arg, head);
//            add = builder.buildSremBeforeInstr(function.getFirstBlock(),new IntType(32), add, new ConstInt(hash),head);

            mul = builder.buildAddBeforeInstr(function.getFirstBlock(),new IntType(32), mul, arg, head);
            mul = builder.buildMulBeforeInstr(function.getFirstBlock(),new IntType(32), mul, new ConstInt(factor),head);
            mul = builder.buildSremBeforeInstr(function.getFirstBlock(),new IntType(32), mul, new ConstInt(hash),head);
        }

        /*
        * if( memorize[hash] != 0 ){
        *   return memorize[hash];
        * }
        * */
        ArrayList<Value> indexes = new ArrayList<>();
        indexes.add(new ConstInt(0));
        indexes.add(mul);
        GEP ptr = builder.buildGEPBeforeInst(function.getFirstBlock(), mul_globalVariable, indexes, head);
        Load load = builder.buildLoadBeforeInstr(function.getFirstBlock(), ptr, head);

        // return
        BasicBlock retBlock = builder.buildBasicBlockAfter(function, function.getFirstBlock());
        builder.buildRet(retBlock,load);

        Instruction tail = entry.getTailInstruction();
        if( tail instanceof Br br && !br.getHasCondition() ){
            BasicBlock target_1 = (BasicBlock) br.getOperator(0);
            Icmp icmp = builder.buildIcmp(entry, Icmp.Condition.EQ, load, new ConstInt(0));
            builder.buildBr(entry,icmp,target_1,retBlock);
            br.removeSelf();
        }

        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray(); // 不带return block
        for (BasicBlock block : blocks) {
            if( block.equals(retBlock) )continue;
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( instruction instanceof Ret ret ){
                    Value value = ret.getRetValue();
                    if( value == null ) continue;
                    builder.buildStoreBeforeInstr(block,value,ptr,ret); // memorize
                }
            }
        }

    }

    private boolean runOnFunction(Function function) {
        boolean flag = false;
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( instruction instanceof Call call ){
                    if( call.getFunction().getName().equals(function.getName()) ){
                        flag = true;
                    } else { // TODO 调用一些库函数可以吗
                        return false;
                    }
                } if( instruction instanceof Store store && store2alloca(store) == null ){
                        return false;
                } else if( instruction instanceof Load load && load2alloca(load) == null ){
                    if( load.getAddr() instanceof GlobalVariable globalVariable ){
                        return false;
                    }
                }
            }
        }

        return flag;
    }

    /**
     * 试图还原 store 到 左值 (alloca 指令)
     * 用于判断是否具有副作用
     */
    Alloca store2alloca(Store store){
        // lval 无法转换为 alloca 指令说明是非局部的, 有副作用
        Value lvalRunner = store.getAddr();
        while( lvalRunner instanceof GEP){
            lvalRunner = ((GEP)lvalRunner).getBase();
        }
        if( lvalRunner instanceof Alloca alloca){
            return alloca;
        } else return null;
    }

    Alloca load2alloca(Load load){
        // lval 无法转换为 alloca 指令说明是非局部的, 有副作用
        Value lvalRunner = load.getAddr();
        while( lvalRunner instanceof GEP){
            lvalRunner = ((GEP)lvalRunner).getBase();
        }
        if( lvalRunner instanceof Alloca alloca){
            return alloca;
        } else return null;
    }
}

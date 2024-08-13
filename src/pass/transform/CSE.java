package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;

import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;

import ir.instructions.otherInstructions.Call;

import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.VoidType;
import pass.Pass;
import pass.analysis.PureFunction;
import utils.Expression;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

// TODO global CSE

public class CSE implements Pass {
    private final Module module = Module.getModule();

    private final HashMap<BasicBlock,ArrayList<Boolean>> GEN = new HashMap<>();
    private final HashMap<BasicBlock,ArrayList<Boolean>> KILL = new HashMap<>();
    private final HashMap<BasicBlock,ArrayList<Boolean>> IN = new HashMap<>();
    private final HashMap<BasicBlock,ArrayList<Boolean>> OUT = new HashMap<>();

    private final ArrayList<Expression> available = new ArrayList<>();
    private final ArrayList<Instruction> delete_list = new ArrayList<>();

    private HashMap<Function, Boolean> is_pure = new HashMap<>();
    private HashMap<Function, HashSet<Value>> global_var_store_effects = new HashMap<>();
    @Override
    public void run() {
        PureFunction pureFunction = new PureFunction();
        pureFunction.markPure();
        this.is_pure = pureFunction.isPure;
        this.global_var_store_effects = pureFunction.globalVarStoreEffects;

        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( !function.getIsBuiltIn() ){
                do{
                    localCSE(function);
//                    globalCSE(function);
                }while(!delete_list.isEmpty());
            }
        }
    }

    private void globalCSE(Function function) {
        delete_list.clear();
        calcGenKill(function);

        calcInOut(function);

        findSource(function);

        replaceSubExpr(function);
    }

    private void calcGenKill(Function function) {
        calcAvailable(function);
        calcGen(function);
        calcKill(function);
    }

    private void calcAvailable(Function function) {
        available.clear();
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if(notOptimizable(instruction)) {
                    continue;
                }
                Expression expression = new Expression(instruction);
                if( getExpression(instruction) == null ) {
                    available.add(expression);
                    instruction.setCSEIndex(available.size() - 1);
                }
            }
        }
    }

    private void calcGen(Function function) {
        GEN.clear();
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for (BasicBlock block : blocks) {
            ArrayList<Boolean> gen = new ArrayList<>();
            for (int i = 0; i < available.size(); i++) {
                gen.add(false);
            }
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if(notOptimizable(instruction)) {
                    continue;
                }
                if( instruction instanceof Load && isKill(instruction,instructions) ){
                    continue;
                }
                Expression expression = getExpression(instruction);
                if( expression != null ) {
                    System.out.println(instruction);
                    int index = available.indexOf(expression);
                    gen.set(index,true);
                }

            }
            GEN.put(block,gen);
        }
    }

    private void calcKill(Function function) {
        KILL.clear();
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for (BasicBlock block : blocks) {
            ArrayList<Boolean> kill = new ArrayList<>();
            for (int i = 0; i < available.size(); i++) {
                kill.add(false);
            }
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( instruction instanceof Ret || (instruction instanceof Br br) ){
                    continue;
                }

                Expression exp = new Expression(instruction);
                for( int i = 0; i < available.size() ; i++ ){
                    Expression expression = available.get(i);
                    if( expression.instruction instanceof Load load && isKill(load,instruction) ){
                        kill.set(i,true);
                    }


                    if( exp.hash != null && exp.hash.equals(expression.hash) ){
                        GEN.get(block).set(i,false);
                    }

                    ArrayList<Value> operands = expression.operands;
                    if( operands.contains(instruction) ){
                        kill.set(i,true);
                    }
                }
            }
            KILL.put(block,kill);
        }
    }

    private void calcInOut(Function function) {
        ArrayList<Boolean> phi = new ArrayList<>();
        ArrayList<Boolean> U = new ArrayList<>();
        for (int i = 0; i < available.size(); i++) {
            phi.add(false);
            U.add(true);
        }

        IN.clear();
        OUT.clear();
        IN.put(function.getFirstBlock(),phi);
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for (BasicBlock block : blocks) {
            if( block.equals(function.getFirstBlock()) ){
                OUT.put(block,phi);
            } else OUT.put(block,U);
        }

        boolean changed = true;
        int count = 0;
        while (changed) {
            System.out.println(count++);
            changed = false;
            for (BasicBlock block : getBlocksRank(function)) {
                if( block != function.getFirstBlock() ){
                    // calculate IN
                    ArrayList<Boolean> in = new ArrayList<>(U);
                    for( BasicBlock pre : block.getPrecursors() ){
                        for( int i = 0 ; i < available.size() ; i++ ){
                            boolean flag = in.get(i) && OUT.get(pre).get(i);
                            in.set(i,flag);
                        }
                    }
                    IN.put(block,in);

                    // calculate OUT
                    ArrayList<Boolean> preOut = new ArrayList<>(OUT.get(block));
                    for( int i = 0 ; i < available.size() ; i++ ){
                        boolean flag = GEN.get(block).get(i) || (IN.get(block).get(i) && !KILL.get(block).get(i));
                        OUT.get(block).set(i,flag);
                    }
                    if( !preOut.equals(OUT.get(block)) ){
                        changed = true;
                    }
                }
            }
        }
    }

    private void findSource(Function function) {
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for (BasicBlock block : blocks) {
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for( Instruction instruction : instructions ){
                if(notOptimizable(instruction)) {
                    continue;
                }
                Expression expression = getExpression(instruction);
                if( expression != null ) {
                    int index = available.indexOf(expression);
                    expression = available.get(index);
                    if(instruction instanceof Load load && isKill(load,instructions) ){
                        expression.source.remove(load);
                    } else if( (!IN.get(block).get(index) || KILL.get(block).get(index)) && GEN.get(block).get(index) ){
                        expression.source.add(instruction);
                    }
                }
            }
        }
    }

    private void replaceSubExpr(Function function){
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for (BasicBlock block : blocks){
            ArrayList<Instruction> instructions = block.getInstructionsArray();
            for (Instruction instruction : instructions){
                if(notOptimizable(instruction)){
                    continue;
                }
                Expression expression = getExpression(instruction);;
                if( expression != null ) {
                    int index = available.indexOf(expression);
                    expression = available.get(index);
                    if( !IN.get(block).get(index) || KILL.get(block).get(index) || expression.source.contains(instruction)){
                        continue;
                    }
                    Instruction repInst = findReplacement(block,expression.source);
                    if( repInst != null ){
                        delete_list.add(instruction);
                        instruction.replaceAllUsesWith(repInst);
                    }
                }
            }
        }
    }

    private Instruction findReplacement(BasicBlock block, HashSet<Instruction> source) {
        HashMap<BasicBlock,Instruction> sourceMap = new HashMap<>();
        for( Instruction instruction : source ){
            BasicBlock basicBlock = instruction.getParent();
            sourceMap.put(basicBlock,instruction);
        }

        HashSet<BasicBlock> arrived = new HashSet<>();
        for (Map.Entry<BasicBlock, Instruction> entry : sourceMap.entrySet()) {
            BasicBlock sourceBlock = entry.getKey();

            ArrayList<BasicBlock> workList = new ArrayList<>();
            ArrayList<BasicBlock> visited = new ArrayList<>();
            workList.add(sourceBlock);
            for( BasicBlock cur_bb : workList ){
                if( visited.contains(cur_bb) ){
                    continue;
                }
                visited.add(cur_bb);
                if( cur_bb.equals(block) ){
                    arrived.add(sourceBlock);
                    break;
                }
                for( BasicBlock successor : cur_bb.getSuccessors() ){
                    if( sourceMap.containsKey(successor) ){
                        continue;
                    }
                    workList.add(successor);
                }
            }
        }

        return arrived.size() == 1 ? sourceMap.get(arrived.iterator().next()) : null;
    }

    private void localCSE(Function function){
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for (BasicBlock bb : blocks) {
            do {
                delete_list.clear();
                ArrayList<Instruction> instructions = bb.getInstructionsArray();
                ArrayList<Instruction> preInstructions = new ArrayList<>();
                for (Instruction inst : instructions) {
                    if (notOptimizable(inst)) {
                        preInstructions.add(inst);
                        continue;
                    }

                    Instruction preInst = isAppear(inst, preInstructions);
                    if (preInst != null) {
                        delete_list.add(inst);
                        // FIXME 后面会remove self
                        inst.replaceAllUsesWith(preInst);
                    } else {
                        preInstructions.add(inst);
                    }
                }
                deleteInstr();
            } while (!delete_list.isEmpty());
        }
    }

    private boolean isKill(Instruction instruction, ArrayList<Instruction> instructions) {
        int index = instructions.indexOf(instruction);
        for ( int i = index + 1; i < instructions.size(); i++ ) {
            Instruction instr = instructions.get(i);
            if( isKill(instruction,instr) ){
                return true;
            }
        }
        return false;
    }

    private Instruction isAppear(Instruction inst,ArrayList<Instruction> instructions){
        int index = instructions.size();
        for (int i = index-1 ; i >= 0 ; i--) {
            Instruction inst2 = instructions.get(i);
            if( isKill(inst,inst2) ) return null;
            Expression expression1 = new Expression(inst);
            Expression expression2 = new Expression(inst2);
            if( expression1.equals(expression2) ){
                return inst2;
            }
        }
        return null;
    }

    private boolean isKill(Instruction inst1,Instruction inst2){

        if( inst1 instanceof Call call1 && inst2 instanceof Call call2 ){
            if( !call1.getFunction().equals(call2.getFunction()) ){
                return false;
            }
            if( call1.getFunction().getIsBuiltIn() ){
                return true;
            }
            if( is_pure.containsKey(call1.getFunction()) ){
                return !is_pure.get(call1.getFunction());
            }
        }


        if( !(inst1 instanceof Load load) ){
            return false;
        }

        if( inst2 instanceof Store && isStoreWithDifferentIndex(inst1,inst2) ){
            return false;
        }

        Value lval_load = load.getAddr();
        Value target_load = findOrigin(lval_load);

        if( isArgOrGlobalArrayOp(lval_load,target_load) ){
            if( inst2 instanceof Store store){
                Value lval_store = store.getAddr();
                Value target_store = findOrigin(lval_store);

                if( target_load instanceof GlobalVariable && target_store instanceof GlobalVariable ){
                    return target_store.equals(target_load);
                }

                return isArgOrGlobalArrayOp(lval_store,target_store);
            }
            if( inst2 instanceof Call call){
                Function func = call.getFunction();
                if( func.getIsBuiltIn() ){
                    return true;
                }
                if( is_pure.containsKey(func) ){
                    return !is_pure.get(func);
                }
                return true;
            }
            return false;
        }


        if( inst2 instanceof Store store){
            return target_load.equals(findOrigin(store.getAddr()));
        }

        if( inst2 instanceof Call call){
            Function func = call.getFunction();
            if( func.getIsBuiltIn() ){
                return true;
            }
            if( is_pure.containsKey(func) && is_pure.get(func)){
                return false;
            }
            if( global_var_store_effects.containsKey(func) && global_var_store_effects.get(func).contains(lval_load) ){
                return true;
            }
            for( Value v : inst2.getOperators() ){
                if( findOrigin(v).equals(target_load) ){
                    return true;
                }
            }
        }
        return false;
    }

    private boolean isArgOrGlobalArrayOp( Value lval, Value target ){
        return (target instanceof Argument) ||
                (target instanceof GlobalVariable && !(lval instanceof GlobalVariable));
    }

    private Value findOrigin( Value value ){
        Value lval_runner = value;
        while( lval_runner instanceof GEP gep){
            lval_runner = gep.getBase();
        }
        return lval_runner;
    }

    private boolean isStoreWithDifferentIndex(Instruction inst1,Instruction inst2){
        if( !(inst2 instanceof Store store) ){
            return true;
        }
        if( !(inst1 instanceof Load load) ){
            return true;
        }

        Value lval_1 = load.getAddr();
        Value lval_2 = store.getAddr();

        if( lval_1 instanceof GEP gep_1 && lval_2 instanceof GEP gep_2 ){
            if( gep_1.getBase() != gep_2.getBase() ) {
                return true;
            }
            if( gep_1.getIndex().size() != gep_2.getIndex().size() ){
                return true;
            }
            for( int i = 0 ; i < gep_1.getIndex().size() ; i++ ){
                Value index_1 = gep_1.getIndex().get(i);
                Value index_2 = gep_2.getIndex().get(i);
                if( index_1 instanceof ConstInt constInt1 && index_2 instanceof ConstInt constInt2 ){
                    if( constInt1.getValue() != constInt2.getValue() ){
                        return true;
                    }
                }
            }
            return false;
        } else if( lval_2.equals(lval_1) ){
            return false;
        }
        return false;
    }

    private boolean notOptimizable(Instruction instruction){
        if( instruction instanceof Ret || instruction instanceof Br || instruction instanceof Store
          || (instruction instanceof Call call && call.getFunction().getReturnType() instanceof VoidType)
           || instruction instanceof Alloca ){
            return true;
        }
        if( instruction instanceof Call call ){
            Function function = call.getFunction();
            return !is_pure.containsKey(function);
        }
        return false;
    }

    void deleteInstr(){
        for (Instruction instruction : delete_list){
            instruction.removeSelf();
        }
    }

    private ArrayList<BasicBlock> getBlocksRank(Function function) {
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        ArrayList<BasicBlock> blocksRank = new ArrayList<>();
        for (BasicBlock block : blocks) {
            if( block.getSuccessors().isEmpty() ){
                blocksRank.add(block);
            }
        }
        for( int i = 0; i < blocksRank.size(); i++ ){
            for( BasicBlock pre : blocksRank.get(i).getPrecursors() ){
                if( !blocksRank.contains(pre) ){
                    blocksRank.add(pre);
                }
            }
        }
        return blocksRank;
    }

    private Expression getExpression(Instruction instruction){
        Expression exp = new Expression(instruction);
        for( Expression expression : available ){
            if( expression.equals(exp) ){
                return expression;
            }
        }
        return null;
    }


}

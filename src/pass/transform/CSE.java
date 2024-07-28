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

public class CSE implements Pass {
    private final Module module = Module.getModule();

    private HashMap<BasicBlock,ArrayList<Boolean>> Gen;
    private HashMap<BasicBlock,ArrayList<Boolean>> KILL;
    private HashMap<BasicBlock,ArrayList<Boolean>> IN;
    private HashMap<BasicBlock,ArrayList<Boolean>> OUT;

    private ArrayList<Expression> available = new ArrayList<>();
    private ArrayList<Instruction> delete_list = new ArrayList<>();

    private HashMap<Function, Boolean> is_pure = new HashMap<>();
    private HashMap<Function, HashSet<Value>> global_var_store_effects = new HashMap<>();
    @Override
    public void run() {
        PureFunction pureFunction = new PureFunction();
        pureFunction.markPure();
        this.is_pure = pureFunction.is_pure;
        this.global_var_store_effects = pureFunction.global_var_store_effects;

        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( !function.getIsBuiltIn() ){
                do{
                    localCSE(function);
                }while(!delete_list.isEmpty());
            }
        }
    }

    private void localCSE(Function function){
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock bb : blocks) {
            do {
                delete_list.clear();
                ArrayList<Instruction> instructions = bb.getInstructionsArray();
                for (int i = 0; i < instructions.size(); i++) {
                    Instruction inst = instructions.get(i);
                    if( !isOptimizable(inst) ){
                        continue;
                    }
                    Instruction preInst = isAppear(inst,instructions,i);
                    if( preInst != null ){
                        delete_list.add(inst);
                        // FIXME 后面会remove self
                        inst.replaceAllUsesWith(preInst);
                    }
                }
                deleteInstr();
            } while (!delete_list.isEmpty());
        }
    }

    private Instruction isAppear(Instruction inst,ArrayList<Instruction> instructions,int index){
        for (int i = index-1 ; i >= 0 ; i--) {
            Instruction inst2 = instructions.get(i);
            if( isKill(inst,inst2) ) return null;
            Expression expression1 = new Expression(inst);
            Expression expression2 = new Expression(inst2);
            if( expression1.equals(expression2) ){
                return inst;
            }
        }
        return null;
    }

    private boolean isKill(Instruction inst1,Instruction inst2){
        // inst1 must be load inst to be killed
        if( !(inst1 instanceof Load load) ){
            return false;
        }
        // if store and not same index, return false
        if( isStoreWithDifferentIndex(inst1,inst2) ){
            return false;
        }
        Value lval_load = load.getAddr();
        Value target_load = findOrigin(lval_load);

        if( isArgOrGlobalArrayOp(lval_load,target_load) ){
            if( inst2 instanceof Store store){
                Value lval_store = store.getAddr();
                Value target_store = findOrigin(lval_store);
                // if both global
                if( target_load instanceof GlobalVariable && target_store instanceof GlobalVariable ){
                    return target_store.equals(target_load);
                }
                // else any global/arg store erase load inst
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

        // local array or global variable
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
            return false;
        }
        if( !(inst1 instanceof Load load) ){
            return false;
        }
        Value lval_1 = load.getAddr();
        Value lval_2 = store.getAddr();
        if( lval_1 instanceof GEP gep_1 && lval_2 instanceof GEP gep_2 ){
            if( gep_1.getBase() != gep_2.getBase() ) {
                return false;
            }
            if( gep_1.getIndex().size() != gep_2.getIndex().size() ){
                return false;
            }
            for( int i = 0 ; i < gep_1.getIndex().size() ; i++ ){
                Value index_1 = gep_1.getIndex().get(i);
                Value index_2 = gep_2.getIndex().get(i);
                if( index_1 instanceof ConstInt constInt1 && index_2 instanceof ConstInt constInt2 ){
                    if( constInt1.getValue() == constInt2.getValue() ){
                        continue;
                    }
                }
                return false;
            }
            return true;
        }
        return false;
    }

    private boolean isOptimizable(Instruction instruction){
        if( instruction instanceof Ret || instruction instanceof Br || instruction instanceof Store
          || (instruction instanceof Call call && call.getFunction().getReturnType() instanceof VoidType)
           || instruction instanceof Alloca ){
            return false;
        }
        if( instruction instanceof Call call ){
            Function function = call.getFunction();
            return is_pure.containsKey(function);
        }
        return true;
    }

    void deleteInstr(){
        for (Instruction instruction : delete_list){
            instruction.removeSelf();
        }
    }
}

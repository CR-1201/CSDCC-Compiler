package pass.analysis;

import ir.*;
import ir.Module;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class PureFunction {

    private final Module module = Module.getModule();

    public HashMap<Function, Boolean> isPure = new HashMap<>();
    public HashMap<Function, HashSet<Value>> globalVarStoreEffects = new HashMap<>();

    public HashSet<Function> getPureFunctions() {
        HashSet<Function> pureFunctions = new HashSet<>();
        for (HashMap.Entry<Function, Boolean> entry : isPure.entrySet()) {
            if (entry.getValue()) {
                pureFunctions.add(entry.getKey());
            }
        }
        return pureFunctions;
    }

    public void markPure(){
        isPure.clear();
        globalVarStoreEffects.clear();
        ArrayList<Function> functions = module.getFunctionsArray();
        ArrayList<Function> workList = new ArrayList<>();

        for(Function function : functions){
            if( function.getIsBuiltIn() ) {
                isPure.put(function, false);
                workList.add(function);
                continue;
            }
            isPure.put(function, makePureInside(function));

            if( !isPure.get(function) || !(globalVarStoreEffects.containsKey(function) && globalVarStoreEffects.get(function).isEmpty()) ){
                workList.add(function);
            }
        }

        for( int i = 0; i < workList.size(); i++ ){
            Function callee_function = workList.get(i);
            for( User user : callee_function.getUsers()){
//                System.out.println(user);
                if( !(user instanceof Call call) ){
                    continue;
                }
                Function caller_function = call.getParent().getParent();
                boolean influenced = false;
                if( globalVarStoreEffects.containsKey(callee_function)){
                    for( Value value : globalVarStoreEffects.get(callee_function) ){
                        if( !(globalVarStoreEffects.containsKey(caller_function) && globalVarStoreEffects.get(caller_function).contains(value))){
                            if( globalVarStoreEffects.containsKey(caller_function) ){
                                globalVarStoreEffects.get(caller_function).add(value);
                            } else {
                                globalVarStoreEffects.put(caller_function, new HashSet<>());
                                globalVarStoreEffects.get(caller_function).add(value);
                            }
                            influenced = true;
                        }
                    }
                }

                if( isPure.get(caller_function) != null && isPure.get(caller_function) ){
                    isPure.put(caller_function,false);
                    influenced = true;
                }

                if(influenced){
                    workList.add(caller_function);
                }
            }
        }
    }

    private boolean makePureInside(Function function){
        boolean pure = true;
        ArrayList<BasicBlock> basicBlocks = function.getBasicBlocksArray();
        for(BasicBlock basicBlock : basicBlocks){
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for(Instruction instruction : instructions){
                // store 指令,且无法找到 alloca 作为左值, 说明非局部变量;
                if( instruction instanceof Store store && store2alloca(store) == null ){
                    if( store.getAddr() instanceof GlobalVariable globalVariable ){
                        if( globalVarStoreEffects.containsKey(function) ){
                            globalVarStoreEffects.get(function).add(globalVariable);
                        } else {
                            globalVarStoreEffects.put(function, new HashSet<>());
                            globalVarStoreEffects.get(function).add(globalVariable);
                        }
                    }
                    pure = false; // 也可能是传入数组的store
                } else if( instruction instanceof Load load && load2alloca(load) == null ){
                    if( load.getAddr() instanceof GlobalVariable globalVariable ){
                        if( globalVarStoreEffects.containsKey(function) ){
                            globalVarStoreEffects.get(function).add(globalVariable);
                        } else {
                            globalVarStoreEffects.put(function, new HashSet<>());
                            globalVarStoreEffects.get(function).add(globalVariable);
                        }
                        pure = false; // 只有加载全局变量的值才会 pure = false
                    }
                }

            }
        }
        return pure;
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

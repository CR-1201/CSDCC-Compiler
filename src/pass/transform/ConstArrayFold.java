package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.*;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.types.*;
import pass.Pass;
import pass.analysis.AliasAnalysis;

import java.util.ArrayList;
import java.util.HashSet;

public class ConstArrayFold implements Pass {
    private final Module module = Module.getModule();
    HashSet<GlobalVariable> globalVariableArray = new HashSet<>();

    @Override
    public void run() {
        initConstArray();
//        System.out.println(globalVariableArray);
        flodConstArray();
    }

    private void initConstArray() {
        globalVariableArray.addAll(module.getGlobalVariablesArray());
        //  除去所有被store过的全局数组
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof Store store ){
                        Value pointer = store.getAddr();
                        Value root = AliasAnalysis.searchRoot(pointer);
                        if( root instanceof GlobalVariable globalVariable ){
                            globalVariableArray.remove(globalVariable);
                        }
                    } else if( instruction instanceof Call call ){
                        for( Value arg : call.getArgs() ){
                            Value root = AliasAnalysis.searchRoot(arg);
//                            System.out.println(call);
                            if( root instanceof GlobalVariable globalVariable ){
//                                System.out.println(root);
                                globalVariableArray.remove(globalVariable);
                            }
                        }
                    }
                }
            }
        }
    }

    private void flodConstArray() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
            for (BasicBlock block : blocks) {
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for (Instruction instruction : instructions) {
                    if( instruction instanceof GEP gep ){
                        Value ptr = gep.getBase();
                        if( ptr instanceof GlobalVariable globalVariable && globalVariableArray.contains(globalVariable) ){
//                            System.out.println(gep);
                            ArrayList<Value> indexes = gep.getIndex();
                            boolean allConstInt = true;
                            for( Value index : indexes ){
                                if( !(index instanceof ConstInt) ){
                                    allConstInt = false;
                                    break;
                                }
                            }
                            if( allConstInt ){
                                ArrayList<Integer> intIndexes = new ArrayList<>();
                                for( int i = 1 ; i < indexes.size() ; i++ ){
                                    intIndexes.add(((ConstInt)indexes.get(i)).getValue());
                                }

//                                System.out.println(intIndexes);

                                Value retValue = getGlobalArrayValue(globalVariable,intIndexes);
//                                System.out.println(retValue);
                                if( retValue != null ){
//                                    System.out.println(gep);
                                    ArrayList<User> users = new ArrayList<>(gep.getUsers());
                                    for( User user : users ){
                                        if (user instanceof Load load) {
                                            load.replaceAllUsesWith(retValue);
                                            load.removeSelf();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private Value getGlobalArrayValue( GlobalVariable globalVariable, ArrayList<Integer> indexes ){
        Constant initVal = globalVariable.getInitVal();

        if( initVal instanceof ZeroInitializer zeroInitializer){
            ValueType valueType = zeroInitializer.getValueType();
            if( valueType instanceof ArrayType arrayType ){
                if( arrayType.getBaseType() instanceof IntType){
                    return new ConstInt(0);
                }
                if( arrayType.getBaseType() instanceof FloatType){
                    return new ConstInt(0);
                }
            }
        }

        for (Integer index : indexes) {
            if (initVal instanceof ConstArray constArray) {
                initVal = constArray.getElementByIndex(index);
            } else break;
        }


        if( initVal instanceof ConstInt constInt ){
            return constInt;
        }

        if( initVal instanceof ConstFloat constFloat){
            return constFloat;
        }

        return null;
    }


}

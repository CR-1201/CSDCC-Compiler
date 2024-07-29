package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.*;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import ir.types.ArrayType;
import ir.types.IntType;
import ir.types.ValueType;
import pass.Pass;
import pass.analysis.LoopAnalysis;

import java.util.ArrayList;

import static ast.Node.builder;

public class LocalArrayLift implements Pass {

    private final Module module = Module.getModule();

    private ArrayList<Integer> dims = new ArrayList<>();
    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getName().equals("@main") || function.getCallers().size() == 1 ){
                localArrayLift(function);
            }
        }
    }

    private void localArrayLift(Function function) {
        LoopAnalysis loopAnalysis = new LoopAnalysis();
        loopAnalysis.analyzeLoopInfo(function);

        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock basicBlock : blocks) {
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for (Instruction instruction : instructions) {

                if (instruction instanceof Alloca alloca) {
//                    System.out.println(instruction);
                    if (alloca.parentBlock != null && alloca.parentBlock.getLoopDepth() != 0) {
                        continue;
                    }

                    ValueType valueType = alloca.getAllocatedType();
                    if (valueType instanceof ArrayType arrayType) {

                        boolean constFlag = true;

                        if (!(arrayType.getBaseType() instanceof IntType)) {
                            continue;
                        }

                        ArrayList<Value> originInitValues = alloca.getInitValues();
                        if (originInitValues == null) continue;

                        ArrayList<Integer> numList = arrayType.getNumList();
                        this.dims = numList;
                        int sum = 1;
                        for (Integer integer : numList) {
                            sum *= integer;
                        }
                        //  初始值清零
                        ArrayList<Value> initValues = new ArrayList<>();
//                        System.out.println(sum);
                        for (int j = 0; j < sum; j++) {
                            initValues.add(new ConstInt(0));
                        }

                        ArrayList<Instruction> initInstructions = alloca.initInstructions;

                        ArrayList<Store> storeList = new ArrayList<>();
                        for (Instruction inst : initInstructions) {
                            if (inst instanceof Call) {
                                constFlag = false;
                            }
                            if (inst instanceof Store store) {
                                storeList.add(store);
                            }
                        }

                        ArrayList<Value> deleteList = new ArrayList<>();

//                        System.out.println(originInitValues);
                        for (int j = 0, k = 0; j < originInitValues.size(); j++) {

                            if (originInitValues.get(j) instanceof ConstStr) {
                                continue;
                            }

                            if( k < storeList.size() && storeList.get(k).getValue() instanceof ConstInt){
                                initValues.set(j,storeList.get(k).getValue());
                                Store store = storeList.get(k);
                                if( store.getAddr() instanceof Conversion conversion ){
                                    deleteList.add(conversion);
                                    deleteList.add(conversion.getConversionValue());
                                    deleteList.add(store);
                                } else if( store.getAddr() instanceof GEP gep){
                                    deleteList.add(gep);
                                    deleteList.add(store);
                                }
                            }

                            k++;
                        }


                        String name = "lift_" + alloca.getName().replace("%", "");
                        boolean isAllZero = true;
                        for (Value value : initValues) {
                            if (value instanceof ConstInt constInt && constInt.getValue() != 0) {
                                isAllZero = false;
                                break;
                            }
                        }

//                        System.out.println(initValues);

                        for( Instruction inst : initInstructions ){
                            if( inst instanceof Store || inst instanceof GEP || inst instanceof Conversion){
                                if( deleteList.contains(inst)){
                                    inst.removeSelf();
                                }
                            } else inst.removeSelf();
                        }

                        if (isAllZero) {
                            ZeroInitializer zeroInitializer = new ZeroInitializer(arrayType);
                            GlobalVariable globalVariable = builder.buildGlobalVariable(name, zeroInitializer, constFlag);
                            alloca.replaceAllUsesWith(globalVariable);
                            alloca.removeSelf();
                        } else {
                            ConstArray constArray = getArrayTree(initValues, 0);
                            GlobalVariable globalVariable = builder.buildGlobalVariable(name, constArray, constFlag);
                            alloca.replaceAllUsesWith(globalVariable);
                            alloca.removeSelf();
                        }

                    }
                }
            }
        }
    }

    private ConstArray getArrayTree(ArrayList<Value> flattenArray, int dim_level){
        ArrayList<Constant> temp = new ArrayList<>();
        if( dim_level >= dims.size()-1 ){
            for( int i = 0 ; i < dims.get(dim_level) ; i++ ){
                if( flattenArray.get(i) instanceof ConstInt ){
                    temp.add((ConstInt)flattenArray.get(i));
                } else temp.add((ConstFloat)flattenArray.get(i));
            }
        } else {
            int row_num = dims.get(dim_level);
            int column_num = 1;
            for( int i = dim_level+1 ; i < dims.size() ; i++ ){
                column_num *= dims.get(i);
            }
            for( int i = 0 ; i < row_num ; i++ ){
                ArrayList<Value> temp_flattenArray = new ArrayList<>();
                for( int j = 0 ; j < column_num ; j++ ){
                    Value temp_value = flattenArray.get(i*column_num+j);
                    temp_flattenArray.add(temp_value);
                }
                temp.add(getArrayTree(temp_flattenArray,dim_level+1));
            }
        }
        return new ConstArray(temp);
    }
}

package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.*;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
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

            if(basicBlock.getLoopDepth() != 0){
                continue;
            }

            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for (int i = 0; i < instructions.size(); i++) {
                Instruction instruction = instructions.get(i);
//                System.out.println(instruction);
                if( instruction instanceof Alloca alloca ){
                    ValueType valueType = alloca.getAllocatedType();
                    if( valueType instanceof ArrayType arrayType ){

                        boolean constFlag = true;

                        if( !(arrayType.getBaseType() instanceof IntType) ){
                            continue;
                        }

                        ArrayList<Value> originInitValues = alloca.getInitValues();

                        if( originInitValues == null ) continue;

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
                        Instruction gep = null;
                        for( Value value : alloca.getUsers() ){
                            if( value instanceof GEP value_gep ){
                                gep = value_gep; //找到第一个GEP
                                break;
                            }
                        }

                        if( gep == null ){
                            continue;
                        }

                        int k = instructions.indexOf(gep), x = 0;
                        if( instructions.get(k+1) instanceof Call){
                            constFlag = false;

                            gep.removeSelf();

                            Instruction memset = instructions.get(++k);
                            memset.removeSelf();

                            Instruction store_temp = instructions.get(++k);
                            store_temp.removeSelf();

                            x = 1; k++;
                        }
                        k--;


                        for( int j = x; j < originInitValues.size() ; j++ ){
//                            System.out.println(originInitValues.get(j));
                            if( originInitValues.get(j) instanceof ConstStr ){
                                continue;
                            }
                            Instruction temp_gep = instructions.get(++k);
                            Instruction temp_store = instructions.get(++k);
//                            System.out.println(k);
                            if( temp_store instanceof Store store && store.getValue() instanceof ConstInt ){
                                initValues.set(j,store.getValue());
                                temp_gep.removeSelf();
                                temp_store.removeSelf();
                            }
                        }

                        String name = "lift_" + alloca.getName().replace("%", "");
                        boolean isAllZero = true;
                        for( Value value : initValues ){
                            if( value instanceof ConstInt constInt && constInt.getValue() != 0){
                                isAllZero = false;
                                break;
                            }
                        }
                        if( isAllZero ){
                            ZeroInitializer zeroInitializer = new ZeroInitializer(arrayType);
                            GlobalVariable globalVariable = builder.buildGlobalVariable(name, zeroInitializer, constFlag);
                            alloca.replaceAllUsesWith(globalVariable);
                            alloca.removeSelf();
                        } else {
                            ConstArray constArray = getArrayTree(initValues,0);
                            GlobalVariable globalVariable = builder.buildGlobalVariable(name,constArray,constFlag);
                            alloca.replaceAllUsesWith(globalVariable);
                            alloca.removeSelf();
                        }

                    }
                } else break;
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

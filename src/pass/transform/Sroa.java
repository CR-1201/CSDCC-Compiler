package pass.transform;
import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.BitCast;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Phi;
import ir.types.*;
import pass.Pass;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static ast.Node.builder;
import static ir.IrBuilder.nameNumCounter;


public class Sroa implements Pass {

    private final Module module = Module.getModule();

    private static final int EXTRACT_THRESHOLD = 128;

    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            runOnFunction(function);
        }
    }

    private void runOnFunction(Function function) {
        BasicBlock entry = function.getFirstBlock();
        ArrayList<Instruction> instructions = entry.getInstructionsArray();
        for (Instruction instruction : instructions) {
            if( instruction instanceof Alloca alloca && canOptimize(alloca) ){
                Formatter formatter = Formatter.optimize(alloca);
                List<Alloca> regs = formatter.getRegisters();
                for (Alloca allocatedReg : regs ){
                    entry.insertHead(allocatedReg);
                }
            }
        }
    }

    private boolean isUsedOnlyByConstIndex(Instruction instruction){
        for( Value operator : instruction.getUsers() ){
            if( operator instanceof GEP gep ){
                for( Value index : gep.getIndex() ){
                    if( !(index instanceof Constant) ){
                        return false;
                    }
                    if( !isUsedOnlyByConstIndex(gep) ){
                        return false;
                    }
                }
            } else if( operator instanceof BitCast bitCast ){
                if( !isUsedOnlyByConstIndex(bitCast) ){
                    return false;
                }
            } else if( operator instanceof Load || operator instanceof Store ){
                continue;
            } else if( operator instanceof Call call ){
                if( !call.getFunction().getName().equals("@memset") ){
                    return false;
                }
            } else if( operator instanceof Phi ){
                return false;
            } else {
                System.out.println("Cannot judge when address is: " + instruction);
            }
        }
        return true;
    }

    private boolean canOptimize(Alloca alloca) {
        if( !(alloca.getAllocatedType() instanceof ArrayType arrayType) ){
            return false;
        }

        if( arrayType.getLength() > EXTRACT_THRESHOLD ){
            return false;
        }

        return isUsedOnlyByConstIndex(alloca);
    }

    private static class Formatter {

        private final List<Alloca> registers = new ArrayList<>();

        private Formatter() {}

        public static Formatter optimize(Alloca alloca){
            Formatter formatter = new Formatter();
            formatter.optimize_(alloca);
            return formatter;
        }

        private void optimize_(Alloca alloca){
            ArrayType arrayType = (ArrayType) alloca.getAllocatedType();
            ValueType baseType = arrayType.getBaseType();
            int size = arrayType.getLength();
            for( int i = 0; i < size; i++ ){
                registers.add(new Alloca(nameNumCounter++,baseType,alloca.getParent()));
            }
            ArrayList<User> values = alloca.getUsers();
            for (User value : values) {
                if( value instanceof Instruction instr ){
                    dfsUseTree(instr,0);
                }
            }
        }

        private void dfsUseTree(Instruction instruction, int offset){
            if( instruction instanceof GEP gep ){
                ValueType currentType = gep.getBaseType();
                ArrayList<Value> indexes = gep.getIndex();
                for( int i = 0; i < indexes.size(); i++ ){
                    if( i > 0 ){
                        if (currentType instanceof ArrayType) {
                            currentType = ((ArrayType)currentType).getBaseType();
                        }
                    }
                    int index = ((ConstInt)indexes.get(i)).getValue(), offsetUnit;
                    if( currentType instanceof ArrayType arrayType ){
                        offsetUnit = arrayType.getLength();
                    } else offsetUnit = 1;

                    offset += offsetUnit * index;
                }

                ArrayList<User> values = instruction.getUsers();
                ArrayList<Instruction> dfsInstructions = new ArrayList<>();
                for (User value : values) {
                    if( value instanceof Instruction instr ){
                        dfsInstructions.add(instr);
                    }
                }

                for (Instruction instr : dfsInstructions) {
                    dfsUseTree(instr,offset);
                }
            } else if( instruction instanceof Load load ){
                load.setOperator(0,registers.get(offset));
            } else if( instruction instanceof Store store ){
                store.setOperator(0, registers.get(offset));
            } else if( instruction instanceof BitCast bitCast ){
                ArrayList<User> values = bitCast.getUsers();
                for (User value : values) {
                    if( value instanceof Instruction instr ){
                        dfsUseTree(instr,offset);
                    }
                }
            } else if( instruction instanceof Call call ){
                assert call.getFunction().getName().equals("@memset");
                ValueType baseType = ((PointerType)call.getParamAt(0).getValueType()).getPointeeType();
                if( baseType instanceof ArrayType arrayType ){
                    baseType = arrayType.getBaseType();
                }
                int length = ((ConstInt)call.getParamAt(2)).getValue() / baseType.getSize();
                for ( int i = 0 ; i < length ; i++ ){
                    if( baseType instanceof IntType ){
                        builder.buildStoreBeforeInstr(call.getParent(),new ConstInt(0),registers.get(offset+i),call);
                    } else if( baseType instanceof FloatType ){
                        builder.buildStoreBeforeInstr(call.getParent(),new ConstFloat(0),registers.get(offset+i),call);
                    }
                }
                call.removeSelf();
            } else {
                System.out.println("No way to process when instruction is: " + instruction);
            }
        }

        public List<Alloca> getRegisters(){
            return Collections.unmodifiableList(registers);
        }

    }
}

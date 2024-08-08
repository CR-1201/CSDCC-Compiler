package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Br;
import pass.Pass;
import pass.analysis.Loop;

import java.util.ArrayList;
import java.util.HashSet;

public class MemSetOptimize implements Pass {

    private final Module module = Module.getModule();

    private ArrayList<Function> functions;
    private HashSet<Instruction> idcPhis = new HashSet<>();
    private HashSet<Loop> initLoops = new HashSet<>();

    private HashSet<Instruction> canGVMGCM = new HashSet<>();

    @Override
    public void run() {
        functions = module.getFunctionsArray();
        init();
        arrayFold();
    }

    private void init() {
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;

            ArrayList<Loop> loops = function.getAllLoops();

            for (Loop loop : loops) {
                if( loop.getDepth() == 1 ){
                    idcPhis.clear();
                    if( checkArrayInit(loop) ){
                        if( loop.getInitArray() instanceof GlobalVariable ){
                            initLoops.add(loop);
                        }
                    }
                }
            }
        }
    }

    private void arrayFold() {
        for (Loop loop : initLoops) {
            Value initArray = loop.getInitArray();
            ArrayList<Function> userFunctions = new ArrayList<>();
            for( User user : initArray.getUsers() ){
                if( user instanceof Instruction instr ){
                    Function function = instr.getParent().getParent();
                    if( !userFunctions.contains(function) ){
                        userFunctions.add(function);
                    }
                }
            }
            boolean flag = (userFunctions.size() == 1);
            Function function = null;
            for(Function f : userFunctions){
                function = f;
            }
            if( flag && loop.getEnterings().size() == 1 && loop.getEnterings().contains(function.getFirstBlock()) ){
                canGVMGCM.clear();
                boolean ret = check(initArray);
                if( ret ){
                    ArrayGVNGCM arrayGVNGCM = new ArrayGVNGCM(function,canGVMGCM);
                    arrayGVNGCM.run();
                }
            }
        }
    }

    private boolean check(Value array) {
        for( User user : array.getUsers() ){
            if( user instanceof Store store && !store.isArrayInit() ){
                return false;
            }
            if( user instanceof GEP ){
                boolean ret = check(user);
                if( !ret ){
                    return false;
                }
            }
            if( user instanceof Load load ){
                canGVMGCM.add(load);
            }
        }
        return true;
    }

    private boolean checkArrayInit(Loop loop) {
        if( !loop.isSimpleLoop() || !loop.isInductorVarSet() ){
            return false;
        }
        if( loop.hasChildLoop() && loop.getChildren().size() != 1 ){
            return false;
        }
        HashSet<Instruction> instrs = new HashSet<>();
        instrs.add(loop.getHeader().getTailInstruction());
        instrs.add((Instruction) loop.getIdcVar());
        instrs.add((Instruction) loop.getIdcAlu());
        instrs.add(loop.getCond());

        idcPhis.add((Instruction) loop.getIdcVar());

        if( !loop.hasChildLoop() ){ //没有子循环
            HashSet<Instruction> extras = new HashSet<>();
            for( BasicBlock block : loop.getCurrentLoopLevelBlocks() ){
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for( Instruction instruction : instructions ){
                    if( !(instruction instanceof Br br && !br.getHasCondition()) && !instrs.contains(instruction) ){
                        extras.add(instruction);
                    }
                }
            }

            int getint_count = 0, gep_count = 0, store_count = 0;
            Call getint = null;
            GEP gep = null;
            Store store = null;
            for( Instruction instr : extras ){
                if( instr instanceof Call call && call.getFunction().getName().equals("getint") ){
                    getint_count++;
                    getint = call;
                } else if( instr instanceof GEP ){
                    gep_count++;
                    gep = (GEP) instr;
                } else if( instr instanceof Store ){
                    store_count++;
                    store = (Store) instr;
                } else return false;
            }
            if( gep_count != 1 ){
                return false;
            }
            ArrayList<Value> indexes = gep.getIndex();

            if( idcPhis.size() + 1 != indexes.size() ){
                return false;
            }

            if( indexes.get(0) instanceof ConstInt constInt && constInt.getValue() == 0 ){
                for( Value index : indexes.subList(1,indexes.size()) ){
                    if( index instanceof Instruction ){
                        if( !idcPhis.contains(index) ){
                            return false;
                        }
                    } else return false;
                }
            } else return false;

            if( store_count == 1 ){
                Value ptr = store.getAddr();
                if( !ptr.equals(gep) ){
                    return false;
                }
                Value initArray = gep.getBase();
                Value initValue = store.getAddr();
                if( getint_count == 1 ){
                    if( !initValue.equals(getint) ){
                        return false;
                    }
                }
                gep.setArrayInit(true);
                store.setArrayInit(true);
                loop.setArrayInitInfo(1,initArray,initValue,extras);
                return true;
            } else return false;
        } else { //有子循环且子循环数量为1
            for( BasicBlock block : loop.getCurrentLoopLevelBlocks() ){
                ArrayList<Instruction> instructions = block.getInstructionsArray();
                for( Instruction instruction : instructions ){
                    if( !(instruction instanceof Br br && !br.getHasCondition()) && !instrs.contains(instruction) ){
                        return false;
                    }
                }
            }
            Loop next = null;
            for( Loop temp : loop.getChildren() ){
                next = temp;
            }
            assert next != null;
            boolean ret = checkArrayInit(next);
            if( ret ){
                loop.setArrayInitInfo(next.getArrayInitDims()+1, next.getInitArray(), next.getInitValue(), next.getExtras());
                return true;
            }
            return false;
        }
    }
}

package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.types.*;
import pass.Pass;

import java.util.ArrayList;
import java.util.HashSet;

import static ir.IrBuilder.nameNumCounter;
/**
 @author Conroy
 全局变量局部化
 如果全局变量仅在 main 函数中出现,那么这个变量只定义在 main 函数中,从而可以被 Mem2Reg 提升为虚拟寄存器
 */
public class GlobalValueLocalize implements Pass {
    private final Module module = Module.getModule();

    private HashSet<GlobalVariable> deleteList = new HashSet<>();
    @Override
    public void run() {
        ArrayList<GlobalVariable> globalVariables = module.getGlobalVariablesArray();
        for(GlobalVariable globalVariable : globalVariables){
            ValueType type = ((PointerType) globalVariable.getValueType()).getPointeeType();
            if(!(type instanceof ArrayType)){
                localize(globalVariable);
            }
        }

        for(GlobalVariable globalVariable : deleteList){
            // 删除全局变量
            module.getGlobalVariables().remove(globalVariable);
        }
    }

    private void localize(GlobalVariable globalVariable){
        boolean stored = false;
        ArrayList<Function> useFuncs = new ArrayList<>();
        HashSet<Function> useFuncSet = new HashSet<>();
        ArrayList<Instruction> useInstructions = new ArrayList<>();

        ValueType type = ((PointerType) globalVariable.getValueType()).getPointeeType();
        for(User user : globalVariable.getUsers()){
            if(user instanceof Instruction useInst){
                useInstructions.add(useInst);
                Function function = useInst.getParent().getParent();
                if(!useFuncSet.contains(function)){
                    useFuncs.add(function);
                    useFuncSet.add(function);
                }
                if(useInst instanceof Store){
                    stored = true;
                }
            }
        }

        // 没有被store的全局变量直接改为初始的常数
        if (!stored ) {
            deleteList.add(globalVariable);
            for(Instruction useInst : useInstructions){
                if(useInst instanceof Load) {
                    Value init = globalVariable.getInitVal();
                    Value newValue = null;
                    if (type instanceof IntType) {
                        int initVal = ((ConstInt) init).getValue();
                        newValue = new ConstInt(initVal);
                    }
                    else if (type.isFloat()) {
                        float initVal = ((ConstFloat) init).getValue();
                        newValue = new ConstFloat(initVal);
                    }

                    useInst.replaceAllUsesWith(newValue);
                    useInst.removeSelf();
                }
            }
            return;
        }

        //  只在main函数中被调用的改为局部变量
        if(useFuncs.size() == 1 && useFuncs.get(0).getName().equals("@main")){
            Function function = useFuncs.get(0);
            BasicBlock bb = function.getFirstBlock();
            if(type instanceof IntType){
                int initVal = ((ConstInt) globalVariable.getInitVal()).getValue();
                Alloca allocInst = new Alloca(nameNumCounter++,type,bb);
                Store storeInst = new Store(bb,new ConstInt(initVal), allocInst);
                bb.insertHead(storeInst);
                bb.insertHead(allocInst);
                globalVariable.replaceAllUsesWith(allocInst);
            } else if(type instanceof FloatType){
                float initVal = ((ConstFloat) globalVariable.getInitVal()).getValue();
                Alloca allocInst = new Alloca(nameNumCounter++,type,bb);
                Store storeInst = new Store(bb,new ConstFloat(initVal), allocInst);
                bb.insertHead(storeInst);
                bb.insertHead(allocInst);
                globalVariable.replaceAllUsesWith(allocInst);
            }
            deleteList.add(globalVariable);
        }
    }
}

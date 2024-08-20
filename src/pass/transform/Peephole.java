package pass.transform;

import ast.Block;
import ir.*;
import ir.Module;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.IntType;
import pass.Pass;
import pass.analysis.PureFunction;

import java.lang.annotation.Retention;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import static ast.Node.builder;
import static config.Config.enableLLMMod;

public class Peephole implements Pass {

    private final Module module = Module.getModule();

    // storeAddr-storeInst Map
    private final HashMap<Value,Value> addr2store = new HashMap<>();
    private HashMap<String, GEP> GEPMap = new HashMap<>();
    private HashMap<Function, Boolean> is_pure = new HashMap<>();

    private Load finalLoad = null;
    private ArrayList<Store> stores = new ArrayList<>();

    private HashMap<BasicBlock,HashMap<Value,Load>> blockLoadMap = new HashMap<>();
    private LinkedHashMap<Load,Load> load2preLoad = new LinkedHashMap<>();


    private int mod = -1;
    @Override
    public void run() {
        PureFunction pureFunction = new PureFunction();
        pureFunction.markPure();
        this.is_pure = pureFunction.isPure;
        // store后紧接着的load,可以消掉load
        Peephole1();

        // store的值如果和load出来的值一样,且路径上没有对该地址load,可以删除路径上所有对该地址的store
        Peephole2();

        // 第二次 load 与第一次 load 之间所有可能的执行路径都没有 store, 弱化了一下
        Peephole3();

        if( enableLLMMod ){
            Peephole4();
        }
    }

    private void Peephole4(){
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions){
            if( function.getIsBuiltIn() )continue;
            if( function.getArguments().size() != 2 )continue;
            boolean flag = true;
            for( Argument argument : function.getArguments() ){
                if( !(argument.getValueType() instanceof IntType) ){
                    flag = false;
                    break;
                }
            }
            if( flag ){
                boolean tag = checkFunction(function);
                if( tag ){
                    BasicBlock entry = function.getFirstBlock(), newEntry;
                    newEntry = builder.buildBasicBlockBefore(function,entry);
                    ArrayList<Value> argList = new ArrayList<>();
                    argList.add(function.getArgument(0));
                    argList.add(function.getArgument(1));
                    argList.add(new ConstInt(mod));
                    Call call = builder.buildCall(newEntry,Function.llmmod,argList);
                    builder.buildRet(newEntry,call);
                }
            }
        }
    }

    private boolean checkFunction(Function function){
        BasicBlock curBlock = null;
        ArrayList<Instruction> curInstructions = new ArrayList<>();
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        if( blocks.size() != 7 )return false;
        curBlock = blocks.get(0);
        curInstructions = curBlock.getInstructionsArray();
        if( curInstructions.size() != 2 )return false;
        if( curInstructions.get(0) instanceof Icmp icmp && curInstructions.get(1) instanceof Br br ){
            if( !(icmp.getCondition().equals(Icmp.Condition.EQ) && icmp.getOp1().equals(function.getArgument(1)) && icmp.getOp2().equals(new ConstInt(0))
                && br.getHasCondition() && br.getCond().equals(icmp) && br.getTrueBlock().equals(blocks.get(1)) && br.getFalseBlock().equals(blocks.get(2)) ) ){
                return false;
            }
        } else return false;

        curBlock = blocks.get(1);
        curInstructions = curBlock.getInstructionsArray();
        if( curInstructions.size() != 1 )return false;
        if( curInstructions.get(0) instanceof Ret ret ){
            if( !(ret.getRetValue() != null && ret.getRetValue().equals(new ConstInt(0))) ){
                return false;
            }
        } else return false;

        curBlock = blocks.get(2);
        curInstructions = curBlock.getInstructionsArray();
        if( curInstructions.size() != 2 )return false;
        if( curInstructions.get(0) instanceof Icmp icmp_1 && curInstructions.get(1) instanceof Br br_1 ){
            if( !(icmp_1.getCondition().equals(Icmp.Condition.EQ) && icmp_1.getOp1().equals(function.getArgument(1)) && icmp_1.getOp2().equals(new ConstInt(1))
                    && br_1.getHasCondition() && br_1.getCond().equals(icmp_1) && br_1.getTrueBlock().equals(blocks.get(3)) && br_1.getFalseBlock().equals(blocks.get(4)) ) ){
                return false;
            }
        } else return false;

        curBlock = blocks.get(3);
        curInstructions = curBlock.getInstructionsArray();
        if( curInstructions.size() != 4 )return false;
        if( curInstructions.get(0) instanceof Sdiv sdiv3 && curInstructions.get(1) instanceof Mul mul3 && curInstructions.get(2) instanceof Sub sub3){
            if( sdiv3.getOp1().equals(function.getArgument(0))  && sdiv3.getOp2() instanceof ConstInt mod3 ){
                mod = mod3.getValue();
                if( mul3.getOp1().equals(sdiv3) && mul3.getOp2() instanceof ConstInt temp && temp.getValue() == mod ){
                    if( sub3.getOp1().equals(function.getArgument(0)) && sub3.getOp2().equals(mul3) ){
                        if( !(curInstructions.get(3) instanceof Ret ret3 && ret3.getRetValue() != null && ret3.getRetValue().equals(sub3)) ){
                            return false;
                        }
                    } else return false;
                } else return false;
            } else return false;
        } else return false;

        curBlock = blocks.get(4);
        curInstructions = curBlock.getInstructionsArray();
        if( curInstructions.size() != 9 )return false;
        if( !(curInstructions.get(0) instanceof Sdiv sdiv4 && sdiv4.getOp1().equals(function.getArgument(1)) && sdiv4.getOp2().equals(new ConstInt(2))) ){
            return false;
        }
        if( !(curInstructions.get(1) instanceof Call call && call.getFunction().equals(function) )){
            return false;
        }
        if( !(curInstructions.get(2) instanceof Add add4 && add4.getOp1().equals(call) && add4.getOp2().equals(call)) ){
            return false;
        }
        if( !(curInstructions.get(3) instanceof Sdiv sdiv4_1 && sdiv4_1.getOp1().equals(add4) && sdiv4_1.getOp2().equals(new ConstInt(mod))) ){
            return false;
        }
        if( !(curInstructions.get(4) instanceof Mul mul4_1 && mul4_1.getOp1().equals(sdiv4_1) && mul4_1.getOp2().equals(new ConstInt(mod))) ){
            return false;
        }
        if( !(curInstructions.get(5) instanceof Sub sub4_1 && sub4_1.getOp1().equals(add4) && sub4_1.getOp2().equals(mul4_1)) ){
            return false;
        }
        if( !(curInstructions.get(6) instanceof Srem srem4 && srem4.getOp1().equals(function.getArgument(1)) && srem4.getOp2().equals(new ConstInt(2))) ){
            return false;
        }
        if( curInstructions.get(7) instanceof Icmp icmp4 && icmp4.getCondition().equals(Icmp.Condition.EQ) ){
            if( !(icmp4.getOp1().equals(srem4) && icmp4.getOp2().equals(new ConstInt(1))) ){
                return false;
            }
        } else return false;
        if( curInstructions.get(8) instanceof Br br4 && br4.getHasCondition() ){
            if( !(br4.getCond().equals(icmp4) && br4.getTrueBlock().equals(blocks.get(5)) && br4.getFalseBlock().equals(blocks.get(6))) ){
                return false;
            }
        } else return false;

        curBlock = blocks.get(5);
        curInstructions = curBlock.getInstructionsArray();
        if( curInstructions.size() != 5 )return false;
        if( !(curInstructions.get(0) instanceof Add add5 && add5.getOp1().equals(sub4_1) && add5.getOp2().equals(function.getArgument(0))) ){
            return false;
        }
        if( !(curInstructions.get(1) instanceof Sdiv sdiv5 && sdiv5.getOp1().equals(add5) && sdiv5.getOp2().equals(new ConstInt(mod))) ){
            return false;
        }
        if( !(curInstructions.get(2) instanceof Mul mul5 && mul5.getOp1().equals(sdiv5) && mul5.getOp2().equals(new ConstInt(mod))) ){
            return false;
        }
        if( !(curInstructions.get(3) instanceof Sub sub5 && sub5.getOp1().equals(add5) && sub5.getOp2().equals(mul5)) ){
            return false;
        }
        if( !(curInstructions.get(4) instanceof Ret ret5 && ret5.getRetValue() != null &&ret5.getRetValue().equals(sub5)) ){
            return false;
        }

        curBlock = blocks.get(6);
        curInstructions = curBlock.getInstructionsArray();
        if( curInstructions.size() != 1 )return false;
        return curInstructions.get(0) instanceof Ret ret6 && ret6.getRetValue() != null && ret6.getRetValue().equals(sub4_1);
    }



    private void Peephole3(){
        ArrayList<Function> functions = module.getFunctionsArray();
        for(Function function : functions){
            if( function.getIsBuiltIn() )continue;
            runPeephole3OnFunction(function);
            ArrayList<Load> keyList = new ArrayList<>(load2preLoad.keySet());
            for (int i = keyList.size() - 1; i >= 0; i--) {
                Load load = keyList.get(i);
                Load preLoad = load2preLoad.get(load);
                load.replaceAllUsesWith(preLoad);
                load.removeSelf();
            }
        }
    }

    private void runPeephole3OnFunction(Function function){
        ArrayList<BasicBlock> blocks = getBlocksRank(function);
        for(BasicBlock basicBlock : blocks){
            LinkedHashMap<Value,Load> loads = new LinkedHashMap<>();
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for(Instruction instruction : instructions){
                if(instruction instanceof Load load ){
                    if( basicBlock.getPrecursors().size() == 1 ){
                        BasicBlock preBlock = basicBlock.getPrecursors().iterator().next();
                        if( blockLoadMap.containsKey(preBlock) ){
                            HashMap<Value,Load> preLoads = blockLoadMap.get(preBlock);
                            if( preLoads.containsKey(load.getAddr()) ){
                                Load preLoad = preLoads.get(load.getAddr());
                                load2preLoad.put(load,preLoad);
                            }
                        }
                    }
                    loads.put(load.getAddr(),load);
                } else if( instruction instanceof Store store ){
                    // TODO 有待加强
                    loads.clear();
                } else if( instruction instanceof Call call && !(is_pure.containsKey(call.getFunction()) && is_pure.get(call.getFunction()))){
                    loads.clear();
                }
            }
            blockLoadMap.put(basicBlock,loads);
        }
    }

    private void Peephole2(){
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            runPeephole2OnFunction(function);
        }
    }

    private void runPeephole2OnFunction(Function function){
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock basicBlock : blocks) {
            stores.clear();
            finalLoad = null;
            ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
            for (Instruction instruction : instructions) {
                if( instruction instanceof Load load ){
                    finalLoad = load;
                    stores.clear();
                } else if( instruction instanceof Store store ){
                    if( finalLoad == null ){
                        continue;
                    }
                    if( store.getAddr().equals(finalLoad.getAddr()) ){
                        stores.add(store);
                    }
                    if( store.getValue().equals(finalLoad) ){
                        deleteStore();
                    }
                }
            }
        }
    }
    private void deleteStore(){
        for(Store store : stores){
            store.removeSelf();
        }
        stores.clear();
    }

    private void Peephole1() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( function.getIsBuiltIn() )continue;
            BasicBlock entry = function.getFirstBlock();
            RPOSearch(entry);
        }
    }

    private void RPOSearch(BasicBlock block) {
        GEPMap.clear();
        addr2store.clear();
        ArrayList<Instruction> instructions = block.getInstructionsArray();
        for (Instruction instruction : instructions) {
            if( instruction instanceof Store store ){
                if( mysteriousStore(store.getAddr()) ){
                    addr2store.clear();
                } else addr2store.put(store.getAddr(), store);
            } else if( instruction instanceof Load load ){
                if( addr2store.containsKey(load.getAddr()) ){
                    Store store = (Store) addr2store.get(load.getAddr());
                    load.replaceAllUsesWith(store.getValue());
                    load.removeSelf();
                }
            } else if( instruction instanceof Call call && !(is_pure.containsKey(call.getFunction()) && is_pure.get(call.getFunction()))){
                //保守起见 碰到call非纯函数就清空
                addr2store.clear();
            } else if( instruction instanceof GEP gep){
                String hash = setHashValue(gep);
                if( GEPMap.containsKey(hash) ){
                    gep.replaceAllUsesWith(GEPMap.get(hash));
                    gep.removeSelf();
                } else GEPMap.put(hash, gep);
            }
        }

        for(BasicBlock idom : block.getIdoms()){
            RPOSearch(idom);
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

    private boolean mysteriousStore(Value pointer) {
        if( pointer instanceof GEP gep ){
            for( Value value : gep.getIndex() ){
                if( !(value instanceof ConstInt) ){
                    return true;
                }
            }
        }
        return false;
    }

    private String setHashValue(Instruction inst){
        if(inst instanceof GEP gepInst){
            StringBuilder hashBuilder = new StringBuilder(gepInst.getBase().getName());
            ArrayList<Value> indexs = gepInst.getIndex();
            for (Value index : indexs) {
                hashBuilder.append("[").append(index.getName()).append("]");
            }
//            System.out.println(hashBuilder);
            return hashBuilder.toString();
        }
        return null;
    }
}

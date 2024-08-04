package pass.transform.loop;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import ir.Value;
import ir.constants.ConstInt;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.Add;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.binaryInstructions.Mul;
import ir.instructions.otherInstructions.Phi;
import ir.types.IntType;
import pass.Pass;
import pass.analysis.Loop;
import pass.analysis.LoopVarAnalysis;
import utils.InductionVarInfo;

import java.util.*;

import static ast.Node.builder;



public class LoopStrengthReduction implements Pass {
    private final Module module = Module.getModule();

    private HashMap<Value, InductionVarInfo> inductionMap = new HashMap<>();

    private Value preHeaderValue;

    @Override
    public void run() {
        ArrayList<Function> functions = module.getFunctionsArray();
        for (Function function : functions) {
            if( !function.getIsBuiltIn() ){
                runOnFunction(function);
            }
        }
    }

    private void runOnFunction(Function function){
        LoopVarAnalysis loopVarAnalysis = new LoopVarAnalysis();
        loopVarAnalysis.loopVarAnalysis(function);
        ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
        for (BasicBlock block : blocks) {
            if( block.isLoopHeader() ){
                runOnLoop(block.getLoop());
            }
        }
    }

    private void runOnLoop(Loop loop){
        if (!loop.isSimpleLoop() || !loop.isInductorVarSet()) {
            return;
        }
        if (loop.hasChildLoop()) {
            return;
        }
        //只有head和latch的简单循环
        for (BasicBlock bb: loop.getAllBlocks()) {
            if (!bb.isLoopHeader() && !bb.isLoopLatch()) {
                return;
            }
        }
        //只有head和latch的简单循环
        if (!loop.getHeader().isLoopExiting()) {
            return;
        }
        BasicBlock header = loop.getHeader();
        if( loop.getEnterings().size() != 1 || header.getPrecursors().size() != 2){
            return;
        }
        BasicBlock preHeaderBasicBlock = new HashSet<>(loop.getEnterings()).iterator().next();
        BasicBlock incrementBasicBlock = null;

        ArrayList<Instruction> instructions = header.getInstructionsArray();
        for (Instruction instruction : instructions) {
            if( instruction instanceof Phi phi ){
                InductionVarInfo inductionVarInfo = new InductionVarInfo(instruction,0,1,true);
                int n = phi.getPrecursorNum();
                for ( int i = 0 ; i < n ; i++ ) {
                    BasicBlock incomingBlock = (BasicBlock) phi.getOperator(i+n);
                    if( preHeaderBasicBlock.equals(incomingBlock) ){
                        inductionVarInfo.preheaderValue = phi.getOperator(i);
                        preHeaderValue = phi.getOperator(i);
                    } else {
                        incrementBasicBlock = incomingBlock;
                    }
                }

                inductionMap.put(instruction, inductionVarInfo);
            }
        }

        ArrayList<BasicBlock> loopBlocks = loop.getAllBlocks();
        for (BasicBlock block : loopBlocks) {
            ArrayList<Instruction> instrs = block.getInstructionsArray();
            for (Instruction instr : instrs) {
                if( instr instanceof BinaryInstruction binary ){
                    Value left = binary.getOp1();
                    Value right = binary.getOp2();

                    if( inductionMap.containsKey(left) || inductionMap.containsKey(right) ){
                        Value constant, variable;

                        if( left instanceof ConstInt){
                            variable = right;
                            constant = left;
                        } else if( right instanceof ConstInt){
                            variable = left;
                            constant = right;
                        } else {
                            continue;
                        }

                        InductionVarInfo idcVarOld = inductionMap.get(variable);
                        int newFactor = ((ConstInt) constant).getValue();

                        InductionVarInfo newIdcVarInfo = new InductionVarInfo(idcVarOld.parent,0,1,false);
                        if( binary instanceof Mul mul ){
                            newIdcVarInfo.multiplicativeStep = newFactor * idcVarOld.multiplicativeStep;
                            newIdcVarInfo.additiveStep = newFactor * idcVarOld.additiveStep;

                            inductionMap.put(mul,newIdcVarInfo);
                        } else if( binary instanceof Add add ){
                            newIdcVarInfo.additiveStep = newFactor + idcVarOld.additiveStep;
                            newIdcVarInfo.multiplicativeStep = idcVarOld.multiplicativeStep;

                            inductionMap.put(add,newIdcVarInfo);
                        }
                    }
                }
            }
        }

        HashMap<Value,Phi> phiMap = new HashMap<>();
        ArrayList<Instruction> headInsts = header.getInstructionsArray();
        for (Instruction instr : headInsts) {
            if( instr instanceof Phi phi ){
                for(Value instruction : inductionMap.keySet()){
                    if( inductionMap.get(instruction).multiplicativeStep != 1 &&
                        inductionMap.get(instruction).additiveStep != 0 ){
                        Value newIncomingValue = calculateNewIncomingValue(phi,inductionMap.get(instruction));


                        Phi newPhi = builder.buildPhi(new IntType(32),phi.getParent(),1);

                        newPhi.addIncoming(newIncomingValue,preHeaderBasicBlock);

                        phiMap.put(instruction,newPhi);
                    }
                }
            }
        }

        for(Value key : inductionMap.keySet()){
            InductionVarInfo idcVarInfo = inductionMap.get(key);
            if( phiMap.containsKey(key) && (inductionMap.get(key).multiplicativeStep != 1 && inductionMap.get(key).additiveStep != 0 ) ){
                if( incrementBasicBlock != null ){
                    ArrayList<Instruction> instrs = incrementBasicBlock.getInstructionsArray();
                    for(Instruction instr : instrs){
//                        System.out.println(incrementBasicBlock.getName());
                        if( instr instanceof BinaryInstruction binary ){
                            Value lhs = binary.getOp1(), rhs = binary.getOp2();
                            if( lhs == idcVarInfo.parent || rhs == idcVarInfo.parent ){
                                InductionVarInfo incIdcVarInfo = inductionMap.get(instr);
                                int newIncrement = incIdcVarInfo.additiveStep * idcVarInfo.multiplicativeStep;

                                Phi phiVal = phiMap.get(key);

                                Value newIncrementInstruction = builder.buildAddBeforeInstr(instr.getParent(),new IntType(32),phiVal,new ConstInt(newIncrement), instr);

                                phiVal.addIncoming(newIncrementInstruction,incrementBasicBlock);
                            }
                        }
                    }
                }

            }
        }

        for (Value key : phiMap.keySet() ){
            key.replaceAllUsesWith(phiMap.get(key));
        }
    }

    private Value calculateNewIncomingValue(Phi phi, InductionVarInfo inductionVarInfo){
        Value newIncomingValue = builder.buildMulBeforeInstr(phi.getParent(),new IntType(32),preHeaderValue,new ConstInt(inductionVarInfo.multiplicativeStep),phi);
        newIncomingValue = builder.buildAddBeforeInstr(phi.getParent(),new IntType(32), newIncomingValue,new ConstInt(inductionVarInfo.additiveStep),phi );
        return newIncomingValue;
    }


}

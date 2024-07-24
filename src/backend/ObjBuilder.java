package backend;

import backend.RegisterAlloc.RegisterAllocer;
import backend.Utils.ImmediateUtils;
import backend.instruction.*;
import backend.module.ObjBlock;
import backend.module.ObjFunction;
import backend.module.ObjGlobalVariable;
import backend.module.ObjModule;
import backend.operand.*;
import ir.*;
import ir.Module;
import ir.constants.*;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.BinaryInstruction;
import ir.instructions.binaryInstructions.Icmp;
import ir.instructions.binaryInstructions.Srem;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.instructions.memoryInstructions.Store;
import ir.instructions.otherInstructions.Call;
import ir.instructions.otherInstructions.Conversion;
import ir.instructions.otherInstructions.Phi;
import ir.instructions.otherInstructions.Zext;
import ir.instructions.terminatorInstructions.Br;
import ir.instructions.terminatorInstructions.Ret;
import ir.types.*;

import java.util.*;

public class ObjBuilder {
    private static final ObjBuilder builder = new ObjBuilder();

    public static ObjBuilder getObjBuilder() {
        return builder;
    }

    private Module module = IrBuilder.getIrBuilder().module;

    private ObjModule objModule = ObjModule.getModule();
    private HashMap<Value, ObjOperand> v2mMap = new HashMap<>();

    private static HashMap<String, ObjBlock> n2mbMap = new HashMap<>();

    public static ObjBlock[] getSucc(String name) {
        ObjBlock[] succs = new ObjBlock[2];
        String[] succnames = succMap.get(name);
        if (succnames[0] != null)
            succs[0] = n2mbMap.get(succnames[0]);
        if (succnames[1] != null)
            succs[1] = n2mbMap.get(succnames[1]);
        return succs;
    }


    private static HashMap<String, ArrayList<String>> preMap = new HashMap<>();
    private static HashMap<String, String[]> succMap = new HashMap<>();

    private void firstPass() {
        for (Value function : module.getFunctions()) {
            for (Value block : ((Function) function).getBasicBlocks()) {
                preMap.put(block.getName().substring(1), new ArrayList<>());
                succMap.put(block.getName().substring(1), new String[2]);
            }
        }
    }

    public void build() {
        // 处理全局变量
        LinkedList<Value> globalVariables = module.getGlobalVariables();
        for (Value globalVariable : globalVariables) {
            ObjGlobalVariable o = buildGlobalVar((GlobalVariable) globalVariable);
            objModule.addGlobalVariable(o);
        }
        firstPass();
        for (Value function : module.getFunctions()) {
            if (!((Function) function).getIsBuiltIn()) {
                ObjFunction objFunction = buildObjFunc((Function) function);
                objModule.addFunction(objFunction);
                buildPhi((Function) function, objFunction);

            }
        }
        RegisterAllocer rar = new RegisterAllocer(objModule);
        rar.alloc(true);
        rar.alloc(false);
        for (ObjFunction function : objModule.getFunctions()) {
            placeLiteralPool(function);
        }
    }

    private void placeLiteralPool(ObjFunction function) {
        boolean haveLoadFImm = false;
        int offset = 0;
        List<ObjBlock> blocks = new ArrayList<>(function.getBlocks());
        for (ObjBlock block : blocks) {
            List<ObjInstruction> insts = new LinkedList<>(block.getInstructions());
            for (ObjInstruction inst : insts) {
                if (inst.needLtorg()) {
                    haveLoadFImm = true;
                }
                if (inst.haveLtorg()) {
                    haveLoadFImm = false;
                    offset = 0;
                }
                if (haveLoadFImm) {
                    offset += getLtorgSize(inst);
                }
                if (offset > 250) {
                    ObjInstruction pool = new LiteralPoolPlacement();
                    block.addInstructionAfter(inst, pool);
                    haveLoadFImm = false;
                    offset = 0;
                }
            }
        }
    }

    private int getLtorgSize(ObjInstruction inst) {
        if (inst instanceof Binary) {
            return 1;
        } else if (inst instanceof ObjJump) {
            if (((ObjJump) inst).getTarget() == null)
                return 7;
            return inst.getCond() == ObjInstruction.ObjCond.any ? 2 : 1;
        } else if (inst instanceof ObjCall) {
            return 1;
        } else if (inst instanceof ObjCompare) {
            return ((ObjCompare) inst).isVFP() ? 2 : 1;
        } else if (inst instanceof VConvert) {
            return 1;
        } else if (inst instanceof ObjLoad) {
            return 2;
        } else if (inst instanceof LiteralPoolPlacement) {
            return 3;
        } else if (inst instanceof ObjMove) {
            return 2;
        } else if (inst instanceof ObjStore) {
            return 1;
        } else return 1;
    }


    public ObjGlobalVariable buildGlobalVar(GlobalVariable globalVariable) {
        Constant initVal = globalVariable.getInitVal();
        if (initVal instanceof ZeroInitializer) {
            return new ObjGlobalVariable(globalVariable.getName(), initVal.getValueType().getSize());
        } else if (initVal instanceof ConstInt) {
            ArrayList<Integer> elements = new ArrayList<>();
            elements.add(((ConstInt) initVal).getValue());
            return new ObjGlobalVariable(globalVariable.getName(), elements, ObjGlobalVariable.Type.INT);
        } else if (initVal instanceof ConstFloat) {
            ArrayList<Float> elements = new ArrayList<>();
            elements.add(((ConstFloat) initVal).getValue());
            return new ObjGlobalVariable(globalVariable.getName(), elements, ObjGlobalVariable.Type.FLOAT);
        } else if (initVal instanceof ConstArray) {
            ArrayList<Constant> el = ((ConstArray) initVal).getElementList();
            ObjGlobalVariable.Type type = el.get(0).getValueType().isFloat() ? ObjGlobalVariable.Type.FLOAT : ObjGlobalVariable.Type.INT;
            ArrayList elements = new ArrayList<>();
            if (type == ObjGlobalVariable.Type.FLOAT) {
                for (Constant constant : el) {
                    elements.add(((ConstFloat) constant).getValue());
                }
            } else {
                for (Constant constant : el) {
                    elements.add(((ConstInt) constant).getValue());
                }
            }
            return new ObjGlobalVariable(globalVariable.getName(), elements, type);
        }
        return new ObjGlobalVariable(globalVariable.getName(), ((ConstStr) initVal).getContent());
    }

    public ObjFunction buildObjFunc(Function function) {
        ObjFunction objFunction = new ObjFunction(function.getName());
        for (BasicBlock basicBlock : function.getBasicBlocksArray()) {
            objFunction.addObjBlock(buildBasicBlock(objFunction, basicBlock));
        }
        return objFunction;
    }

    public ObjBlock buildBasicBlock(ObjFunction objFunction, BasicBlock basicBlock) {
        ObjBlock objBlock = new ObjBlock(basicBlock.getName());
        n2mbMap.put(objBlock.getName(), objBlock);
        for (Instruction instruction : basicBlock.getInstructions()) {
            ObjInstruction objInstruction = buildInstruction(instruction, objBlock, objFunction);
            if (objInstruction != null)
                objBlock.addInstruction(objInstruction);
        }
        return objBlock;
    }

    private ObjInstruction buildInstruction(Instruction instruction, ObjBlock objBlock, ObjFunction objFunction) {
        if (instruction instanceof Alloca) {
            return buildAlloca((Alloca) instruction, objBlock, objFunction);
        } else if (instruction instanceof Load) {
            return buildLoad((Load) instruction, objBlock, objFunction);
        } else if (instruction instanceof Store) {
            return buildStore((Store) instruction, objBlock, objFunction);
        } else if (instruction instanceof Conversion) {
            return buildConversion((Conversion) instruction, objBlock, objFunction);
        } else if (instruction instanceof Br) {
            return buildBranch((Br) instruction, objBlock, objFunction);
        } else if (instruction instanceof Ret) {
            return buildRet((Ret) instruction, objBlock, objFunction);
        } else if (instruction instanceof Call) {
            return buildCall((Call) instruction, objBlock, objFunction);
        } else if (instruction instanceof BinaryInstruction) {
            return buildBinary((BinaryInstruction) instruction, objBlock, objFunction);
        } else if (instruction instanceof GEP) {
            return buildGEP((GEP) instruction, objBlock, objFunction);
        } else if (instruction instanceof Zext) {
            v2mMap.put(instruction, v2mMap.get(((Zext) instruction).getConversionValue()));
        }
        // TODO: PHI
        return null;
    }

    private ObjInstruction buildGEP(GEP gep, ObjBlock objBlock, ObjFunction objFunction) {
        Value base = gep.getBase();
        ValueType baseType = gep.getBaseType();
        ObjOperand rs = v2mMap.containsKey(base) ? v2mMap.get(base) : putNewVGtoMap(base, objFunction, objBlock);
        ObjOperand rd = createVirRegister(gep);
        if (base instanceof GlobalVariable) {
            objBlock.addInstruction(new ObjMove(rs, new ObjLabel(base.getName().substring(1), true), false, false));
//            objBlock.addInstruction(new ObjLoad(rs, rs, base.getValueType().isFloat()));
        }
        ArrayList<Value> indexes = gep.getIndex();
        if (indexes.size() == 1) {  // gep 1
            Value off1 = indexes.get(0);
            if (off1 instanceof ConstInt) {
                if (((ConstInt) off1).getValue() != 0) {
                    return new Binary(rd, rs, solveImm(((ConstInt) off1).getValue() * baseType.getSize(), objBlock), Binary.BinaryType.add);
                } else {
                    v2mMap.put(gep, rs);
                }
            } else {
                ObjRegister off = v2mMap.containsKey(off1) ? (ObjRegister) v2mMap.get(off1) : putNewVGtoMap(off1, objFunction, objBlock);
//                    objBlock.addMIPSInstruction(new IInstruction("mul  ", off, rd, new MIPSImmediate(baseType.getSize())));
                objBlock.addInstruction(new ObjMove(rd, new ObjImmediate(baseType.getSize()), false, true));
                ObjInstruction i = new MLA(rd, off, rd, rs);
//                i.setShift(new Shift(Binary.BinaryType.sl, baseType.getSize() / 2));
                return i;
            }
        } else {    // gep 1 2
            ValueType elementType = ((ArrayType) baseType).getElementType();
            Value off1 = indexes.get(0);
            Value off2 = indexes.get(1);
            if (off1 instanceof ConstInt) {
                if (((ConstInt) off1).getValue() != 0) {
                    objBlock.addInstruction(new Binary(rd, rs, solveImm(((ConstInt) off1).getValue() * baseType.getSize(), objBlock), Binary.BinaryType.add));
                } else {
                    objBlock.addInstruction(new ObjMove(rd, rs, false, false));
                }
            } else {
                ObjOperand off = v2mMap.containsKey(off1) ? v2mMap.get(off1) : putNewVGtoMap(off1, objFunction, objBlock);
//                objBlock.addInstruction(new Binary(off, off, solveImm(baseType.getSize(), objBlock), Binary.BinaryType.mul));
//                ObjInstruction i = new Binary(rd, rs, off, Binary.BinaryType.add);
////                i.setShift(new Shift(Binary.BinaryType.sl, baseType.getSize() / 2));
//                objBlock.addInstruction(i);
                objBlock.addInstruction(new ObjMove(rd, new ObjImmediate(baseType.getSize()), false, true));
                objBlock.addInstruction(new MLA(rd, off, rd, rs));
            }
            if (off2 instanceof ConstInt) {
                if (((ConstInt) off2).getValue() != 0) {
                    objBlock.addInstruction(new Binary(rd, rd, solveImm(((ConstInt) off2).getValue() * elementType.getSize(), objBlock), Binary.BinaryType.add));
//                        v2mMap.replace(instruction, rd);
                } else {
//                    objBlock.addInstruction(new ObjMove(rd, rd));
                }
            } else {
                ObjOperand off = v2mMap.containsKey(off2) ? v2mMap.get(off2) : putNewVGtoMap(off2, objFunction, objBlock);
//                    objBlock.addMIPSInstruction(new IInstruction("mul  ", off, off, new MIPSImmediate(elementType.getSize())));
//                MIPSRegister tmp2 = new VirtualRegister();
//                MulOptimizer.mulOptimization(objBlock, tmp2, off, new MIPSImmediate(elementType.getSize()));
//                    v2mMap.replace(instruction, rd);
//                objBlock.addInstruction(new Binary(off, off, solveImm(elementType.getSize(), objBlock), Binary.BinaryType.mul));
//                ObjInstruction i = new Binary(rd, rd, off, Binary.BinaryType.add);
//                i.setShift(new Shift(Binary.BinaryType.sl, elementType.getSize() / 2));
                ObjRegister tmp = new ObjVirRegister();
                objBlock.addInstruction(new ObjMove(tmp, new ObjImmediate(elementType.getSize()), false, true));
                return new MLA(rd, off, tmp, rd);
            }
        }
        return null;
    }

    private ObjInstruction buildBinary(BinaryInstruction binary, ObjBlock objBlock, ObjFunction objFunction) {

        Value l = binary.getOp1(), r = binary.getOp2();
        ObjOperand rl = v2mMap.containsKey(l) ? v2mMap.get(l) : putNewVGtoMap(l, objFunction, objBlock),
                rr = v2mMap.containsKey(r) ? v2mMap.get(r) : putNewVGtoMap(r, objFunction, objBlock);
        ObjRegister rd = createVirRegister(binary);
        if (l instanceof ConstInt) {
            objBlock.addInstruction(new ObjMove(rl, new ObjImmediate(((ConstInt) l).getValue()), false, true));
        } else if (l instanceof ConstFloat) {
            objBlock.addInstruction(new ObjMove(rl, new ObjFloatImmediate(((ConstFloat) l).getValue()), true, true));
        }
        if (r instanceof ConstInt) {
            objBlock.addInstruction(new ObjMove(rr, new ObjImmediate(((ConstInt) r).getValue()), false, true));
        } else if (r instanceof ConstFloat) {
            objBlock.addInstruction(new ObjMove(rr, new ObjFloatImmediate(((ConstFloat) r).getValue()), true, true));
        }
        if (binary instanceof Srem) {
            objBlock.addInstruction(new Binary(rd, rl, rr, Binary.BinaryType.sdiv));
            objBlock.addInstruction(new Binary(rd, rd, rr, Binary.BinaryType.mul));
            return new Binary(rd, rl, rd, Binary.BinaryType.sub);
        }
        if (binary instanceof Icmp)
            return new ObjCompare(rl, rr, l.getValueType().isFloat() || r.getValueType().isFloat());
        if (binary.getValueType().isFloat())
            return new FloatBinary(rd, rl, rr, FloatBinary.FloatBinaryType.switchIrToObj(binary));
        return new Binary(rd, rl, rr, Binary.BinaryType.switchIrToObj(binary));
    }


    private ObjInstruction buildAlloca(Alloca alloca, ObjBlock objBlock, ObjFunction objFunction) {
        ValueType type = ((PointerType) alloca.getValueType()).getPointeeType();
        ObjRegister rd = putNewVGtoMap(alloca, objFunction, objBlock);
        ObjInstruction add = new Binary(rd, ObjPhyRegister.getRegister(13), solveImm(objFunction.getAllocSize(), objBlock), Binary.BinaryType.add);
        objFunction.addAllocSize(type.getSize());
        return add;
    }

    private ObjInstruction buildLoad(Load load, ObjBlock objBlock, ObjFunction objFunction) {
        Value addr = load.getAddr();
        ObjRegister rd = createVirRegister(load);
        if (addr instanceof GlobalVariable) {
            objBlock.addInstruction(new ObjMove(rd, new ObjLabel(addr.getName().substring(1), true), false, false));
            return new ObjLoad(rd, rd, ((PointerType) addr.getValueType()).getPointeeType().isFloat());
        }
        ObjOperand rs = v2mMap.containsKey(addr) ? v2mMap.get(addr) : putNewVGtoMap(addr, objFunction, objBlock);
        return new ObjLoad(rd, rs, null, ((PointerType) addr.getValueType()).getPointeeType().isFloat());
    }

    private ObjInstruction buildStore(Store store, ObjBlock objBlock, ObjFunction objFunction) {
        Value addr = store.getAddr();
        Value value = store.getValue();
        ObjOperand rs = v2mMap.containsKey(value) ? v2mMap.get(value) : putNewVGtoMap(value, objFunction, objBlock);
        ObjOperand rd = v2mMap.containsKey(addr) ? v2mMap.get(addr) : putNewVGtoMap(addr, objFunction, objBlock);
        if (value instanceof ConstInt) {
            objBlock.addInstruction(new ObjMove(rs, new ObjImmediate(((ConstInt) value).getValue()), false, true));
        } else if (value instanceof ConstFloat) {
            objBlock.addInstruction(new ObjMove(rs, new ObjFloatImmediate(((ConstFloat) value).getValue()), true, true));
        }
        if (addr instanceof GlobalVariable) {
            objBlock.addInstruction(new ObjMove(rd, new ObjLabel(addr.getName().substring(1), true), false, false));
//            objBlock.addInstruction(new ObjLoad(rd, rd, false));
        }
        return new ObjStore(rd, rs, ((PointerType) addr.getValueType()).getPointeeType().isFloat());
    }

    private ObjInstruction buildConversion(Conversion conversion, ObjBlock objBlock, ObjFunction objFunction) {
        Value value = conversion.getConversionValue();
        ObjOperand rs = v2mMap.containsKey(value) ? v2mMap.get(value) : putNewVGtoMap(value, objFunction, objBlock);
        if (value instanceof ConstInt) {
            objBlock.addInstruction(new ObjMove(rs, new ObjImmediate(((ConstInt) value).getValue()), false, true));
        } else if (value instanceof ConstFloat) {
            objBlock.addInstruction(new ObjMove(rs, new ObjFloatImmediate(((ConstFloat) value).getValue()), true, true));
        }
        ObjOperand rd = createVirRegister(conversion);
        if ("fptosi".equals(conversion.getType())) {
            objBlock.addInstruction(new VConvert(VConvert.vcvtType.f, VConvert.vcvtType.s, rs, rs));
            return new ObjMove(rd, rs, true, false);
        } else {
            objBlock.addInstruction(new ObjMove(rd, rs, true, false));
            return new VConvert(VConvert.vcvtType.s, VConvert.vcvtType.f, rd, rd);
        }

    }

    /**
     * 通用寄存器参数
     * R0 到 R3：这四个寄存器通常用于传递前四个整数或指针类型的参数。
     * R1：特别地，R1也可以用于传递64位整数的高32位。
     * 浮点数参数
     * S0 到 S15：用于传递单精度浮点数参数。
     * D0 到 D7：用于传递双精度浮点数参数。每个D寄存器可以存储两个S寄存器的值。
     */
    // TODO : use def添加
    private ObjInstruction buildCall(Call call, ObjBlock objBlock, ObjFunction objFunction) {
        Function func = call.getFunction();
        if ("@memset".equals(func.getName())) {
            return null;
        }
        ObjCall objCall = new ObjCall(new ObjFunction(func.getName()));
        int argnum = call.getArgs().size();
        int findex = 0, index = 0;
        int argnumS[] = call.getArgNum();
        int num = ((argnumS[0] > 4) ? (argnumS[0] - 4) : 0) + ((argnumS[1] > 16) ? (argnumS[1] - 16) : 0);
        int stacknum = 0;
        for (int i = 0; i < argnum; i++) {
            Value argument = call.getArgs().get(i);
            if (argument.getValueType().isFloat()) {
                if (argument instanceof ConstFloat) {
                    if (findex < 16) {
                        ObjFloatPhyReg dst = ObjFloatPhyReg.getRegister(findex);
                        objBlock.addInstruction(new ObjMove(dst, new ObjFloatImmediate(((ConstFloat) argument).getValue()), true, true));
                        objCall.addUse(dst);
                    } else { // 参数入栈
                        ObjOperand offset = new ObjImmediate((stacknum - num) * 4);
                        ObjOperand src = new ObjFloatVirReg();
                        objBlock.addInstruction(new ObjMove(src, new ObjFloatImmediate(((ConstFloat) argument).getValue()), true, true));
                        objBlock.addInstruction(new ObjStore(ObjPhyRegister.getRegister("sp"), src, solveOffsetImm(offset, objBlock, true), true));
                        stacknum++;
                    }
                } else {
                    if (findex < 16) { // 移入浮点寄存器
                        ObjFloatPhyReg dst = ObjFloatPhyReg.getRegister(findex);
                        ObjOperand src = v2mMap.containsKey(argument) ? v2mMap.get(argument) : putNewVGtoMap(argument, objFunction, objBlock);
                        objBlock.addInstruction(new ObjMove(dst, src, true, false));
                        objCall.addUse(dst);
                    } else { // 入栈
                        ObjOperand offset = new ObjImmediate((stacknum - num) * 4);
                        ObjOperand src = v2mMap.containsKey(argument) ? v2mMap.get(argument) : putNewVGtoMap(argument, objFunction, objBlock);
                        objBlock.addInstruction(new ObjStore(ObjPhyRegister.getRegister("sp"), src, solveOffsetImm(offset, objBlock, true), true));
                        stacknum++;
                    }
                }
                findex++;
            } else {    // 整数类型
                if (argument instanceof ConstInt) {
                    if (index < 4) {
                        ObjRegister dst = ObjPhyRegister.getRegister(index);
                        objBlock.addInstruction(new ObjMove(dst, new ObjImmediate(((ConstInt) argument).getValue()), false, true));
                        objCall.addUse(dst);
                    } else { // 参数入栈
                        ObjOperand offset = new ObjImmediate((stacknum - num) * 4);
                        ObjOperand src = new ObjVirRegister();
                        objBlock.addInstruction(new ObjMove(src, new ObjImmediate(((ConstInt) argument).getValue()), false, true));
                        objBlock.addInstruction(new ObjStore(ObjPhyRegister.getRegister("sp"), src, solveOffsetImm(offset, objBlock, false), false));
                        stacknum++;
                    }
                } else {
                    if (index < 4) { // 移入寄存器
                        ObjRegister dst = ObjPhyRegister.getRegister(index);
                        ObjOperand src = v2mMap.containsKey(argument) ? v2mMap.get(argument) : putNewVGtoMap(argument, objFunction, objBlock);
                        objBlock.addInstruction(new ObjMove(dst, src, false, false));
                        objCall.addUse(dst);
                    } else { // 入栈
                        ObjOperand offset = new ObjImmediate((stacknum - num) * 4);
                        ObjOperand src = v2mMap.containsKey(argument) ? v2mMap.get(argument) : putNewVGtoMap(argument, objFunction, objBlock);
                        objBlock.addInstruction(new ObjStore(ObjPhyRegister.getRegister("sp"), src, solveOffsetImm(offset, objBlock, false), false));
                        stacknum++;
                    }
                }
                index++;
            }
        }
        boolean flag = false;
        if (argnumS[0] > 4 || argnumS[1] > 16) {
            objBlock.addInstruction(new Binary(ObjPhyRegister.getRegister("sp"), ObjPhyRegister.getRegister("sp"), solveImm(4 * num, objBlock), Binary.BinaryType.sub));
            flag = true;
        }
        for (int i = 0; i < 4; ++i) {
            objCall.addDef(ObjPhyRegister.getRegister(i));
            objCall.addDef(ObjFloatPhyReg.getRegister(i));
        }
        objCall.addDef(ObjPhyRegister.getRegister("lr"));
        objBlock.addInstruction(objCall);
        if (flag) {
            objBlock.addInstruction(new Binary(ObjPhyRegister.getRegister("sp"), ObjPhyRegister.getRegister("sp"), solveImm(4 * num, objBlock), Binary.BinaryType.add));
        }
        DataType returnType = (call.getFunction()).getReturnType();

        // 返回值
        if (!(returnType instanceof VoidType)) {
            ObjRegister rd = createVirRegister(call);
            ObjRegister rs = returnType.isFloat() ? ObjFloatPhyReg.getRegister(0) : ObjPhyRegister.getRegister(0);
            objBlock.addInstruction(new ObjMove(rd, rs, returnType.isFloat(), false));
        }
        return null;
    }

//    private ObjInstruction buildIcmp(Icmp icmp, ObjBlock objBlock, ObjFunction objFunction) {
//        Value l = icmp.getOp1(), r = icmp.getOp2();
//        ObjOperand rl = v2mMap.containsKey(l) ? v2mMap.get(l) : putNewVGtoMap(l, objFunction, objBlock),
//                rr = v2mMap.containsKey(r) ? v2mMap.get(r) : putNewVGtoMap(r, objFunction, objBlock);
//        if (l instanceof ConstInt) {
//            objBlock.addInstruction(new ObjMove(rl, new ObjImmediate(((ConstInt) l).getValue()), false, true));
//        } else if (l instanceof ConstFloat) {
//            objBlock.addInstruction(new ObjMove(rl, new ObjFloatImmediate(((ConstFloat) l).getValue()), true, true));
//        }
//        if (r instanceof ConstInt) {
//            objBlock.addInstruction(new ObjMove(rr, new ObjImmediate(((ConstInt) r).getValue()), false, true));
//        } else if (r instanceof ConstFloat) {
//            objBlock.addInstruction(new ObjMove(rr, new ObjFloatImmediate(((ConstFloat) r).getValue()), true, true));
//        }
//        return new ObjCompare(rl, rr, l.getValueType().isFloat() || r.getValueType().isFloat());
//    }

    // TODO : 前驱后继块
    private ObjInstruction buildBranch(Br br, ObjBlock objBlock, ObjFunction objFunction) {
        ArrayList<Value> ops = br.getOps();
        if (!br.getHasCondition() || ops.get(0) instanceof ConstInt) {
            succMap.get(objBlock.getName())[0] = ops.get(0).getName().substring(1);
            preMap.get(ops.get(0).getName().substring(1)).add(objBlock.getName());
            return new ObjJump(new ObjBlock(ops.get(0).getName()));
        } else {
            Icmp condition = (Icmp) ops.get(0);
            ObjRegister rs = v2mMap.containsKey(condition) ? (ObjRegister) v2mMap.get(condition) : putNewVGtoMap(condition, objFunction, objBlock);
            objBlock.addInstruction(new ObjJump(ObjInstruction.ObjCond.switchIr2Obj(condition.getCondition()), new ObjBlock(ops.get(1).getName())));
            succMap.get(objBlock.getName())[0] = ops.get(1).getName().substring(1);
            succMap.get(objBlock.getName())[1] = ops.get(2).getName().substring(1);
            preMap.get(ops.get(1).getName().substring(1)).add(objBlock.getName());
            preMap.get(ops.get(2).getName().substring(1)).add(objBlock.getName());
            return new ObjJump(new ObjBlock(ops.get(2).getName()));
        }
    }

    private ObjInstruction buildRet(Ret ret, ObjBlock objBlock, ObjFunction objFunction) {
        Value irRetValue = ret.getRetValue();
        if (irRetValue != null) {
            if (irRetValue instanceof ConstInt) {
                objBlock.addInstruction(new ObjMove(ObjPhyRegister.getRegister(0), new ObjImmediate(((ConstInt) irRetValue).getValue()), false, true));
            } else if (irRetValue instanceof ConstFloat) {
                objBlock.addInstruction(new ObjMove(ObjFloatPhyReg.getRegister(0), new ObjFloatImmediate(((ConstFloat) irRetValue).getValue()), true, true));
            } else {
                ObjOperand rs = v2mMap.containsKey(irRetValue) ? v2mMap.get(irRetValue) : putNewVGtoMap(irRetValue, objFunction, objBlock);
                if (irRetValue.getValueType().isFloat())
                    objBlock.addInstruction(new ObjMove(ObjFloatPhyReg.getRegister(0), rs, true, false));
                else
                    objBlock.addInstruction(new ObjMove(ObjPhyRegister.getRegister(0), rs, false, false));
            }
        }
        return new ObjJump(objFunction);
    }

    private ObjRegister buildArgument(Argument arg, ObjFunction objFunction, ObjBlock objBlock, ObjRegister objRegister) {
        if (v2mMap.containsKey(arg))
            return (ObjRegister) v2mMap.get(arg);
        int rank = arg.getArgRank();
        ObjRegister rd = objRegister;
        if ((arg.getValueType().isFloat() && rank < 16) || (!arg.getValueType().isFloat() && rank < 4)) {
            ObjRegister rs = arg.getValueType().isFloat() ? ObjFloatPhyReg.getRegister(rank) : ObjPhyRegister.getRegister(rank);
            if (objFunction.getBlocks().size() > 0)
                objFunction.getBlocks().get(0).addInstructionToHead(new ObjMove(rd, rs, arg.getValueType().isFloat(), false));
            else
                objBlock.addInstructionToHead(new ObjMove(rd, rs, arg.getValueType().isFloat(), false));
        } else {
            int stackPos = arg.getStackPos();
            assert stackPos >= 0;
            // 这个栈位置后面要寄存器分配后可能需要refresh
            ObjInstruction loadArg = creatArgLoad(rd, stackPos, objBlock, arg.getValueType().isFloat());
            ObjBlock b = objBlock;
//            if (objFunction.getBlocks().size() > 0) {
//                b = objFunction.getBlocks().get(0);
//                b.addInstructionToHead(loadArg);
//            } else {
            b.addInstruction(loadArg);
//            }
            objFunction.addArgInstructions(loadArg, b);
        }
        return rd;
    }

    private ObjInstruction creatArgLoad(ObjRegister rd, int stackPos, ObjBlock objBlock, boolean isFloat) {
        if (ImmediateUtils.checkOffsetRange(stackPos * 4, isFloat)) {
            return new ObjLoad(rd, ObjPhyRegister.getRegister("sp"), new ObjImmediate(stackPos * 4), isFloat);
        } else {
            ObjRegister rs = new ObjVirRegister();
            ObjMove move = new ObjMove(rs, new ObjImmediate(stackPos * 4), false, true);
            objBlock.addInstruction(move);
            return new ObjLoad(rd, ObjPhyRegister.getRegister("sp"), rs, isFloat, move);    // 将Move添加进load中，便于后面更新
        }
    }

    private void buildPhi(Function function, ObjFunction objFunction) {
        for (Value block : function.getBasicBlocks()) {
            for (Instruction instruction : ((BasicBlock) block).getInstructionsArray()) {
                if (instruction instanceof Phi phi) {
                    ArrayList<Map.Entry<Value, BasicBlock>> entries = phi.getEntry();
                    ObjRegister tmpreg = phi.getValueType().isFloat() ? new ObjFloatVirReg() : new ObjVirRegister();
                    ObjBlock curBlock = n2mbMap.get(block.getName().substring(1));
                    ObjRegister nreg = v2mMap.containsKey(phi) ? (ObjRegister) v2mMap.get(phi) : putNewVGtoMap(phi, objFunction, curBlock);
                    curBlock.addInstructionToHead(new ObjMove(nreg, tmpreg, phi.getValueType().isFloat(), false));
                    for (Map.Entry<Value, BasicBlock> entry : entries) {
                        Value phiv = entry.getKey();
                        if (!(phiv instanceof ConstInt || phiv instanceof ConstFloat)) {
                            ObjRegister mphiv = v2mMap.containsKey(phiv) ? (ObjRegister) v2mMap.get(phiv) : putNewVGtoMap(phiv, objFunction, curBlock);
                            ObjBlock mphib = n2mbMap.get(entry.getValue().getName().substring(1));
                            mphib.addPhiMove(new ObjMove(tmpreg, mphiv, phi.getValueType().isFloat(), false));
                        } else if (phiv instanceof ConstInt) {
                            ObjBlock mphib = n2mbMap.get(entry.getValue().getName().substring(1));
                            mphib.addPhiMove(new ObjMove(tmpreg, new ObjImmediate(((ConstInt) phiv).getValue()), false, true));
                        } else {
                            ObjBlock mphib = n2mbMap.get(entry.getValue().getName().substring(1));
                            mphib.addPhiMove(new ObjMove(tmpreg, new ObjFloatImmediate(((ConstFloat) phiv).getValue()), true, true));
                        }

                    }
                } else break;
            }
        }
        for (ObjBlock block : objFunction.getBlocks()) {
            block.fixPhiMove();
        }

    }

    private ObjRegister createVirRegister(Value value) {
        ObjRegister r;
        if (value.getValueType().isFloat()) {
            r = new ObjFloatVirReg();
        } else {
            r = new ObjVirRegister();
        }
        v2mMap.put(value, r);
        return r;
    }

    private ObjRegister putNewVGtoMap(Value irValue, ObjFunction objFunction, ObjBlock objBlock) {
        ObjRegister vg;
        if (irValue.getValueType().isFloat())
            vg = new ObjFloatVirReg();
        else
            vg = new ObjVirRegister();
        if (irValue instanceof ConstInt || irValue instanceof ConstFloat) {
            return vg;
        } else if (irValue instanceof Argument arg) {
            buildArgument(arg, objFunction, objBlock, vg);
            v2mMap.put(arg, vg);
            return vg;
        } else {
            v2mMap.put(irValue, vg);
            return vg;
        }
    }

    /**
     * 处理ARMv7无法编码的立即数
     */
    private ObjOperand solveImm(int imm, ObjBlock objBlock) {
        if (ImmediateUtils.checkEncodeImm(imm)) {
            return new ObjImmediate(imm);
        } else {
            ObjRegister rd = new ObjVirRegister();
            objBlock.addInstruction(new ObjMove(rd, new ObjImmediate(imm), false, true));
            return rd;
        }
    }


    /**
     * 处理ARMv7超出范围的offset立即数
     */
    public static ObjOperand solveOffsetImm(ObjOperand offset, ObjBlock objBlock, boolean isFloat) {
        if (!(offset instanceof ObjImmediate)) return offset;
        int offsetInt = ((ObjImmediate) offset).getImmediate();
        if (ImmediateUtils.checkOffsetRange(offsetInt, isFloat)) {
            return offset;
        } else {
            ObjRegister rd = new ObjVirRegister();
            objBlock.addInstruction(new ObjMove(rd, offset, false, true));
            return rd;
        }
    }


}

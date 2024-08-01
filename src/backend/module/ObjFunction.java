package backend.module;

import backend.Utils.ImmediateUtils;
import backend.instruction.Binary;
import backend.instruction.ObjInstruction;
import backend.instruction.ObjLoad;
import backend.instruction.ObjMove;
import backend.operand.*;

import java.util.*;
import java.util.stream.Collectors;

public class ObjFunction {
    private String name;
    private ArrayList<ObjBlock> blocks = new ArrayList<>();
    private int allocSize;
    private Set<Integer> savedRegisters = new TreeSet<>();
    private HashSet<Integer> savedFloatRegisters = new HashSet<>();
    private HashMap<ObjInstruction, ObjBlock> argLoadInstructions = new HashMap<>();

    public ObjFunction(String name) {
        this.name = name.substring(1);
    }

    public void addArgInstructions(ObjInstruction argLoadInstruction, ObjBlock objBlock) {
        if (argLoadInstruction instanceof ObjLoad) {
            argLoadInstructions.put(argLoadInstruction, objBlock);
        }
    }

    public String getName() {
        return name;
    }

    public int getAllocSize() {
        return allocSize;
    }

    public void setAllocSize(int allocSize) {
        this.allocSize = allocSize;
    }

    public void addObjBlock(ObjBlock objBlock) {
        blocks.add(objBlock);
    }

    public void setBlocks(ArrayList<ObjBlock> blocks) {
        this.blocks = new ArrayList<>(blocks);
    }

    public ArrayList<ObjBlock> getBlocks() {
        return blocks;
    }

    public void addAllocSize(int size) {
        allocSize += size;
    }

    public void addToSavedRegisters(String name, boolean type) {
        if (type) {
            savedRegisters.add(ObjPhyRegister.nameToNum(name));
        } else {
            savedFloatRegisters.add(ObjFloatPhyReg.nameToNum(name));
        }
    }

    private int getSavedRegistersSize() {
        return savedRegisters.size() + savedFloatRegisters.size();
    }

    public void refreshArgOff() {
        int stack = getStackSize() + getSavedRegistersSize() * 4;
        Map<ObjInstruction, ObjBlock> argLoads = new HashMap<>(argLoadInstructions);
        for (Map.Entry<ObjInstruction, ObjBlock> entry : argLoads.entrySet()) {
            ObjInstruction argload = entry.getKey();
            if ((((ObjLoad) argload).getOff() instanceof ObjImmediate)) {
                int oldsa = ((ObjImmediate) ((ObjLoad) argload).getOff()).getImmediate();
                if (ImmediateUtils.checkOffsetRange(stack + oldsa, ((ObjLoad) argload).isVFP())) {
                    ((ObjLoad) argload).setOff(new ObjImmediate(stack + oldsa));
                } else if (!((ObjLoad) argload).isVFP()) {
                    ObjMove move = new ObjMove(ObjPhyRegister.getRegister(12), new ObjImmediate(stack + oldsa), false, true);
                    entry.getValue().addInstructionBefore(argload, move);
                    ((ObjLoad) argload).setOff(ObjPhyRegister.getRegister(12));
                } else {
                    Binary add;
                    if (!ImmediateUtils.checkEncodeImm(stack + oldsa)) {
                        ObjMove move = new ObjMove(ObjPhyRegister.getRegister(12), new ObjImmediate(stack + oldsa), false, true);
                        add = new Binary(ObjPhyRegister.getRegister(12), ObjPhyRegister.getRegister("sp"), ObjPhyRegister.getRegister(12), Binary.BinaryType.add);
                        entry.getValue().addInstructionBefore(argload, move);
                    } else {
                        add = new Binary(ObjPhyRegister.getRegister(12), ObjPhyRegister.getRegister("sp"), new ObjImmediate(stack + oldsa), Binary.BinaryType.add);
                    }
                    entry.getValue().addInstructionBefore(argload, add);
                    ((ObjLoad) argload).setOff(null);
                    ((ObjLoad) argload).setAdd(ObjPhyRegister.getRegister(12));
                }
            } else {
                ObjMove freshMove = ((ObjLoad) argload).getImmMove();
                int oldsa = ((ObjImmediate) freshMove.getRhs()).getImmediate();
                freshMove.setRhs(new ObjImmediate(stack + oldsa));
            }
        }
    }

    private int getStackSize() {
        int regSize = getSavedRegistersSize() * 4;
        if ("main".equals(name)) {
            regSize = 4;
        }
        return (regSize + allocSize + 4) / 8 * 8 - regSize;
    }

    public String refresh() {
        StringBuilder sb = new StringBuilder();
        int stack = getStackSize();
        if (stack != 0) {
            if (ImmediateUtils.checkEncodeImm(stack))
                sb.append("\tadd\tsp,\tsp,\t").append("#").append(stack).append("\n");
            else {
                sb.append(new ObjMove(ObjPhyRegister.getRegister(5), new ObjImmediate(stack), false, true));
                sb.append("\tadd\tsp,\tsp,\t").append("r5").append("\n");
            }
        }
        if (!name.equals("main")) {
            if (!savedFloatRegisters.isEmpty()) {
                sb.append("\tvpop\t{");
                int i = 0;
                for (int savedRegIndex : savedFloatRegisters) {
                    if (i != 0)
                        sb.append(",");
                    sb.append("s").append(savedRegIndex);
                    i++;
                    if (i == 16 && i < savedFloatRegisters.size()) {
                        sb.append("}\n").append("\tvpop\t{");
                        i = 0;
                    }
                }
                sb.append("}\n");
            }
            if (!savedRegisters.isEmpty()) {
                sb.append("\tpop\t{");
                int i = 0;
                for (int savedRegIndex : savedRegisters) {
                    if (i != 0)
                        sb.append(",");
                    if (14 == savedRegIndex)
                        sb.append("pc");
                    else
                        sb.append("r").append(savedRegIndex);
                    i++;
                }
                sb.append("}\n");
            }
        } else {
            sb.append("\tpop\t{pc}\n");
        }
        return sb.toString();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(".global\t").append(name).append("\n").append(name).append(":\n");
        int stack = getStackSize();
        if (!name.equals("main")) {
            int stackOffset = -4;
            if (!savedRegisters.isEmpty()) {
                sb.append("\tpush\t{");
                int i = 0;
                for (int savedRegIndex : savedRegisters) {
                    if (i != 0)
                        sb.append(",");
                    if (14 == savedRegIndex)
                        sb.append("lr");
                    else
                        sb.append("r").append(savedRegIndex);
                    i++;
                }
                sb.append("}\n");
            }
            if (!savedFloatRegisters.isEmpty()) {
                sb.append("\tvpush\t{");
                int i = 0;
                for (int savedRegIndex : savedFloatRegisters) {
                    if (i != 0)
                        sb.append(",");
                    sb.append("s").append(savedRegIndex);
                    i++;
                    if (i == 16 && i < savedFloatRegisters.size()) {
                        sb.append("}\n").append("\tvpush\t{");
                        i = 0;
                    }
                }
                sb.append("}\n");
            }
        } else {
            sb.append("\tpush\t{lr}\n");
        }
        if (stack != 0) {
            if (ImmediateUtils.checkEncodeImm(stack))
                sb.append("\tsub\tsp,\tsp,\t").append("#").append(stack).append("\n");
            else {
                sb.append(new ObjMove(ObjPhyRegister.getRegister(5), new ObjImmediate(stack), false, true));
                sb.append("\tsub\tsp,\tsp,\t").append("r5").append("\n");
            }
        }
        blocks.forEach(objBlock -> sb.append(objBlock.toString()));
        return sb.toString();
    }

    public HashSet<ObjRegister> getRegs(boolean type) {
        HashSet<ObjRegister> regs = new HashSet<>();
        blocks.forEach(b -> b.getInstructions().forEach(i -> regs.addAll(i.getRegs())));
        HashSet<ObjRegister> regss;
        if (type)
            regss = (HashSet<ObjRegister>) regs.stream().filter(r -> (r instanceof ObjVirRegister)).collect(Collectors.toSet());
        else
            regss = (HashSet<ObjRegister>) regs.stream().filter(r -> (r instanceof ObjFloatVirReg)).collect(Collectors.toSet());
        return regss;
    }
}

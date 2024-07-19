package backend.module;

import backend.instruction.ObjInstruction;
import backend.instruction.ObjLoad;
import backend.operand.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.stream.Collectors;

public class ObjFunction {
    private String name;
    private ArrayList<ObjBlock> blocks = new ArrayList<>();
    private int allocSize;
    private HashSet<String> savedRegisters = new HashSet<>();
    private HashSet<String> savedFloatRegisters = new HashSet<>();
    private ArrayList<ObjInstruction> argLoadInstructions = new ArrayList<>();

    public ObjFunction(String name) {
        this.name = name.substring(1);
    }

    public void addArgInstructions(ObjInstruction argLoadInstruction) {
        if (argLoadInstruction instanceof ObjLoad) {
            argLoadInstructions.add(argLoadInstruction);
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
            savedRegisters.add(name);
        } else {
            savedFloatRegisters.add(name);
        }
    }
    public void addToSavedFRegisters(String name) {
        savedFloatRegisters.add(name);
    }
    public int getSavedRegistersSize() { return savedRegisters.size() + savedFloatRegisters.size(); }
    public void refreshArgOff() {
        int stack = allocSize;
        for (ObjInstruction argload: argLoadInstructions){
            int oldsa = ((ObjImmediate)((ObjLoad)argload).getOff()).getImmediate();
            ((ObjLoad)argload).setOff(new ObjImmediate(stack + oldsa));
        }
    }
    public String refresh() {
        StringBuilder sb = new StringBuilder();
        int stack = allocSize;
        if (stack != 0) {
            sb.append("\tadd\tsp,\tsp,\t").append("#").append(stack).append("\n");
        }
        if (!name.equals("main")) {
            if (!savedRegisters.isEmpty()) {
                sb.append("\tpop\t{");
                int i = 0;
                for (String savedRegIndex : savedRegisters) {
                    if (i != 0)
                        sb.append(",");
                    sb.append(savedRegIndex);
                    i++;
                }
                sb.append("}\n");
            }
            if (!savedFloatRegisters.isEmpty()) {
                sb.append("\tvpop\t{");
                int i = 0;
                for (String savedRegIndex : savedFloatRegisters) {
                    if (i != 0)
                        sb.append(",");
                    sb.append(savedRegIndex);
                    i++;
                }
                sb.append("}\n");
            }
        }
        return sb.toString();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(".global\t").append(name).append("\n").append(name).append(":\n");
        int stack = allocSize;
        if (!name.equals("main")) {
            int stackOffset = -4;
            if (!savedFloatRegisters.isEmpty()) {
                sb.append("\tvpush\t{");
                int i = 0;
                for (String savedRegIndex : savedFloatRegisters) {
                    if (i != 0)
                        sb.append(",");
                    sb.append(savedRegIndex);
                    i++;
                }
                sb.append("}\n");
            }
            if (!savedRegisters.isEmpty()) {
                sb.append("\tpush\t{");
                int i = 0;
                for (String savedRegIndex : savedRegisters) {
                    if (i != 0)
                        sb.append(",");
                    sb.append(savedRegIndex);
                    i++;
                }
                sb.append("}\n");
            }
        }
        if (stack != 0) {
            sb.append("\tsub\tsp,\tsp,\t#").append(stack).append("\n");
        }
        blocks.forEach(objBlock -> sb.append(objBlock.toString()));
        return sb.toString();
    }

    public HashSet<ObjRegister> getRegs(boolean type) {
        HashSet<ObjRegister> regs = new HashSet<>();
        blocks.forEach(b -> b.getInstructions().forEach(i -> regs.addAll(i.getRegs())));
        HashSet<ObjRegister> regss;
        if (type)
            regss = (HashSet<ObjRegister>) regs.stream().filter(r->(r instanceof ObjVirRegister)).collect(Collectors.toSet());
        else
            regss = (HashSet<ObjRegister>) regs.stream().filter(r->(r instanceof ObjFloatVirReg)).collect(Collectors.toSet());
        return regss;
    }
}

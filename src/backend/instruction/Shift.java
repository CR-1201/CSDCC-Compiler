package backend.instruction;

import backend.operand.ObjRegister;

public class Shift extends ObjInstruction {
    private Binary.BinaryType shiftType;
    private int shiftBitCount = -1;
    private ObjRegister reg = null;
    private ObjInstruction instr; // 位移对象附属的指令

    public Shift(Binary.BinaryType type, int shiftBitCount) {
        this.shiftType = type;
        this.shiftBitCount = shiftBitCount;
    }

    public Shift() { // 空
        this.shiftType = null;
    }

    public Binary.BinaryType getShiftType() {
        return shiftType;
    }

    public ObjRegister getReg() {
        return reg;
    }

    public void setReg(ObjRegister reg) {
        this.reg = reg;
    }

    @Override
    public String toString() {
        if (shiftType == null || shiftBitCount == 0) {
            return "";
        }
        if (reg == null) {
            return ", " + shiftType + " #" + shiftBitCount;
        } else {
            return ", " + shiftType + " " + reg;
        }
    }

}

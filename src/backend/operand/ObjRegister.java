package backend.operand;

import backend.instruction.Shift;

import java.util.Objects;

public abstract class ObjRegister extends ObjOperand {
    private String name;

    protected boolean isAlloc;

    private Shift shift;


    public Shift getShift() {
        return shift;
    }


    public ObjRegister(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public abstract boolean isAllocated();

    public void setAlloc(boolean alloc) {
        isAlloc = alloc;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isAlloc() {
        return isAlloc;
    }


    public static ObjRegister getPhysicalRegisterByName(String name) {
        ObjRegister r = ObjPhyRegister.getRegister(name);
        return r != null ? r : ObjFloatPhyReg.getRegister(name);
    }


    @Override
    public String toString() {
        return getName();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ObjRegister that = (ObjRegister) o;
        return Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    public abstract boolean isFloat();
}

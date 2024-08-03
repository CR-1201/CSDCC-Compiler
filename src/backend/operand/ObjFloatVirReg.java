package backend.operand;

public class ObjFloatVirReg extends ObjRegister implements Vir{
    private static int fname = 0;
    public ObjFloatVirReg() {
        super("vf" + fname++);
    }

    @Override
    public boolean isAllocated() {
        return false;
    }
    @Override
    public boolean isFloat() {
        return true;
    }

}

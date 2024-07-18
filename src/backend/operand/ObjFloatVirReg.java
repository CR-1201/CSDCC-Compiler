package backend.operand;

public class ObjFloatVirReg extends ObjRegister {
    private static int fname = 0;
    public ObjFloatVirReg() {
        super("vf" + fname++);
    }

    @Override
    public boolean isAllocated() {
        return false;
    }

}

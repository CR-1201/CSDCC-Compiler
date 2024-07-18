package backend.operand;

public class ObjVirRegister extends ObjRegister{
    protected static int rname = 0;

    public ObjVirRegister() {
        super("v" + rname++);
    }

    @Override
    public boolean isAllocated() {
        return false;
    }
}

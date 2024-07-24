package backend.instruction;

public class LiteralPoolPlacement extends ObjInstruction {
    private static int lname = 0;
    private int name;
    public LiteralPoolPlacement() {
        this.name = lname++;
    }


    @Override
    public String toString() {
        return "\tb\tlpool" + name + "\n" + ".ltorg\n" + "lpool" + name + ":\n";
    }
}

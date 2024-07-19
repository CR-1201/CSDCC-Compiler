package backend.operand;

public class ObjLabel extends ObjOperand{
    private String name;

    private boolean isVariable = false;

    public ObjLabel(String name) {
        this.name = name;
    }

    public ObjLabel(String name, boolean isVariable) {
        this.name = name;
        this.isVariable = isVariable;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return this.name;
    }
}

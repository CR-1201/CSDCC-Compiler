package backend.operand;

public class ObjImmediate extends ObjOperand{
    private int immediate;

    public ObjImmediate(int immediate) {
        this.immediate = immediate;
    }

    public int getImmediate() {
        return immediate;
    }

    public void setImmediate(int immediate) {
        this.immediate = immediate;
    }

    @Override
    public String toString() {
        return "#" + immediate;
    }

    public String getName() {
        return toString();
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof ObjImmediate) {
            ObjImmediate other = (ObjImmediate) obj;
            return this.immediate == other.immediate;
        }
        return false;
    }
}

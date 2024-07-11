package ir.types;

public abstract class ValueType {
    /**
     * 返回的所占字节数
     * @return 所占字节数
     */
    public abstract int getSize();

    public boolean isI1() {
        return false;
    }

    public boolean isFloat() {
        return false;
    }
}

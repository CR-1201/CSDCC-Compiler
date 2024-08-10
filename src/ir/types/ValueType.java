package ir.types;

public abstract class ValueType {
    public abstract int getSize();

    public boolean isI1() {
        return false;
    }

    public boolean isFloat() {
        return false;
    }

    @Override
    public boolean equals(Object obj) {
        return obj.getClass() == getClass();
    }
}

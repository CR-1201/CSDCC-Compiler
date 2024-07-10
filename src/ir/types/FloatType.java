package ir.types;

public class FloatType extends DataType{
    @Override
    public String toString(){
        return "float";
    }

    @Override
    public boolean isFloat() {
        return true;
    }

    @Override
    public int getSize(){
        throw new AssertionError("get float's size!");
    }
}

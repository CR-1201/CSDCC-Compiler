package ir.types;

/**
 @author Conroy
 */
public class LabelType extends ValueType{
    @Override
    public String toString(){
        return "label";
    }
    @Override
    public int getSize(){
        throw new AssertionError("get label's size!");
    }
}

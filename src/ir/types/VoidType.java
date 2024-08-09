package ir.types;
/**
 @author Conroy
 */
public class VoidType extends DataType{
    @Override
    public String toString(){
        return "void";
    }

    @Override
    public int getSize(){
        throw new AssertionError("get void's size!");
    }
}

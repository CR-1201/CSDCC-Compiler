package ir.types;
/**
 @author Conroy
 */
public class PointerType extends DataType{
    /**
     * 该指针指向的标签
     */
    private final ValueType pointeeType;

    public PointerType(ValueType pointeeType){
        this.pointeeType = pointeeType;
    }
    public ValueType getPointeeType(){
        return pointeeType;
    }
    @Override
    public String toString(){
        return pointeeType + "*";
    }
    @Override
    public int getSize(){
        return 4;
    }
}

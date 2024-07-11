package ir.types;
/**
 @author Conroy
 函数与指令的返回值，包括 IntType, VoidType, PointerType
 */
// TODO FloatType
public abstract class DataType extends ValueType{
    @Override
    public abstract int getSize();
}

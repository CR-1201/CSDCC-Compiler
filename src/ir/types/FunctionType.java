package ir.types;

import java.util.ArrayList;
/**
 @author Conroy
 */
public class FunctionType extends ValueType{
    private final ArrayList<DataType> formalArgs;
    private final DataType returnType;

    public FunctionType(ArrayList<DataType> formalArgs, DataType returnType){
        this.formalArgs = formalArgs;
        this.returnType = returnType;
    }

    public DataType getReturnType(){
        return returnType;
    }

    public ArrayList<DataType> getFormalArgs(){
        return formalArgs;
    }

    @Override
    public int getSize(){
        throw new AssertionError("get function's size!");
    }
}

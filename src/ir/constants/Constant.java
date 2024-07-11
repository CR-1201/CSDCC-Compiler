package ir.constants;

import ir.User;
import ir.Value;
import ir.types.ArrayType;
import ir.types.FloatType;
import ir.types.IntType;
import ir.types.ValueType;

import java.util.ArrayList;
/**
 @author Conroy
 常量包括 ConstInt, ConstArray, ConstStr, ConstFloat
 常量没有名字 也没有 parent
 */
public class Constant extends User {
    public Constant(ValueType valueType){
        super(null, valueType, null);
    }

    public Constant(ValueType valueType, ArrayList<Value> values){
        super(null, valueType, null, values);
    }
    /**
     * @param constantType Constant种类
     * @return 元素全0 的 ConstInt ConstFloat 或 ConstArray
     */
    public static Constant getZeroConstant(ValueType constantType) {
        if (constantType instanceof IntType){
            return ConstInt.ZERO;
        } else if (constantType instanceof FloatType){
            return ConstFloat.ZERO;
        } else {
            return ConstArray.getZeroConstantArray((ArrayType) constantType);
        }
    }
}

package ir.types;

import java.util.ArrayList;

/**
 @author Conroy
 IntType | FloatType | ArrayType
 */
public class ArrayType extends ValueType{
    // IntType | FloatType | ArrayType
    private final ValueType elementType;
    // eg int a[2][3][4] => elementNum = 2
    private final int elementNum;
    private final int size;
    /**
     * @param elementType 数组元素类型,可以为数组或者基本类型
     * @param elementNum  数组元素数量
     */
    public ArrayType(ValueType elementType, int elementNum){
        this.elementType = elementType;
        this.elementNum = elementNum;
        this.size = elementType.getSize() * elementNum;
    }

    /**
     * @param dataType   数组的基本数据类型
     * @param dimensions 数组各个维度
     *                   eg: int a[1][2][3]
     *                   dataType为 IntType
     *                   dimensions数组为{1,2,3}
     *                   最终的结果为elementType = int [2][3]
     *                   elementNum = 1
     */
    public ArrayType(DataType dataType, ArrayList<Integer> dimensions){
        // 这个操作是为了防止这个构造器修改参数
        ArrayList<Integer> _dimensions = new ArrayList<>(dimensions);
        this.elementNum = _dimensions.get(0);
        if (_dimensions.size() == 1){
            this.elementType = dataType;
        }else{
            _dimensions.remove(0);
            this.elementType = new ArrayType(dataType, _dimensions);
        }
        this.size = elementType.getSize() * elementNum;
    }

    /**
     * @return eg a[2][3][4] 返回2
     */
    public int getElementNum(){
        return elementNum;
    }

    public ValueType getElementType(){
        return elementType;
    }

    @Override
    public int getSize(){
        return size;
    }

    @Override
    public String toString(){
        return "[" + elementNum + " x " + elementType + "]";
    }
}

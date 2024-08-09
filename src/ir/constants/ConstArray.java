package ir.constants;

import ir.Value;
import ir.types.ArrayType;
import ir.types.ValueType;

import java.util.ArrayList;

/**
 @author Conroy
 */
public class ConstArray extends Constant {
    private final ArrayList<Constant> elements = new ArrayList<>();

    public ConstArray(ArrayList<Constant> elements){
        super(new ArrayType(elements.get(0).getValueType(), elements.size()),new ArrayList<>(elements));
        this.elements.addAll(elements);
    }

    public static ConstArray getZeroConstantArray(ArrayType arrayType){
        ArrayList<Constant> elements = new ArrayList<>();
        int n = arrayType.getElementNum();
        ValueType type = arrayType.getElementType();
        for (int i = 0; i < n; i++){
            elements.add(Constant.getZeroConstant(type));
        }
        return new ConstArray(elements);
    }

    public Constant getElementByIndex(int index){
        return elements.get(index);
    }


    public ArrayList<Constant> getElementList() {
        ArrayList<Constant> elemList = new ArrayList<>();
        if (elements.get(0) instanceof ConstInt || elements.get(0) instanceof ConstFloat) {
            elemList.addAll(elements);
        } else {
            for (Constant element : elements) {
                elemList.addAll(((ConstArray) element).getElementList());
            }
        }
        return elemList;
    }

    public ArrayList<Constant> getElements(){
        ArrayList<Constant> elements = new ArrayList<>();
        for( Constant element : this.elements ){
            if( element instanceof ConstInt || element instanceof ConstFloat ){
                elements.add(element);
            } else {
                elements.addAll(((ConstArray)element).getElements());
            }
        }
        return elements;
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder("[");
        // ConstArray 里面没有保存信息,只能依赖于标签信息
        int n = ((ArrayType) getValueType()).getElementNum();
        for (int i = 0; i < n; i++){
            s.append(getOperator(i).getValueType()).append(" ").append(getOperator(i));
            if( i+1 < n )s.append(", ");
        }
        s.append("]");
        return s.toString();
    }
}


package ir.constants;

import ir.types.IntType;

import java.util.Objects;

public class ConstInt extends Constant{
    public static final ConstInt ZERO = new ConstInt(0);
    private final int value;
    private final int bits;
    
    public ConstInt(int bits, int value){
        // 名字就是值,而且没有从属关系
        super(new IntType(bits));
        this.bits = bits;
        this.value = value;
    }
    public ConstInt(int value){
        super(new IntType(32));
        this.bits = 32;
        this.value = value;
    }

    public int getValue(){
        return value;
    }

    @Override
    public boolean equals(Object o){
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ConstInt constInt = (ConstInt) o;
        return value == constInt.value && bits == constInt.bits;
    }

    @Override
    public int hashCode(){
        return Objects.hash(super.hashCode(), value, bits);
    }

    @Override
    public String getName(){
        return toString();
    }

    @Override
    public String toString(){
        return Integer.toString(value);
    }
}

package ir.constants;

import ir.types.FloatType;

public class ConstFloat extends Constant{
    public static final ConstFloat ZERO = new ConstFloat(0);
    private final float value;

    public ConstFloat(float value){
        super(new FloatType());
        this.value = value;
    }

    public float getValue() {
        return value;
    }

    @Override
    public String toString(){
        return String.valueOf(value);
    }
}

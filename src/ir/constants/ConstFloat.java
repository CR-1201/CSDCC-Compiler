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
        int bits = Float.floatToIntBits(value);
        // 将位模式转换为十六进制字符串
        return "0x"+Integer.toHexString(bits).toUpperCase();
    }

    @Override
    public String getName(){
        int bits = Float.floatToIntBits(value);
        // 将位模式转换为十六进制字符串
        return "0x"+Integer.toHexString(bits).toUpperCase();
    }
}

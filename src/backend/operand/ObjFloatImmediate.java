package backend.operand;

import java.text.DecimalFormat;

public class ObjFloatImmediate extends ObjOperand{
    private float immediate;

    public ObjFloatImmediate(float immediate) {
        this.immediate = immediate;
    }

    @Override
    public String toString() {
        String s = new DecimalFormat("0.0#############E0").
                format(immediate).replace("E", "e");
        return "#" + s;
    }
    public float getImmediate() {
        return immediate;
    }
}

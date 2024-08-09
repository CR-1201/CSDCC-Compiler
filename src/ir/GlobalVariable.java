package ir;

import ir.constants.Constant;
import ir.types.PointerType;

import java.util.ArrayList;

public class GlobalVariable extends User{
    private final boolean isConst;

    public GlobalVariable(String name, Constant initVal, boolean isConst){
        super("@_g_" + name, new PointerType(initVal.getValueType()), Module.getModule(),new ArrayList<>()
        {{
            add(initVal);
        }});
        this.isConst = isConst;
    }

    // 初始化 Constant
    public Constant getInitVal(){
        return (Constant) getOperator(0);
    }

    @Override
    public String toString(){
        return getName() + " = dso_local " + ((isConst) ? "constant " : "global ") + ((PointerType) getValueType()).getPointeeType() + " " + getOperator(0);
    }
}

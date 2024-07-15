package ir;

import ir.constants.Constant;
import ir.types.PointerType;

import java.util.ArrayList;

public class GlobalVariable extends User{
    private final boolean isConst;
    /**
     * 初始化
     * 此时全局变量既可以为常量,也可以不是常量
     * @param initVal 是全局变量使用的唯一 value
     */
    public GlobalVariable(String name, Constant initVal, boolean isConst){
        super("@" + name, new PointerType(initVal.getValueType()), Module.getModule(),new ArrayList<>()
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

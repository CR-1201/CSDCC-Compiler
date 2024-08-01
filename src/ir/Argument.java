package ir;

import ir.types.DataType;

import java.util.ArrayList;

/**
 * @author Conroy
 * 函数形参,不带具体数值,只是占位
 * 例如 define dso_local void f(i32 %0, [10 x i32]* %1)中 %0 与 %1 是两个形参
 */
public class Argument extends Value {
    private final int num;

    /**
     * @param num      参数编号，从0开始,上面的例子中 %0 的 num 是0, %1 的 num 是1
     * @param dataType 参数类型,只能为 DataType
     * @param parent   所在函数
     */
    public Argument(int num, DataType dataType, Function parent) {
        super("%a" + num, dataType, parent);
        this.num = num;
    }

    public int getNum() {
        return num;
    }

    public int getArgRank() {
        ArrayList<Argument> arguments = ((Function) getParent()).getArguments();
        int rank = 0;
        for (Argument argument : arguments) {
            if (argument.getNum() == this.num)
                break;
            if (argument.getValueType().isFloat() == this.getValueType().isFloat())
                rank++;
        }
        return rank;
    }

    public int getStackPos() {
        ArrayList<Argument> arguments = ((Function) getParent()).getArguments();
        int stackPos = -1;
        int icnt = 0, fcnt = 0;
        for (Argument argument : arguments) {
            if (argument.getValueType().isFloat()) {
                fcnt++;
                if (fcnt > 16) {
                    stackPos++;
                }
            } else {
                icnt++;
                if (icnt > 4) {
                    stackPos++;
                }
            }
            if (argument.getNum() == this.num)
                break;
        }
        return stackPos;

    }
}

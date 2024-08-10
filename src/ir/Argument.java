package ir;

import ir.types.DataType;

import java.util.ArrayList;

/**
 * @author Conroy
 */
public class Argument extends Value {
    private final int num;

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

package ir.constants;

import ir.types.ArrayType;
import ir.types.IntType;

import java.util.Objects;

import static utils.HandlePrintf.StringLength;

/**
 @author Conroy
 */
public class ConstStr extends Constant{
    private final String content;

    public ConstStr(String str){
        super(new ArrayType(new IntType(8), StringLength(str) + 1));
        this.content = str;
    }

    public String getContent(){
        return content.replace("\\0A", "\\n");
    }

    @Override
    public String toString() {
        return "c\"" + content + "\\00\"";
    }

    @Override
    public String getName(){
        return toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        ConstStr constStr = (ConstStr) o;
        return Objects.equals(content, constStr.content);
    }

    @Override
    public int hashCode(){
        return Objects.hash(super.hashCode(), content);
    }
}

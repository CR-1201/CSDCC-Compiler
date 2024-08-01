package pass.analysis;

import ir.Argument;
import ir.GlobalVariable;
import ir.Value;
import ir.instructions.memoryInstructions.Alloca;
import ir.instructions.memoryInstructions.GEP;
import ir.instructions.memoryInstructions.Load;
import ir.types.PointerType;

/**
 @author Conroy
 别名分析
 */
public class AliasAnalysis {
    //  获取某个数组value的根定义,要么是alloc指令(局部变量,局部数组或参数数组),要么是全局数组
    public static Value searchRoot( Value pointer ){
        Value root = pointer;
        while (root instanceof GEP || root instanceof Load) {
            if( root instanceof GEP gep ){
                root = gep.getBase();
            } else {
                root = ((Load)root).getAddr();
            }
        }
        return root;
    }

    public static boolean isGlobal( Value value ){
        return value instanceof GlobalVariable;
    }

    public static boolean isParameter( Value value ){
        if( value instanceof Alloca alloca ){
            return alloca.getAllocatedType() instanceof PointerType;
        }
        return false;
    }

    public static boolean isLocal( Value value ){
        return !isGlobal(value) && !isParameter(value) && !(value instanceof Argument);
    }

    public static boolean samePointer( Value value1, Value value2 ){
        if( value1.equals(value2) ){
            return true;
        }

        Value root1 = searchRoot(value1);
        Value root2 = searchRoot(value2);
        return root1.equals(root2);
    }
}

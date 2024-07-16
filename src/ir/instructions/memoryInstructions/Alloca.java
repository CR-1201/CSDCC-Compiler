package ir.instructions.memoryInstructions;

import ir.BasicBlock;
import ir.User;
import ir.constants.ConstArray;
import ir.types.PointerType;
import ir.types.ValueType;

import java.util.ArrayList;

/**
 @author Conroy
 <result> = alloca <ty>
 */
public class Alloca extends MemoryInstruction{
    /*
    * 参考 GlobalVariable 的设计,主要是为了局部常量数组准备的, 记录着局部常量数组的值
    * TODO 如果一个常量数组只被当成常量使用,也就是没有 const[var] 这种状况
    * 可以在后续的优化中将所有的 store 删掉
    */
    private final ConstArray initVal;

    /**
    * 新建一个 alloca 指令,其类型是分配空间类型的指针
    * @param nameNum 对于指令而言,其名称中带有数字,指令名称中的数字,eg: 名称为 %1 的指令的 nameNum 为 1
    * @param allocatedType 分配空间的类型,可能为 PointerType, IntType, FloatType, ArrayType
    * @param parent 基本块
    */
    public Alloca(int nameNum, ValueType allocatedType, BasicBlock parent){
        // 指针 没有初始化
        super("%v" + nameNum, new PointerType(allocatedType), parent,new ArrayList<>());
        this.initVal = null;
    }

    public Alloca(int nameNum, ValueType allocatedType, BasicBlock parent, ConstArray initVal){
        // 指针 有初始化
        super("%v" + nameNum, new PointerType(allocatedType), parent,new ArrayList<>());
        this.initVal = initVal;
    }

    public ValueType getAllocatedType(){
        PointerType pointer =  (PointerType) getValueType();
        return pointer.getPointeeType();
    }

    public ConstArray getInitVal(){
        return initVal;
    }

    /**
     * 是否可以被提升,本质是只要是没有使用 gep 的,都可以被提升
     * @return 可提升,则为 true
     */
    public boolean isPromotable(){
        if (getUsers().isEmpty()){ // 没有使用
            return true;
        }
        // 使用者中有 GEP ,则与数组有关,否则一般使用者都是 load,store 之类的
        for (User user : getUsers()){
            if (user instanceof GEP gep){
                // promotable alloca must be a single data
                if (gep.getOperator(0) == this){
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    public String toString(){
        return getName() + " = alloca " + getAllocatedType();
    }
}

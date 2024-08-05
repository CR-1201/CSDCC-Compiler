package ir;

import ir.types.ValueType;

import java.util.ArrayList;

/**
 @author Conroy
 value 的使用者
 例如 Instruction “%1 = Add i32 %2, 3”中指令 %1 既是 value 的派生类 Add,
 也是使用 指令%2 与 常数3 的 user
 Function,没有初始化的 GlobalVariable,ConstantData 不会使用 value,其他 user 会使用至少一个 value
 */
public abstract class User extends Value {
    // 记录当前 user 使用过的 value
    private final ArrayList<Value> operators = new ArrayList<>();

    // 初始化时 不加入当前 user 使用的 value
    public User(String name, ValueType valueType, Value parent){
        super(name, valueType, parent);
    }

    // 初始化时 加入当前 user 使用的 value
    public User(String name, ValueType valueType, Value parent, ArrayList<Value> operators){
        super(name, valueType, parent);
        this.operators.addAll(operators);
        initUsers();
    }

    public ArrayList<Value> getOperators(){
        return operators;
    }

    // 被使用的 value 设置 selfUser
    private void initUsers(){
        for (Value value : operators){
            if (value != null){
                value.addUser(this);
            }
        }
    }

    // 获取操作数, index 操作数位置
    public Value getOperator(int index) {
        return operators.get(index);
    }

    /**
     * 任何时候,user <-> used_value 关系都应该是双向的
     * 这里去掉原来 index 对应的 value,并 remove 该 value 相应的 user
     * @param index 索引
     * @param newValue 新 value
     */
    public void setOperator(int index, Value newValue) {
        Value oldValue = getOperator(index);
        if (oldValue != null)
            oldValue.removeUser(this);
        operators.set(index, newValue);
        newValue.addUser(this);
    }

    // return 使用的操作数数量
    public int getNumOfOps() {
        return operators.size();
    }

    public void addOperator(Value operator) {
        operators.add(operator);
    }

    public void removeOperator(Value operator) {
        operators.remove(operator);
    }

    public void removeOperator(int index) {
        operators.remove(index);
    }

    // 解除当前 user 的所有 user <-> used_value 双向关系
    public void removeAllOperators() {
        if (operators.isEmpty()) {
            return;
        }
        for (Value op : operators) {
            op.removeUser(this);
        }
        this.operators.clear();
    }

    public void replaceOperator(Value oldValue, Value newValue) {
        int index = operators.indexOf(oldValue);
        setOperator(index, newValue);
    }
}

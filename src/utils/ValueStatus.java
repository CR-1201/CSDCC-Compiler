package utils;

import ir.Value;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.instructions.Instruction;

public class ValueStatus {
    // 指令的状态
    public enum Status{
        BOT,
        CONST,
        Top,
    };
    private Status status;
    private Value value = null;

    public ValueStatus(Status status){
        this.status = status;
    }

    public ValueStatus(Status status, Value value){
        this.status = status;
        this.value = value;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Value getValue() {
        return value;
    }

    public void setValue(Value value) {
        this.value = value;
    }

    public boolean isBot(){
        return status == Status.BOT;
    }

    public boolean isConst(){
        return status == Status.CONST;
    }

    public boolean isTop(){
        return status == Status.Top;
    }

    public void xor(ValueStatus other){
        if( (status.equals(Status.Top) && !other.status.equals(Status.Top)) ||
                (status.equals(Status.CONST) && other.status.equals(Status.BOT))){
            status = other.status;
            value = other.value;
        } else if( status == other.status && status.equals(Status.CONST)){
            if( value instanceof ConstInt ){
                int x = ((ConstInt)value).getValue();
                int y = ((ConstInt)other.value).getValue();
                if( x != y ){
                    status = Status.BOT;
                    value = null;
                }
            } else if( value instanceof ConstFloat){
                float x = ((ConstFloat)value).getValue();
                float y = ((ConstFloat)other.value).getValue();
                // 存在浮点数误差?
                if( x != y ){
                    status = Status.BOT;
                    value = null;
                }
            }
        }
    }

    public boolean notEqual(ValueStatus other){
        System.out.println(this);
        System.out.println(other);
        if( status != other.status ){
            return true;
        }
        if( status != Status.CONST){
            return false;
        }
        if( value instanceof ConstInt ){
            int x = ((ConstInt)value).getValue();
            int y = ((ConstInt)other.value).getValue();
            return x != y;
        } else {
            float x = ((ConstFloat)value).getValue();
            float y = ((ConstFloat)other.value).getValue();
            return x != y;
        }
    }

    @Override
    public String toString(){
        return "value: " + value.toString() + ", status: " + status.toString();
    }
}

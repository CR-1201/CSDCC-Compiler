package pass.transform;

import ir.*;
import ir.Module;
import ir.constants.ConstFloat;
import ir.constants.ConstInt;
import ir.constants.Constant;
import ir.instructions.Instruction;
import ir.instructions.binaryInstructions.*;
import ir.instructions.otherInstructions.Conversion;
import ir.instructions.otherInstructions.Zext;
import pass.Pass;

import java.util.ArrayList;

/**
 @author Conroy
 常量优化
 参数包含常数的指令可以合并或替换 例如:
 (1) a + 0 = a
 (2) ( b + const1 ) - const2 = b + ( const1 - const2 )
 */
public class SimplifyInst implements Pass {
    private final Module module = Module.getModule();
    public void run() {
        for (Function function : module.getFunctionsArray()) {
            if (!function.getIsBuiltIn()) {
                ArrayList<BasicBlock> blocks = function.getBasicBlocksArray();
                for (BasicBlock basicBlock : blocks) {
                    ArrayList<Instruction> instructions = basicBlock.getInstructionsArray();
                    for (Instruction instruction : instructions) {
                        Value value = simplify(instruction);
                        if (!value.equals(instruction)) {
                            instruction.replaceAllUsesWith(value);
                            instruction.removeSelf();
                        }
                    }
                }
            }
        }
    }


    private static ConstInt constInt;
    private static ConstFloat constFloat;

    private Value simplify(Instruction inst){
        if( inst instanceof Add add){
            return simplifyAddInst(add);
        } else if( inst instanceof Sub sub){
            return simplifySubInst(sub);
        } else if( inst instanceof Mul mul){
            return simplifyMulInst(mul);
        } else if( inst instanceof Sdiv sdiv){
            return simplifyDivInst(sdiv);
        } else if( inst instanceof Srem srem){
            return simplifySremInst(srem);
        } else if( inst instanceof Icmp icmp){
            return simplifyIcmpInst(icmp);
        } else if( inst instanceof Zext zext){
            return simplifyZextInst(zext);
        } else if( inst instanceof Conversion conversion){
            return simplifyConversionInst(conversion);
        } else return inst;
    }

    public Value simplifyAddInst(Add inst){
        Value v1 = inst.getOperator(0), v2 = inst.getOperator(1);

        Value v3 = flodConstant(inst,v1,v2);
        boolean intFlag = !inst.getValueType().isFloat();
        if( !v3.equals(inst) ){
            return v3;
        }

        // swap 总是希望右边是常数
        if( v1 instanceof ConstInt || v1 instanceof ConstFloat ){
            inst.setOperator(0,v2);
            inst.setOperator(1,v1);
            v1 = inst.getOperator(0);
            v2 = inst.getOperator(1);
        }

//        if( inst.getName().equals("%v72") ){
//            System.out.println(inst);
//        }

        // x + 0 = x
        if( (v2 instanceof ConstInt && ((ConstInt)v2).getValue() == 0) ||
                (v2 instanceof ConstFloat && ((ConstFloat)v2).getValue() == 0) ){
            return v1;
        }

        // x + (const - x) = const || (const - x) + x = const
        if( checkAdd(v2,v1) || checkAdd(v1,v2) ){
            return intFlag ? constInt : constFloat;
        }

        // (a - b) + (b - a) = 0
        if( v1 instanceof Sub sub1 && v2 instanceof Sub sub2){

            Value v1_1 = sub1.getOperator(0), v1_2 = sub1.getOperator(1);
            Value v2_1 = sub2.getOperator(0), v2_2 = sub2.getOperator(1);
            if( v1_1.equals(v2_2) && v1_2.equals(v2_1) ){
                return intFlag ? ConstInt.ZERO : ConstFloat.ZERO;
            }
        }

        // x + (y - x) = y || (x - y) + y = x
        if( v1 instanceof Sub sub1 ){
            Value v1_1 = sub1.getOperator(0), v1_2 = sub1.getOperator(1);
            // (x - y) + y = x
            if( v1_2.equals(v2) ){
                return v1_1;
            }
        }

        if( v2 instanceof Sub sub2 ){

            Value v2_1 = sub2.getOperator(0), v2_2 = sub2.getOperator(1);
            // x + (y - x) = y
            if( v2_2.equals(v1) ){
                return v2_1;
            }
        }

        return inst;
    }

    private boolean checkAdd(Value v1, Value v2) {
        if (v2 instanceof Instruction && v1 instanceof Sub) {
            Value op1 = ((Sub) v1).getOperator(0);
            Value op2 = ((Sub) v1).getOperator(1);
            if (op1 instanceof ConstInt constInt1) {
                constInt = constInt1;
                return op2.equals(v2);
            } else if( op1 instanceof ConstFloat constFloat1){
                constFloat = constFloat1;
                return op2.equals(v2);
            }
        }
        return false;
    }

    public Value simplifySubInst(Sub inst){
        Value v1 = inst.getOperator(0), v2 = inst.getOperator(1);

        Value v3 = flodConstant(inst,v1,v2);
        boolean intFlag = !inst.getValueType().isFloat();

        if( !v3.equals(inst) ){
            return v3;
        }

        // x - 0 = x
        if( (v2 instanceof ConstInt && ((ConstInt)v2).getValue() == 0) ||
                (v2 instanceof ConstFloat && ((ConstFloat)v2).getValue() == 0) ){
            return v1;
        }

        // x - x = 0
        if( v1.equals(v2) ){
            return intFlag ? ConstInt.ZERO : ConstFloat.ZERO;
        }

        return inst;
    }

    public Value simplifyMulInst(Mul inst){
        Value v1 = inst.getOperator(0), v2 = inst.getOperator(1);

        Value v3 = flodConstant(inst,v1,v2);
        boolean intFlag = !inst.getValueType().isFloat();

        if( !v3.equals(inst) ){
            return v3;
        }
        // swap 总是希望右边是常数
        if( v1 instanceof ConstInt || v1 instanceof ConstFloat ){
            inst.setOperator(0,v2);
            inst.setOperator(1,v1);
            v1 = inst.getOperator(0);
            v2 = inst.getOperator(1);
        }

        // x * 0 = 0
        if( (v2 instanceof ConstInt && ((ConstInt)v2).getValue() == 0) ||
                (v2 instanceof ConstFloat && ((ConstFloat)v2).getValue() == 0) ){
            return intFlag ? ConstInt.ZERO : ConstFloat.ZERO;
        }

        // x * 1 = x
        if( (v2 instanceof ConstInt && ((ConstInt)v2).getValue() == 1) ||
                (v2 instanceof ConstFloat && ((ConstFloat)v2).getValue() == 1) ){
            return v1;
        }

        return inst;
    }

    public Value simplifyDivInst(Sdiv inst){
        Value v1 = inst.getOperator(0), v2 = inst.getOperator(1);

        Value v3 = flodConstant(inst,v1,v2);
        boolean intFlag = !inst.getValueType().isFloat();

        if( !v3.equals(inst) ){
            return v3;
        }

        // 0 / x = 0
        if( (v1 instanceof ConstInt && ((ConstInt)v1).getValue() == 0) ||
                (v1 instanceof ConstFloat && ((ConstFloat)v1).getValue() == 0) ){
            return intFlag ? ConstInt.ZERO : ConstFloat.ZERO;
        }

        // x / x = 1
        if( v1.equals(v2) ){
            return intFlag ? new ConstInt(1) : new ConstFloat(1);
        }

        // x / 1 = x
        if( (v2 instanceof ConstInt && ((ConstInt)v2).getValue() == 1) ||
                (v2 instanceof ConstFloat && ((ConstFloat)v2).getValue() == 1) ){
            return v1;
        }

        // a = a * b / b 注意 这里不考虑浮点数 存在误差
        if( intFlag ){
             if( v1 instanceof Mul mul){
                Value v1_1 = mul.getOperator(0), v1_2 = mul.getOperator(1);
                // a = a * b / b
                if( v1_2 instanceof ConstInt constInt1 && v2 instanceof ConstInt constInt2 &&
                        constInt1.getValue() == constInt2.getValue() ){
                    return v1_1;
                } else if( v1_2.equals(v2) ){
                    return v1_1;
                }

                 // b = a * b / a
                 if( v1_1 instanceof ConstInt constInt1 && v2 instanceof ConstInt constInt2 &&
                         constInt1.getValue() == constInt2.getValue() ){
                     return v1_2;
                 } else if( v1_1.equals(v2) ){
                     return v1_2;
                 }
             }
        }

        return inst;
    }

    public Value simplifySremInst(Srem inst){
        Value v1 = inst.getOperator(0), v2 = inst.getOperator(1);

        Value v3 = flodConstant(inst,v1,v2);
        boolean intFlag = !inst.getValueType().isFloat();

        if( !v3.equals(inst) ){
            return v3;
        }

        // 0 % x = 0
        if( (v1 instanceof ConstInt && ((ConstInt)v1).getValue() == 0) ||
                (v1 instanceof ConstFloat && ((ConstFloat)v1).getValue() == 0) ){
            return intFlag ? ConstInt.ZERO : ConstFloat.ZERO;
        }

        // x % x = 0
        if( v1.equals(v2) ){
            return intFlag ? new ConstInt(1) : new ConstFloat(1);
        }

        // x % 1 = 0
        if( (v2 instanceof ConstInt && ((ConstInt)v2).getValue() == 1) ||
                (v2 instanceof ConstFloat && ((ConstFloat)v2).getValue() == 1) ){
            return intFlag ? ConstInt.ZERO : ConstFloat.ZERO;
        }

        return inst;
    }

    public Value simplifyIcmpInst(Icmp inst){
        Value v1 = inst.getOperator(0), v2 = inst.getOperator(1);

        Value v3 = flodConstant(inst,v1,v2);
//        boolean intFlag = !inst.getValueType().isFloat();
        if( !v3.equals(inst) ){
            return v3;
        }

        // a == a
        if( inst.getCondition() == Icmp.Condition.EQ && v1.equals(v2) ){
            return new ConstInt(1,1);
        }

        return inst;
    }

    public Value simplifyZextInst(Zext inst){
        Value src = inst.getConversionValue();
        if( src instanceof ConstInt value){
            return new ConstInt(value.getValue());
        }
        return inst;
    }


    public Value simplifyConversionInst(Conversion inst){
        Value value = inst.getConversionValue();
        if( value instanceof ConstFloat temp_float){ // fptosi
            return new ConstInt((int)(temp_float.getValue()));
        } else if( value instanceof ConstInt temp_int){ // sitofp
            return new ConstFloat((float)(temp_int.getValue()));
        }
        return inst;
    }

    private Value flodConstant(Instruction inst, Value v1, Value v2){
        if( v1 instanceof ConstInt const1 && v2 instanceof ConstInt const2){
            int n1 = const1.getValue(), n2 = const2.getValue();
            int result, bit;
            if( inst instanceof Icmp ){
                bit = 1;
                Icmp.Condition cond = ((Icmp)inst).getCondition();
                switch(cond){
                    case EQ->{
                        result = ( n1 == n2 ) ? 1 : 0;
                    }
                    case NE->{
                        result = ( n1 != n2 ) ? 1 : 0;
                    }
                    case LT->{
                        result = ( n1 < n2 ) ? 1 : 0;
                    }
                    case LE->{
                        result = ( n1 <= n2 ) ? 1 : 0;
                    }
                    case GT->{
                        result = ( n1 > n2 ) ? 1 : 0;
                    }
                    case GE->{
                        result = ( n1 >= n2 ) ? 1 : 0;
                    }
                    default -> {
                        return inst;
                    }
                }
            } else {
                bit  = 32;
                if( inst instanceof Add ){
                    result = n1 + n2;
                } else if( inst instanceof Sub){
                    result = n1 - n2;
                } else if( inst instanceof Mul){
                    result = n1 * n2;
                } else if( inst instanceof Sdiv){
                    if( n2 != 0 ){
                        result = n1 / n2;
                    } else return inst;
                } else if( inst instanceof Srem){
                    if( n2 != 0 ){
                        result = n1 % n2;
                    } else return inst;
                } else return inst;
            }
            return new ConstInt(bit,result);
        } else if( v1 instanceof ConstFloat const1 && v2 instanceof ConstFloat const2){
            float n1 = const1.getValue(), n2 = const2.getValue();
            float result;
            if( inst instanceof Icmp ){
                Icmp.Condition cond = ((Icmp)inst).getCondition();
                switch(cond){
                    case EQ->{
                        result = ( n1 == n2 ) ? 1 : 0;
                    }
                    case NE->{
                        result = ( n1 != n2 ) ? 1 : 0;
                    }
                    case LT->{
                        result = ( n1 < n2 ) ? 1 : 0;
                    }
                    case LE->{
                        result = ( n1 <= n2 ) ? 1 : 0;
                    }
                    case GT->{
                        result = ( n1 > n2 ) ? 1 : 0;
                    }
                    case GE->{
                        result = ( n1 >= n2 ) ? 1 : 0;
                    }
                    default -> {
                        return inst;
                    }
                }
                return new ConstInt(1,(int)result);
            } else {
                if( inst instanceof Add ){
                    result = n1 + n2;
                } else if( inst instanceof Sub){
                    result = n1 - n2;
                } else if( inst instanceof Mul){
                    result = n1 * n2;
                } else if( inst instanceof Sdiv){
                    if( n2 != 0 ){
                        result = n1 / n2;
                    } else return inst;
                } else if( inst instanceof Srem){
                    if( n2 != 0 ){
                        result = n1 % n2;
                    } else return inst;
                } else return inst;
                return new ConstFloat(result);
            }
        } else return inst;
    }
}

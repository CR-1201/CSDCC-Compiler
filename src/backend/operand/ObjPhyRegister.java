package backend.operand;

import java.util.HashMap;
import java.util.HashSet;

/**
 * Obj寄存器 ARMv7架构下，是R0~R15可用寄存器，其中R13(SP) R14(LR) R15(PC)
 * R0-R3 用作传入函数参数，传出函数返回值。在子程序调用之间，可以将 r0-r3 用于任何用途。
 * 被调用函数在返回之前不必恢复 r0-r3。如果调用函数需要再次使用 r0-r3 的内容，则它必须保留这些内容。
 * R4-R11 被用来存放函数的局部变量。如果被调用函数使用了这些寄存器，它在返回之前必须恢复这些寄存器的值。
 * R12 是内部调用暂时寄存器 ip。它在过程链接胶合代码（例如，交互操作胶合代码）中用于此角色。
 * 在过程调用之间，可以将它用于任何用途。被调用函数在返回之前不必恢复 r12。
 *
 * */
public class ObjPhyRegister extends ObjRegister{

    private static HashMap<Integer, String> numToNameMap = new HashMap<>() {{
        put(0, "r0");
        put(1, "r1");
        put(2, "r2");
        put(3, "r3");
        put(4, "r4");
        put(5, "r5");
        put(6, "r6");
        put(7, "r7");
        put(8, "r8");
        put(9, "r9");
        put(10, "r10");
        put(11, "r11");
        put(12, "r12");
        put(13, "sp");
        put(14, "lr");
        put(15, "pc");
//        put(16, "cspr");
    }};
    private static HashMap<String, Integer> nameToNumMap = new HashMap<>() {{
        put("r0", 0);
        put("r1", 1);
        put("r2", 2);
        put("r3", 3);
        put("r4", 4);
        put("r5", 5);
        put("r6", 6);
        put("r7", 7);
        put("r8", 8);
        put("r9", 9);
        put("r10", 10);
        put("r11", 11);
        put("r12", 12);
        put("r13", 13);
        put("r14", 14);
        put("r15", 15);
        put("fp", 11);
        put("ip", 12);
        put("sp", 13);
        put("lr", 14);
        put("pc", 15);
    }};
    private static HashMap<Integer, ObjPhyRegister> registerMap = new HashMap<>(){{
        for (int i = 0; i < 16; i++) {
            ObjPhyRegister objPhyRegister = new ObjPhyRegister(i);
            put(i, objPhyRegister);
        }
    }};

    private int registerNum;

    private static HashSet<ObjRegister> canAllocRegister = new HashSet<>(){{
        for (int i = 0; i < 13; i++) {
                add(registerMap.get(i));
        }
    }};

    private static HashSet<ObjRegister> needeeSaveRegister = new HashSet<>(){{
        for (int i = 4; i < 13; i++) {
            add(registerMap.get(i));
        }
        add(registerMap.get(14));
    }};

    public static HashSet<ObjRegister> getCanAllocRegister() {
        return canAllocRegister;
    }
    public static HashSet<Integer> getCanIndexAllocRegister() {
        HashSet<Integer> ret = new HashSet<>();
        canAllocRegister.forEach(r->ret.add(nameToNumMap.get(r.getName())));
        return ret;
    }
    public static boolean needSave(int index){
        return needeeSaveRegister.contains(registerMap.get(index));
    }
    public static boolean needSave(String name){
        return needeeSaveRegister.contains(registerMap.get(nameToNumMap.get(name)));
    }
    public ObjPhyRegister(int num) {
        super(numToNameMap.get(num));
        if (num > 15 || num < 0)
            throw new RuntimeException("register outof index");
        registerNum = num;
        super.isAlloc = false;
    }
    public static int nameToNum(String name) {
        return nameToNumMap.get(name);
    }
    public static ObjPhyRegister getRegister(int num) {
        return registerMap.get(num);
    }
    public static ObjPhyRegister getRegister(String name) {
        return registerMap.get(nameToNumMap.get(name));
    }

    public void setRegisterNum(int registerNum) {
        this.registerNum = registerNum;
    }

    public int getRegisterNum() {
        return registerNum;
    }

    @Override
    public boolean isFloat() {
        return false;
    }

    @Override
    public boolean isAllocated() {
        return isAlloc;
    }
}

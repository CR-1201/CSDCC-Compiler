package backend.operand;

import java.util.HashMap;
import java.util.HashSet;


/**
 * 浮點數寄存器有S0~S31,基本都可以使用。
 */
public class ObjFloatPhyReg extends ObjRegister {
    private int num;
    private static HashMap<Integer, String> numToNameMap = new HashMap<>() {{
        for (int i = 0; i < 32; i++) {
            put(i, "s" + i);
        }
    }};

    private static HashMap<String, Integer> nameToNumMap = new HashMap<>() {{
        for (int i = 0; i < 32; i++) {
            put("s" + i, i);
        }
    }};

    public ObjFloatPhyReg(int num) {
        super(numToNameMap.get(num));
        this.num = num;
        super.isAlloc = false;
    }

    private static final HashMap<Integer, ObjFloatPhyReg> registerMap = new HashMap<>() {{
        for (int i = 0; i < 32; i++) {
            put(i, new ObjFloatPhyReg(i));
        }
    }};

    private static final HashSet<ObjRegister> canAllocRegister = new HashSet<>() {{
        for (int i = 0; i < 32; i++) {
            add(registerMap.get(i));
        }
    }};

    private static final HashSet<ObjRegister> needeeSaveRegister = new HashSet<>() {{
        for (int i = 4; i < 32; i++) {
            add(registerMap.get(i));
        }
    }};

    public static ObjFloatPhyReg getRegister(int num) {
        return registerMap.get(num);
    }

    public static ObjFloatPhyReg getRegister(String name) {
        return registerMap.get(nameToNumMap.get(name));
    }

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

    public static Integer nameToNum(String name) {
        return nameToNumMap.get(name);
    }

    @Override
    public boolean isFloat() {
        return true;
    }


    @Override
    public boolean isAllocated() {
        return super.isAlloc;
    }

}

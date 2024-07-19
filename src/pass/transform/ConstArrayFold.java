package pass.transform;

import ir.GlobalVariable;
import ir.Module;
import pass.Pass;

import java.util.HashSet;

/**
 @author Conroy
 常量数组折叠
 */
public class ConstArrayFold implements Pass {

    HashSet<GlobalVariable> globalVariableArrays = new HashSet<>();

    private final Module module = Module.getModule();
    @Override
    public void run() {
        initConstArray();
    }

    private void initConstArray() {

    }
}

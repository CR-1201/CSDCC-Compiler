package backend.module;


import java.util.ArrayList;

/**
 * ObjModule 是后端的仿照llvm的模块，分为三个主要部分：
 * 1.全局变量
 * 2.用户定义函数
 * 3.主函数
 *
 * */
public class ObjModule {

    private static ObjModule module = new ObjModule();

    public static ObjModule getModule() {
        return module;
    }

    private ArrayList<ObjGlobalVariable> globalVariables = new ArrayList<>();
    private ArrayList<ObjFunction> functions = new ArrayList<>();;
    private ObjFunction mainFunction;
    private ObjModule() {}
    public void addGlobalVariable(ObjGlobalVariable objgv) {
        globalVariables.add(objgv);
    }
    public void addFunction(ObjFunction pbjf) {
        // main函数判断
        if (pbjf.getName().equals("main")) {
            mainFunction = pbjf;
            System.out.println("main function found");
        }
        functions.add(pbjf);
    }

    public void setMainFunction(ObjFunction mainFunction) {
        this.mainFunction = mainFunction;
    }

    public ArrayList<ObjGlobalVariable> getGlobalVariables() {
        return globalVariables;
    }

    public ArrayList<ObjFunction> getFunctions() {
        return functions;
    }

    public ObjFunction getMainFunction() {
        return mainFunction;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        globalVariables.forEach(gv -> sb.append(gv.toString()));
        functions.forEach(f -> sb.append(f.toString()));
        return sb.toString();
    }
}

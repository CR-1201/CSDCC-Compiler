package backend.LivenessAnalyze;

import backend.operand.ObjRegister;

import java.util.HashSet;

public class LivenessInfo {
    private HashSet<ObjRegister> use = new HashSet<>();
    private HashSet<ObjRegister>def = new HashSet<>();
    private HashSet<ObjRegister>in = new HashSet<>();
    private HashSet<ObjRegister>out = new HashSet<>();

    public HashSet<ObjRegister> getUse() {
        return use;
    }

    public HashSet<ObjRegister> getDef() {
        return def;
    }

    public HashSet<ObjRegister> getIn() {
        return in;
    }

    public HashSet<ObjRegister> getOut() {
        return out;
    }

    public void setUse(HashSet<ObjRegister> use) {
        this.use = use;
    }

    public void setDef(HashSet<ObjRegister> def) {
        this.def = def;
    }

    public void setIn(HashSet<ObjRegister> in) {
        this.in = in;
    }

    public void setOut(HashSet<ObjRegister> out) {
        this.out = out;
    }
}

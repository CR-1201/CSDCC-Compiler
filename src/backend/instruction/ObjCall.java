package backend.instruction;

import backend.module.ObjFunction;

public class ObjCall extends ObjInstruction{   // bl

    private ObjFunction target;

    public ObjCall(ObjFunction target) {
        this.target = target;
    }

    public ObjFunction getTarget() {
        return target;
    }

    public void setTarget(ObjFunction target) {
        this.target = target;
    }

    @Override
    public String toString() {
        return "\tbl\t" + target.getName() + "\n";
    }
}

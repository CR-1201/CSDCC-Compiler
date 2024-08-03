package utils;

import ir.Value;

public class InductionVarInfo {
    public Value parent = null;
    public int additiveStep;
    public int multiplicativeStep;
    public boolean isPhi;
    public Value preheaderValue;

    public InductionVarInfo(Value parent, int additiveStep, int multiplicativeStep, boolean isPhi) {
        this.parent = parent;
        this.additiveStep = additiveStep;
        this.multiplicativeStep = multiplicativeStep;
        this.isPhi = isPhi;
    }

}

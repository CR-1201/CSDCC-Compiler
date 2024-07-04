package ast;

// TODO
//  CompUnit -> [ CompUnit ] ( Decl | FuncDef )
public class CompUnit extends Node{
    private CompUnit compUnit = null;
    private Decl decl = null;
    private MainFuncDef mainFuncDef = null;
    private FuncDef funcDef = null;
    public CompUnit(CompUnit compUnit, Decl decl) {
        this.compUnit = compUnit;
        this.decl = decl;
    }
    public CompUnit(CompUnit compUnit, FuncDef funcDef) {
        this.compUnit = compUnit;
        this.funcDef = funcDef;
    }
    public CompUnit( MainFuncDef mainFuncDef) {
        this.mainFuncDef = mainFuncDef;
    }
    @Override
    public void accept() {
        
    }
}


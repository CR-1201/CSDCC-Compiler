package ast;

import ir.Function;
import ir.Value;
import ir.types.*;

import java.io.PrintStream;
import java.util.ArrayList;

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
        childNode.add(decl);
        childNode.add(compUnit);
    }
    public CompUnit(CompUnit compUnit, FuncDef funcDef) {
        this.compUnit = compUnit;
        this.funcDef = funcDef;
        childNode.add(funcDef);
        childNode.add(compUnit);
    }
    public CompUnit( MainFuncDef mainFuncDef) {
        this.mainFuncDef = mainFuncDef;
    }

    @Override
    public void buildIrTree() {
        for (Node node : childNode) {
            node.buildIrTree();
        }
    }


    @Override
    public void accept() {
        
    }
}


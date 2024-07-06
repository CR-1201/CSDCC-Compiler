package ast;

//TODO
// MainFuncDef -> 'int' 'main' '(' ')' Block
public class MainFuncDef extends Node{
    private Block block = null;
    public MainFuncDef(Block block){
        this.block = block;
    }
    @Override
    public void accept() {

    }
}

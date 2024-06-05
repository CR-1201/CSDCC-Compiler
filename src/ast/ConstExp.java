package ast;

// TODO
//  ConstExp -> AddExp 注：使用的 Ident 必须是常量
public class ConstExp extends Node{
    private AddExp addExp = null;
    public ConstExp(AddExp addExp) {
        this.addExp = addExp;
    }

    public AddExp getAddExp() {
        return addExp;
    }

    @Override
    public void accept() {

    }
}

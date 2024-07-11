package ast;

import ir.constants.ConstInt;

// TODO
//  ConstExp -> AddExp 注：使用的 Ident 必须是常量
public class ConstExp extends Node{
    private AddExp addExp = null;
    public ConstExp(AddExp addExp) {
        this.addExp = addExp;
        childNode.add(addExp);
    }

    public AddExp getAddExp() {
        return addExp;
    }


    /*
     * 因为常量表达式必须给出初始值, 所以一定是可以计算的, 即使是数组, 也存储在了 ConstArray 里, 支持编译时求值
     * 所有的 ConstExp 一定是个 value 返回,而不是 valueInt 返回
     */
    @Override
    public void buildIrTree() {
        canCalValueDown = true;
        addExp.buildIrTree();
        canCalValueDown = false;
    }

    @Override
    public void accept() {

    }
}

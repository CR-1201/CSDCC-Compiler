package ast;

import token.Token;

import java.util.List;

// TODO
//  LVal -> Ident {'[' Exp ']'}
public class LVal extends Node{
    private Token identToken = null;
    private List<Exp> exps = null;

    public LVal(Token identToken, List<Exp> exps) {
        this.identToken = identToken;
        this.exps = exps;
        childNode.addAll(exps);
    }


    /**
     * 左值是直接返回指针的,而不是返回指针指向的内容
     * 应当由更高层次的语法树（PrimaryExpNode）决定是否加载
     * 左值指向的内容有 3 种类型:
     * 整型: 十分显然
     * 指针: 至于为什么会有这么个东西,可以这样举例,比如说 f(int a[])
     * 当我们对 a 进行 buildIr 的时候, a 的类型是 i32*
     * 然后我们为了 SSA（主要是为了整型形参,指针形参属于受害者） ,所以在函数一开始做了一个 alloca-store 操作
     * 那么在之后,我们看 a,就变成了一个 (i32*)*,也就是 lVal 指向一个指针的情况
     * 对于这种情况,我们首先用 load 将其指针去掉一层,目前 a 的类型就和 C 语言一致了,所以对它的一维访存,就是 GEP一个 index
     * 对于二维访存,就是 GEP 两个 index
     * 数组: 后面有写
     */
    @Override
    public void buildIrTree() {
        // TODO
    }

    @Override
    public void accept() {

    }
}

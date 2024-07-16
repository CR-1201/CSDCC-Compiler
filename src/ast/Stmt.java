package ast;

import ir.BasicBlock;
import ir.Value;
import ir.constants.ConstInt;
import ir.types.DataType;
import ir.types.FloatType;
import ir.types.IntType;
import ir.types.PointerType;
import token.Token;

// TODO
//  Stmt ->
//  LVal '=' Exp ';'
//  | [Exp] ';' | Block
//  | 'if' '( Cond ')' Stmt [ 'else' Stmt ]
//  | 'while' '(' Cond ')' Stmt
//  | 'break' ';' | 'continue' ';'
//  | 'return' [Exp] ';'
public class Stmt extends Node{

    private Exp exp;
    private LVal lVal;
    private final int type;
    private Block block;
    private Cond cond;
    private Stmt stmt1;
    private Stmt stmt2;
    private Stmt stmt;
    private Token conBreakTk;

    private DataType returnType;

    public Stmt(int type, LVal lVal, Exp exp) {
       // LVal '=' Exp ';'
       this.type = type;
       this.lVal = lVal;
       this.exp = exp;
    }

    public Stmt(int type, Exp exp) {
        // [Exp] ';' || 'return' [Exp] ';'
        this.type = type;
        this.exp = exp;
    }

    public Stmt(int type, Block block) {
        // Block
        this.type = type;
        this.block = block;
    }

    public Stmt(int type, Cond cond, Stmt stmt1, Stmt stmt2) {
        // 'if' '( Cond ')' Stmt [ 'else' Stmt ]
        this.type = type;
        this.cond = cond;
        this.stmt1 = stmt1;
        this.stmt2 = stmt2;
    }

    public Stmt(int type, Cond cond, Stmt stmt) {
        // 'while' '(' Cond ')' Stmt
        this.type = type;
        this.cond = cond;
        this.stmt = stmt;
    }

    public Stmt(int type, Token conBreakTk) {
        this.type = type;
        this.conBreakTk = conBreakTk;
    }

    public void setReturnType(DataType returnType) {
        this.returnType = returnType;
    }

    @Override
    public void buildIrTree() {
        switch (type) {
            case 1 -> {
                // LVal '=' Exp ';'
                lVal.buildIrTree();
                Value target = valueUp;
                exp.buildIrTree();
                Value source = valueUp;
                if( ((PointerType) target.getValueType()).getPointeeType() instanceof IntType && source.getValueType() instanceof FloatType){
                    source = builder.buildConversion(curBlock,"fptosi",new IntType(32), source);
                } else if( ((PointerType) target.getValueType()).getPointeeType() instanceof FloatType && source.getValueType() instanceof IntType){
                    source = builder.buildConversion(curBlock,"sitofp",new FloatType(), source);
                }
                // 最后是以一个 store 结尾的,说明将其存入内存,就算完成了赋值
                builder.buildStore(curBlock, source, target);
            }
            case 2 -> {
                // [Exp] ';'
                if (exp != null) {
                    exp.buildIrTree();
                }
            }
            case 3 ->{
                // Block
                block.setReturnType(returnType);
                block.buildIrTree();
            }
            case 4 -> {
                // 'if' '(' Cond ')' Stmt [ 'else' Stmt ]
                /*
                 * 从这里开始的一系列东西,会出现 setBlock 的操作,只是因为为了满足短路求值
                 * 所以在条件表达式中,会被拆成多个 BasicBlock,设置他们的目的是为了保证一开始和最后的块的正确性
                 */
                BasicBlock trueBlock = builder.buildBasicBlock(curFunc);
                BasicBlock falseBlock = builder.buildBasicBlock(curFunc);
                BasicBlock nextBlock = (stmt2 == null) ? falseBlock : builder.buildBasicBlock(curFunc);

                cond.setTrueBlock(trueBlock);
                cond.setFalseBlock(falseBlock);


                cond.buildIrTree();
                curBlock = trueBlock;
                // 遍历 if 块
                stmt1.setReturnType(returnType);
                stmt1.buildIrTree();

                // 直接跳转到 nextBlock,这是不言而喻的,因为 trueBlock 执行完就是 nextBlock
                builder.buildBr(curBlock, nextBlock);
                // 对应有 else 的情况
                if (stmt2 != null) {
                    curBlock = falseBlock;
                    stmt2.setReturnType(returnType);
                    stmt2.buildIrTree();
                    builder.buildBr(curBlock, nextBlock);
                }
                // 最终到了 nextBlock
                curBlock = nextBlock;
            }
            case 5 -> {
                // 'while' '(' Cond ')' Stmt
                // while 涉及 3 个块
                // cond 块负责条件判断和跳转，如果是 true 则进入 bodyBlock，如果是 false 就进入 nextBlock，结束 while 语句
                BasicBlock condBlock = builder.buildBasicBlock(curFunc);
                // body 块是循环的主体
                BasicBlock bodyBlock = builder.buildBasicBlock(curFunc);
                // nextBlock 意味着循环的结束
                BasicBlock nextBlock = builder.buildBasicBlock(curFunc);

                loopCondBlockDown.push(condBlock);
                loopNextBlockDown.push(nextBlock);

                // 先由 curBlock 进入 condBlock
                builder.buildBr(curBlock, condBlock);
                // build condBlock, Br 在 LAndExp 短路求值的时候加了
                cond.setTrueBlock(bodyBlock);
                cond.setFalseBlock(nextBlock);
                curBlock = condBlock;
                cond.buildIrTree();

                curBlock = bodyBlock;
                stmt.setReturnType(returnType);
                stmt.buildIrTree();
                builder.buildBr(curBlock, condBlock);

                loopNextBlockDown.pop();
                loopCondBlockDown.pop();

                curBlock = nextBlock;
            }
            case 6 -> {
                // 'break' ';' | 'continue' ';'
                /*
                 * 首先先做一个跳转,来跳到 loop 的下一块
                 * 然后,新作了一个块,用于使 break 后面的指令依附其上,然后失效
                 */
                if( this.conBreakTk.getType() == Token.TokenType.BREAKTK ){
                    builder.buildBr(curBlock, loopNextBlockDown.peek());
                }else {
                    builder.buildBr(curBlock, loopCondBlockDown.peek());
                }
                curBlock = new BasicBlock();
            }
            case 7 -> {
                // 'return' [Exp] ';'
                if (exp != null) {
                    // 这里也有一个和 Break 类似的操作,不知道合不合理
                    exp.buildIrTree();
                    Value sum;
                    if( returnType instanceof FloatType && valueUp.getValueType() instanceof IntType){
                        sum = builder.buildConversion(curBlock,"sitofp",new FloatType(), valueUp);
                        builder.buildRet(curBlock, sum);
                    } else if( returnType instanceof IntType && valueUp.getValueType() instanceof FloatType ){
                        sum = builder.buildConversion(curBlock,"fptosi",new IntType(32), valueUp);
                        builder.buildRet(curBlock, sum);
                    } else builder.buildRet(curBlock, valueUp);

                    // 为了在main函数最后的return前插入输出语句
                    lastBasicBlockUp = curBlock;
                } else {
                    builder.buildRet(curBlock);
                }
                curBlock = builder.buildBasicBlock(curFunc);
            }
        }

    }

    @Override
    public void accept() {

    }
}

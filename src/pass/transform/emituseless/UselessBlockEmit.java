package pass.transform.emituseless;


import pass.Pass;

/**
 * 对于下面的块：
 * b1:
 *    br b2;
 * 块中只有一条语句，并且是一条简单语句的块，我们需要删掉
 */
public class UselessBlockEmit implements Pass {
    public void run() {

    }
}

package pass.transform.gcmgvn;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import pass.Pass;
import utils.IOFunc;

public class GCMGVN implements Pass {
    public void run() {
        GVN gvn = new GVN();
        GCM gcm = new GCM();
        gvn.run();
        gcm.run();
    }
}

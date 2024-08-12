package pass.transform.gcmgvn;
import pass.Pass;


public class GCMGVN implements Pass {
    public void run() {
        GVN gvn = new GVN();
        GCM gcm = new GCM();
        gvn.run();
        gcm.run();
    }
}

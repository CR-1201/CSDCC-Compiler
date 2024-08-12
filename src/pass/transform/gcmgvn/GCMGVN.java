package pass.transform.gcmgvn;
import pass.Pass;


public class GCMGVN implements Pass {
    public void run() {
        GVN gvn = new GVN();
        newGCM gcm = new newGCM();
        gvn.run();
        gcm.run();
    }
}

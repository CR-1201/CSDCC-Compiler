package backend.pass;


import java.util.ArrayList;

public class ObjPassManager {
    private ArrayList<ObjPass> passes = new ArrayList<>();

    public void run() {
        passes.add(new PeepHole());
        for (ObjPass pass : passes) {
            pass.run();
        }
    }

}

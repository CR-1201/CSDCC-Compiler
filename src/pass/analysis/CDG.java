package pass.analysis;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import pass.Pass;

import java.util.HashSet;

public class CDG implements Pass {

    private final Module irModule = Module.getModule();

    @Override
    public void run() {
        new RDOM().run();

        for (Function function : irModule.getFunctionsArray()) {
            for (BasicBlock block : function.getBasicBlocksArray()) {
                HashSet<BasicBlock> rdf = block.getRDominanceFrontier();

                for (BasicBlock blockF : rdf) {
                    blockF.addControl(block);
                }
            }
        }
    }

}

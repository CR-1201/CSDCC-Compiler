package pass.transform.gcmgvn;

import ir.BasicBlock;
import ir.Function;
import ir.Module;
import pass.Pass;
import utils.IOFunc;

public class GCMGVN implements Pass {
    public void run() {
//        for (Function function : Module.getModule().getFunctionsArray()) {
//            if (!function.getIsBuiltIn()) {
//                for (BasicBlock block : function.getBasicBlocksArray()) {
//                    System.out.println("===========================" + "BLOCK_NAME: " + block.getName() + "============================");
//                    // ===================================
//                    System.out.println("BLOCk_PREC: ");
//                    for (BasicBlock prec : block.getPrecursors()) {
//                        System.out.println("\t" + prec.getName());
//                    }
//                    if (block.getPrecursors().isEmpty()) {
//                        System.out.println("\t" + "NULL");
//                    }
//                    // ===================================
//                    System.out.println("BLOCk_SUCC: ");
//                    for (BasicBlock prec : block.getSuccessors()) {
//                        System.out.println("\t" + prec.getName());
//                    }
//                    if (block.getSuccessors().isEmpty()) {
//                        System.out.println("\t" + "NULL");
//                    }
//                    // ===================================
//                    System.out.println("BLOCK_DOMER: ");
//                    for (BasicBlock prec : block.getDomers()) {
//                        System.out.println("\t" + prec.getName());
//                    }
//                    if (block.getDomers().isEmpty()) {
//                        System.out.println("\t" + "NULL");
//                    }
//                    // ===================================
//                    System.out.println("BLOCK_IDOMER: ");
//                    System.out.println("\t" + (block.getIDomer() == null ? "NULL" : block.getIDomer().getName()));
//                    // ===================================
//                    System.out.println("BLOCK_IDOMS: ");
//                    for (BasicBlock prec : block.getIdoms()) {
//                        System.out.println("\t" + prec.getName());
//                    }
//                    if (block.getIdoms().isEmpty()) {
//                        System.out.println("\t" + "NULL");
//                    }
//                }
//            }
//        }
        GVN gvn = new GVN();
        GCM gcm = new GCM();
        gvn.run();
        gcm.run();
    }
}

package ast;

import java.util.List;

// TODO
//  Block -> '{' { BlockItem } '}'
public class Block extends Node{
    private List<BlockItem> blockItems = null;
    public Block(List<BlockItem> blockItems) {
        this.blockItems = blockItems;
        childNode.addAll(blockItems);
    }

    public List<BlockItem> getBlockItems() {
        return blockItems;
    }

    @Override
    public void buildIrTree(){
        irSymbolTable.pushBlockLayer();
        for (BlockItem blockItem : blockItems) {
            blockItem.buildIrTree();
        }
        irSymbolTable.popBlockLayer();
    }

    @Override
    public void accept() {
        
    }
}

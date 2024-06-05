package ast;

import java.util.List;

// TODO
//  Block -> '{' { BlockItem } '}'
public class Block extends Node{
    private List<BlockItem> blockItems = null;
    public Block(List<BlockItem> blockItems) {
        this.blockItems = blockItems;
    }

    public List<BlockItem> getBlockItems() {
        return blockItems;
    }

    @Override
    public void accept() {
        
    }
}

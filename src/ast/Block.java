package ast;

import ir.types.DataType;

import java.util.List;

// TODO
//  Block -> '{' { BlockItem } '}'
public class Block extends Node{
    private List<BlockItem> blockItems = null;

    private DataType returnType;

    public Block(List<BlockItem> blockItems) {
        this.blockItems = blockItems;
        childNode.addAll(blockItems);
    }

    public List<BlockItem> getBlockItems() {
        return blockItems;
    }

    public void setReturnType(DataType returnType) {
        this.returnType = returnType;
    }

    @Override
    public void buildIrTree(){
        irSymbolTable.pushBlockLayer();
        for (BlockItem blockItem : blockItems) {
            blockItem.setReturnType(returnType);
            blockItem.buildIrTree();
        }
        irSymbolTable.popBlockLayer();
    }

    @Override
    public void accept() {
        
    }
}

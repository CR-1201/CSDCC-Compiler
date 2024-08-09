package ir;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class IrSymbolTable {
    private final ArrayList<HashMap<String, Value>> symbolTable;
    // 区分 function 和 block 的行为
    private boolean preEnter;
    // 初始化符号表,并且加入 global layer
    public IrSymbolTable(){
        this.symbolTable = new ArrayList<>();
        this.symbolTable.add(new HashMap<>());
        this.preEnter = false;
    }
    
    public HashMap<String, Value> getTopLayer() {
        return symbolTable.get(symbolTable.size() - 1);
    }

    public Value searchValue(String ident){
        for (int i = symbolTable.size() - 1; i >= 0; i--){
            if (symbolTable.get(i).containsKey(ident)){
                return symbolTable.get(i).get(ident);
            }
        }
        return null;
    }

    public void addValue(String ident, Value value){
        getTopLayer().put(ident, value);
    }

    public void pushFuncLayer(){
        symbolTable.add(new HashMap<>());
        this.preEnter = true;
    }

    public void popFuncLayer(){
        symbolTable.remove(symbolTable.size() - 1);
        this.preEnter = false;
    }

    public void pushBlockLayer(){
        if(preEnter){
            preEnter = false;
        }else{
            symbolTable.add(new HashMap<>());
        }
    }

    public void popBlockLayer(){
        if (symbolTable.size() > 2){ // 第 1 层是 global,第 2 层是 function,之后才是 block 层
            symbolTable.remove(symbolTable.size() - 1);
        }
    }

    public boolean isGlobalLayer(){
        return symbolTable.size() == 1;
    }

    @Override
    public String toString(){
        StringBuilder s = new StringBuilder();
        for (int i = symbolTable.size() - 1; i >= 0; i--) {
            HashMap<String, Value> layer = symbolTable.get(i);
            for (Map.Entry<String, Value> entry : layer.entrySet()) {
                s.append(entry.getKey()).append(": ").append(entry.getValue()).append(", ");
            }
            s.append("\n======================================================\n");
        }
        return s.toString();
    }
}

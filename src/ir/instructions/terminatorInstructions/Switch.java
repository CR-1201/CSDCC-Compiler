package ir.instructions.terminatorInstructions;

import ir.BasicBlock;
import ir.Value;
import ir.types.VoidType;

import java.util.ArrayList;
import java.util.HashMap;

public class Switch extends TerInstruction{
    private int caseNum = 0;
    private Value switchCase;
    private BasicBlock defaultBlock;
    private HashMap<Value, BasicBlock> case2block;
    public Switch(BasicBlock parent, Value switchCase, BasicBlock defaultBlock, HashMap<Value, BasicBlock> case2block){
        super(new VoidType(), parent, new ArrayList<>(){{
            add(switchCase); add(defaultBlock);
        }});
        this.switchCase = switchCase;
        this.defaultBlock = defaultBlock;
        this.case2block = case2block;
        parent.addSuccessor(defaultBlock);
        defaultBlock.addPrecursor(parent);
        for (HashMap.Entry<Value, BasicBlock> entry : case2block.entrySet()){
            getOperators().add(2 + caseNum, entry.getKey());
            caseNum++;
            getOperators().add(entry.getValue());
            entry.getKey().addUser(this);
            entry.getValue().addUser(this);
            parent.addSuccessor(entry.getValue());
            entry.getValue().addPrecursor(parent);
        }
    }

    public HashMap<Value, BasicBlock> getCase2block() {
        return case2block;
    }

    public String toString(){
        StringBuilder s = new StringBuilder("switch ").append(switchCase.getValueType()).append(" ").append(switchCase.getName());
        s.append(", label ").append(defaultBlock.getName()).append(" [\n");
        for (int i = 0; i < caseNum; i++){
            s.append("\t\t").append(getOperator(i + 2).getValueType()).append(" ").append(getOperator(i + 2).getName()).append(", ")
                    .append("label ").append(getOperator(i + 2 + caseNum).getName()).append(" ");
            if (i + 1 < caseNum) {
                s.append("\n");
            }
        }
        s.append("\n\t]");
        return s.toString();
    }
}

package backend.module;

import java.util.ArrayList;

public class ObjGlobalVariable {
    public enum Type {
        INT, FLOAT, STR
    }

    private String name;
    private boolean hasInit;    // 有初始化用.space 没有用.word
    private Type type;
    private String content; //str
    private ArrayList elements;
    private int size;

    public ObjGlobalVariable(String name, int size) {
        this.name = name.substring(1);
        this.size = size;
    }

    public ObjGlobalVariable(String name, String content) { // str
        this.name = name.substring(1);
        this.hasInit = true;
        this.type = Type.STR;
        this.size = content.length() + 1;   // '\0'
        this.content = content;
    }

    public ObjGlobalVariable(String name, ArrayList elements, Type type) {
        this.name = name.substring(1);
        this.elements = elements;
        this.size = 4 * elements.size();
        this.hasInit = true;
        this.type = type;
    }

    public ObjGlobalVariable(String name, ArrayList elements, Type type, boolean hasInit) {
        this.name = name.substring(1);
        this.elements = elements;
        this.size = 4 * elements.size();
        this.hasInit = hasInit;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public boolean hasInit() {
        return hasInit;
    }

    public Type getType() {
        return type;
    }

    public String getContent() {
        return content;
    }

    public int getSize() {
        return size;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(".global\t").append(name).append("\n");
        if (!hasInit) {
            sb.append("\n.section .bss\n");
        } else {
            sb.append("\n.section .data\n");
        }
        sb.append(".align 2\n");
        sb.append(name).append(":\n");
        if (hasInit) {
            int i = 0;
            int zero = 0;
            if (type == Type.INT) {
                for (i = 0; i < elements.size(); i++) {
                    if ((int) elements.get(i) != 0) {
                        if (zero != 0) {
                            sb.append("\t.zero\t").append(zero * 4).append("\n");
                            zero = 0;
                        }
                        sb.append("\t.word\t").append(elements.get(i)).append("\n");
                    } else {
                        zero++;
                    }
                }
            } else {
                for (i = 0; i < elements.size(); i++) {
                    if ((float) elements.get(i) != 0.0) {
                        if (zero != 0) {
                            sb.append("\t.zero\t").append(zero * 4).append("\n");
                            zero = 0;
                        }
                        int bits = Float.floatToIntBits((float) elements.get(i));
                        String hex = "0x" + Integer.toHexString(bits).toUpperCase();
                        sb.append("\t.word\t").append(hex).append("\n");
                    } else {
                        zero++;
                    }
                }
            }
            if (zero != 0)
                sb.append("\t.zero\t").append(zero * 4);
        } else {
            sb.append("\t.zero\t").append(size);
        }
        sb.append("\n");
        return sb.toString();
    }
}

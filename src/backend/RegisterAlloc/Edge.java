package backend.RegisterAlloc;


import backend.operand.ObjOperand;
import backend.operand.ObjOperand;

import java.util.Objects;

public class Edge {
    ObjOperand u;
    ObjOperand v;

    public Edge(ObjOperand u, ObjOperand v) {
        this.u = u;
        this.v = v;
    }

    public Edge reverse() {
        return new Edge(v, u);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Edge edge = (Edge) o;
        return Objects.equals(u, edge.u) && Objects.equals(v, edge.v);
    }

    @Override
    public int hashCode() {
        return Objects.hash(u, v);
    }

    public ObjOperand getU() {
        return u;
    }

    public void setU(ObjOperand u) {
        this.u = u;
    }

    public ObjOperand getV() {
        return v;
    }

    public void setV(ObjOperand v) {
        this.v = v;
    }
}

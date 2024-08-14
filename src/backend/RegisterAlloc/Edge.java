package backend.RegisterAlloc;


import backend.operand.ObjRegister;

import java.util.Objects;

public class Edge {
    ObjRegister u;
    ObjRegister v;

    public Edge(ObjRegister u, ObjRegister v) {
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

    public ObjRegister getU() {
        return u;
    }

    public void setU(ObjRegister u) {
        this.u = u;
    }

    public ObjRegister getV() {
        return v;
    }

    public void setV(ObjRegister v) {
        this.v = v;
    }
}

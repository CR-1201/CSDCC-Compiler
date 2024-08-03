package utils;

import java.util.Objects;

/**
 * 一个简单的 Triple 类
 * @param <A> 第一个参数的类型
 * @param <B> 第二个参数的类型
 * @param <C> 第二个参数的类型
 */
public class Triple<A,B,C> {
    Object first;
    Object second;
    Object third;

    public Triple(Object first, Object second, Object third) {
        this.first = first;
        this.second = second;
        this.third = third;
    }

    public Object getThird() {
        return third;
    }

    public Object getFirst() {
        return first;
    }

    public Object getSecond() {
        return second;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Triple<?, ?, ?> triple = (Triple<?, ?, ?>) o;
        return Objects.equals(first, triple.first) && Objects.equals(second, triple.second)&& Objects.equals(third, triple.third);
    }

    @Override
    public String toString() {
        return "(" + first + ", " + second + ", " + third + ")";
    }

    @Override
    public int hashCode() {
        return Objects.hash(first, second, third);
    }
}

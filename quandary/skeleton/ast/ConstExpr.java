https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
package ast;

public class ConstExpr extends Expr {

    final Object value;

    public ConstExpr(long value, Location loc) {
        super(loc);
        this.value = value;
    }

    @Override
    public String toString() {
        return value.toString();
    }

    @Override
    Object eval() {
        return value;
    }
}

package behavioral.visitor;

public interface Engine extends Visitable {
    int getSize();
    boolean isTurbo();
}

package behavioral.visitor;

public interface Visitable {
    void acceptEngineVisitor(EngineVisitor visitor);
}

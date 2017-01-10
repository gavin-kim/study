package dependencyinjection;

import java.io.PrintStream;

public interface Quest {
    void start();
    void setStream(PrintStream stream);
}

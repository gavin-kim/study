package dependencyinjection;

import java.io.PrintStream;

public class SlayDragonQuest implements Quest {

    private PrintStream stream;

    public SlayDragonQuest () {}

    public SlayDragonQuest(PrintStream stream) {
        System.out.println("SlayDragonQuest: constructor");
        this.stream = stream;
    }

    @Override
    public void start() {
        stream.println("Slay the dragon!!");
    }

    @Override
    public void setStream(PrintStream stream) {
        System.out.println("SlayDragonQuest: setStream()");
        this.stream = stream;
    }
}

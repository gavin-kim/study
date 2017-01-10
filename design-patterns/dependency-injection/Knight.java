package dependencyinjection;

public class Knight {

    private Quest quest;

    public Knight () {}

    public Knight(Quest quest) {
        System.out.println("Knight: constructor");
        this.quest = quest;
    }

    public void doQuest() {
        quest.start();
    }

    public void setQuest(Quest quest) {
        System.out.println("Knight: setQuest()");
        this.quest = quest;
    }

}

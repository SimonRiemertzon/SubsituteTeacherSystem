package se.yrgo.schedule;

public class School {
    private String name;
    private String adress;

    public School(String name, String adress) {
        super();
        this.name = name;
        this.adress = adress;
    }

    public String adress() {
        return adress;
    }

    public String name() {
        return name;
    }

    @Override
    public String toString() {
        return new StringBuilder().append(String.format(" ( %s Adress: %s", name, adress)).toString();

        }
}

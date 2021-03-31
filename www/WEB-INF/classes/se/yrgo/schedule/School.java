package se.yrgo.schedule;

public class School {
    private String name;
    private String address;

    public School(String name, String address) {
        super();
        this.name = name;
        this.address = address;
    }

    public String adress() {
        return address;
    }

    public String name() {
        return name;
    }

    @Override
    public String toString() {
        return new StringBuilder().append(String.format(" ( %s Adress: %s", name, address)).toString();

        }
}

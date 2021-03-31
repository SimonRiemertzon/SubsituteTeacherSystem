package se.yrgo.schedule;

public class Substitute {
    
    private String name;

    public Substitute(String name) {
        super();
        this.name = name;
    }

    public String name() {
        return name;
    }

    @Override
    public String toString() {
        return new StringBuilder().append(name).append("teacher").append(")").toString();

    }

}
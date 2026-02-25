package com.classare.model;

public class Subject {
    private int id;
    private String name;
    private Level level;

    public Subject() {}


    public Subject(int id, String name, Level level) {
        this.id = id;
        this.name = name;
        this.level = level;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Level getLevel() { return level; }
    public void setLevel(Level level) { this.level = level; }
}

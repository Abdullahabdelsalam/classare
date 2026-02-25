package com.classare.model;

public class Level {
    private int id;
    private String name;
    private Stage stage; // Relationship: Many-to-One

    public Level() {}

    public Level(int levelId, String levelName) {
        this.id = levelId;
        this.name = levelName;
    }

    public Level(int levelId, String levelName, Stage stage) {
        this.id = levelId;
        this.name = levelName;
        this.stage = stage;
    }
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Stage getStage() { return stage; }
    public void setStage(Stage stage) { this.stage = stage; }
}

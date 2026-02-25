package com.classare.model;

import java.time.LocalDateTime;

public class Center {
    private int id;
    private String name;
    private String address;
    private String phone;
    private String location;

    public Center() {}

    public Center(int id, String name, String address, String phone, String location) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.location = location;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
}
package com.classare.model;

import java.util.List;

public class User {
    private long id;
    private String email;
    private String passwordHash;
    private boolean active;
    private Person person;
    private List<Role> roles;

//    public boolean hasRole(String roleName) {
//        return roles.stream()
//                .anyMatch(r -> r.getName().equalsIgnoreCase(roleName));
//    }
public boolean hasRole(String roleName) {
    if (roles == null) return false;

    for (Role role : roles) {
        if (role.getName().equalsIgnoreCase(roleName.trim())) {
            return true;
        }
    }
    return false;
}

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
}

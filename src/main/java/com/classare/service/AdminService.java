package com.classare.service;

import com.classare.dao.UserDAO;

public class AdminService {
    public boolean createAdmin(String firstName, String lastName,
                               String email, String password) {

        if (email == null || password == null) return false;

        return UserDAO.createAdmin(firstName, lastName, email, password);
    }
}

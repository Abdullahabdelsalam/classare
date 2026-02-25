package com.classare.dao;

import com.classare.model.Person;
import com.classare.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PersonDAO {
    public static Person findById(long id) {

        String sql = "SELECT * FROM person WHERE id = ?";
        Person p = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Person();
                p.setId(rs.getLong("id"));
                p.setFirstName(rs.getString("first_name"));
                p.setLastName(rs.getString("last_name"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }

}

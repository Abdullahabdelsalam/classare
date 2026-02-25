package com.classare.dao;

import com.classare.util.DBConnection;
import com.classare.model.Faculty;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FacultyDAO {

    public static List<Faculty> getAllFaculties() {
        List<Faculty> list = new ArrayList<>();
        String sql = "SELECT * FROM faculties ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Faculty f = new Faculty();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                list.add(f);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean createFaculty(String name) {
        String sql = "INSERT INTO faculties (name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateFaculty(int id, String name) {
        String sql = "UPDATE faculties SET name = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteFaculty(int id) {
        String sql = "DELETE FROM faculties WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Faculty getFacultyById(int id) {
        String sql = "SELECT * FROM faculties WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Faculty f = new Faculty();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                return f;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
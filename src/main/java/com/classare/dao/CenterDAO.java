package com.classare.dao;
import com.classare.model.Center;
import com.classare.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CenterDAO {

    public static List<Center> getAllCenters() {
        List<Center> list = new ArrayList<>();
        String sql = "SELECT * FROM centers ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Center c = new Center(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("location")
                );
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean createCenter(String name, String address, String phone, String location) {
        String sql = "INSERT INTO centers (name, address, phone, location) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, phone);
            ps.setString(4, location);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateCenter(int id, String name, String address, String phone, String location) {
        String sql = "UPDATE centers SET name=?, address=?, phone=?, location=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, phone);
            ps.setString(4, location);
            ps.setInt(5, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteCenter(int id) {
        String sql = "DELETE FROM centers WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

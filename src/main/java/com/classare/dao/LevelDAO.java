package com.classare.dao;

import com.classare.model.Stage;
import com.classare.util.DBConnection;
import com.classare.model.Level;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LevelDAO {

    public static List<Level> getAllLevels() {
        List<Level> levels = new ArrayList<>();
        String sql = "SELECT l.id AS level_id, l.name AS level_name, " +
                "s.id AS stage_id, s.name AS stage_name " +
                "FROM levels l " +
                "JOIN stages s ON l.stage_id = s.id " +
                "ORDER BY s.name, l.name";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Stage stage = new Stage(rs.getInt("stage_id"), rs.getString("stage_name"));
                Level level = new Level(rs.getInt("level_id"), rs.getString("level_name"), stage);
                levels.add(level);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return levels;
    }

    public static boolean createLevel(String name) {
        String sql = "INSERT INTO levels (name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateLevel(int id, String name) {
        String sql = "UPDATE levels SET name = ? WHERE id = ?";
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

    public static boolean deleteLevel(int id) {
        String sql = "DELETE FROM levels WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Level getLevelById(int id) {
        String sql = "SELECT * FROM levels WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Level l = new Level();
                l.setId(rs.getInt("id"));
                l.setName(rs.getString("name"));
                return l;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
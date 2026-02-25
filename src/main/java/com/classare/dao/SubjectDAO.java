package com.classare.dao;

import com.classare.util.DBConnection;
import com.classare.model.Subject;
import com.classare.model.Level;
import com.classare.model.Stage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {

    // جلب كل المواد مع المستوى والمرحلة
    public static List<Subject> getAllSubjects() {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT s.id AS subject_id, s.name AS subject_name, " +
                "l.id AS level_id, l.name AS level_name, " +
                "st.id AS stage_id, st.name AS stage_name " +
                "FROM subjects s " +
                "JOIN levels l ON s.level_id = l.id " +
                "JOIN stages st ON l.stage_id = st.id " +
                "ORDER BY st.name, l.name, s.name";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Stage stage = new Stage(rs.getInt("stage_id"), rs.getString("stage_name"));
                Level level = new Level(rs.getInt("level_id"), rs.getString("level_name"), stage);
                Subject subject = new Subject(rs.getInt("subject_id"), rs.getString("subject_name"), level);
                list.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // إنشاء مادة جديدة مرتبطة بمستوى
    public static boolean createSubject(String name, int levelId) {
        String sql = "INSERT INTO subjects (name, level_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, levelId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // تحديث مادة موجودة
    public static boolean updateSubject(int id, String name, int levelId) {
        String sql = "UPDATE subjects SET name = ?, level_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, levelId);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // حذف مادة
    public static boolean deleteSubject(int id) {
        String sql = "DELETE FROM subjects WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // جلب مادة واحدة حسب id
    public static Subject getSubjectById(int id) {
        String sql = "SELECT s.id AS subject_id, s.name AS subject_name, " +
                "l.id AS level_id, l.name AS level_name, " +
                "st.id AS stage_id, st.name AS stage_name " +
                "FROM subjects s " +
                "JOIN levels l ON s.level_id = l.id " +
                "JOIN stages st ON l.stage_id = st.id " +
                "WHERE s.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Stage stage = new Stage(rs.getInt("stage_id"), rs.getString("stage_name"));
                Level level = new Level(rs.getInt("level_id"), rs.getString("level_name"), stage);
                return new Subject(rs.getInt("subject_id"), rs.getString("subject_name"), level);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
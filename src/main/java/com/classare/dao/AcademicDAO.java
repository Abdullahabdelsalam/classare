package com.classare.dao;

import com.classare.model.Faculty;
import com.classare.model.Level;
import com.classare.model.Stage;
import com.classare.model.Subject;
import com.classare.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AcademicDAO {
    // جلب كل المراحل (Stages)
    public List<Stage> getAllStages() {
        List<Stage> stages = new ArrayList<>();
        String sql = "SELECT * FROM stages";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                stages.add(new Stage(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return stages;
    }

    // إضافة مستوى جديد مرتبط بمرحلة
    public boolean addLevel(int stageId, String levelName) {
        String sql = "INSERT INTO levels (stage_id, name) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, stageId);
            stmt.setString(2, levelName);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }


    public List<Subject> getSubjectsByStage(int stageId) {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT s.id, s.name, l.id AS level_id, l.name AS level_name " +
                "FROM subjects s " +
                "JOIN levels l ON s.level_id = l.id " +
                "WHERE l.stage_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, stageId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Level level = new Level(rs.getInt("level_id"), rs.getString("level_name"));
                subjects.add(new Subject(rs.getInt("id"), rs.getString("name"), level));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subjects;
    }
    // أضف هذه الدوال داخل كلاس AcademicDAO
    public boolean addStage(String name) {
        String sql = "INSERT INTO stages (name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }
    public List<Faculty> getAllFaculties() {
        List<Faculty> list = new ArrayList<>();
        String sql = "SELECT id, name, stage_id FROM faculties";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Faculty f = new Faculty();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setStageId(rs.getInt("stage_id"));
                list.add(f);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean addSubject(int stageId, String name) {
        String sql = "INSERT INTO subjects (stage_id, name) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, stageId);
            stmt.setString(2, name);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }
    public List<Level> getAllLevels() {
        List<Level> levels = new ArrayList<>();
        // سنستخدم Join لجلب اسم المرحلة مع المستوى لعرضها بشكل احترافي
        String sql = "SELECT l.id, l.name as level_name, s.id as stage_id, s.name as stage_name " +
                "FROM levels l " +
                "JOIN stages s ON l.stage_id = s.id " +
                "ORDER BY s.id, l.id";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Level level = new Level();
                level.setId(rs.getInt("id"));
                level.setName(rs.getString("level_name"));

                // تعبئة كائن المرحلة ووضعه داخل كائن المستوى
                Stage stage = new Stage();
                stage.setId(rs.getInt("stage_id"));
                stage.setName(rs.getString("stage_name"));

                level.setStage(stage);

                levels.add(level);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return levels;
    }

    public List<Subject> getAllSubjects() {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT sub.id AS subject_id, sub.name AS subject_name, " +
                "l.id AS level_id, l.name AS level_name, " +
                "st.id AS stage_id, st.name AS stage_name " +
                "FROM subjects sub " +
                "JOIN levels l ON sub.level_id = l.id " +
                "JOIN stages st ON l.stage_id = st.id " +
                "ORDER BY st.name, l.name, sub.name";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Stage stage = new Stage(rs.getInt("stage_id"), rs.getString("stage_name"));

                Level level = new Level(rs.getInt("level_id"), rs.getString("level_name"), stage);

                Subject subject = new Subject(rs.getInt("subject_id"), rs.getString("subject_name"), level);

                subjects.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subjects;
    }
}

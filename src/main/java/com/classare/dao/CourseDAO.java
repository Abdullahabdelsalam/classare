package com.classare.dao;

import com.classare.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CourseDAO {
    public boolean addCourse(long subjectId, long teacherId, int levelId, long centerId, double price, String type, int maxStudents) {
        String sql = "INSERT INTO courses (subject_id, teacher_id, level_id, center_id, price, type, max_students) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, subjectId);
            stmt.setLong(2, teacherId);
            stmt.setInt(3, levelId);
            stmt.setLong(4, centerId);
            stmt.setDouble(5, price);
            stmt.setString(6, type);
            stmt.setInt(7, maxStudents);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

package com.classare.dao;

import com.classare.model.Course;
import com.classare.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public List<Course> getInstructorCourses(long instructorId) {

        List<Course> list = new ArrayList<>();

        String sql = "SELECT c.*, s.name as subject_name " +
                "FROM courses c " +
                "LEFT JOIN subjects s ON c.subject_id = s.id " +
                "WHERE c.instructor_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, instructorId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();

                c.setId(rs.getLong("id"));
                c.setName(rs.getString("subject_name"));
                c.setPrice(rs.getDouble("price"));
                c.setType(rs.getString("type"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Map<String, Object>> getInstructorCoursesSimple(long instructorId) {

        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT c.id, s.name as subject " +
                "FROM courses c " +
                "LEFT JOIN subjects s ON c.subject_id = s.id " +
                "WHERE c.instructor_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, instructorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("name", rs.getString("subject"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}

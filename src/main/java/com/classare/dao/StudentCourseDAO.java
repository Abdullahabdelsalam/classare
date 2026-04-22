package com.classare.dao;


import com.classare.model.Course;
import com.classare.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentCourseDAO {

    public boolean isEnrolled(long studentId, long courseId) {

        String sql = "SELECT 1 FROM student_courses WHERE student_id=? AND course_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);
            ps.setLong(2, courseId);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean enroll(long studentId, long courseId) {

        String sql = "INSERT INTO student_courses (student_id, course_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);
            ps.setLong(2, courseId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    public List<Long> getStudentCourses(long studentId) {

        List<Long> courses = new ArrayList<>();

        String sql = "SELECT course_id FROM student_courses WHERE student_id=? AND status='ACTIVE'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                courses.add(rs.getLong("course_id"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }


    public List<Long> getCourseStudents(long courseId) {

        List<Long> students = new ArrayList<>();

        String sql = "SELECT student_id FROM student_courses WHERE course_id=? AND status='ACTIVE'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, courseId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                students.add(rs.getLong("student_id"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return students;
    }


    public boolean dropCourse(long studentId, long courseId) {

        String sql = "UPDATE student_courses SET status='DROPPED' WHERE student_id=? AND course_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);
            ps.setLong(2, courseId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    public int countStudentsInCourse(long courseId) {

        String sql = "SELECT COUNT(*) FROM student_courses WHERE course_id=? AND status='ACTIVE'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, courseId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Course> getMyCourses(long studentId) {

        List<Course> courses = new ArrayList<>();

        String sql = "SELECT c.* FROM courses c " +
                "JOIN student_courses sc ON c.id = sc.course_id " +
                "WHERE sc.student_id=? AND sc.status='ACTIVE'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();

                c.setId(rs.getLong("id"));
                c.setName(rs.getString("name"));
                c.setPrice(rs.getDouble("price"));
                c.setType(rs.getString("type"));

                courses.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return courses;
    }
}

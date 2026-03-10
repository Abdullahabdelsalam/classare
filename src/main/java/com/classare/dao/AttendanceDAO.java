package com.classare.dao;

import com.classare.model.Person;
import com.classare.model.Student;
import com.classare.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {
//    public List<Student> getStudentsByCourseLevel(long courseId) {
//        List<Student> students = new ArrayList<>();
//        String sql = "SELECT s.id as student_id, p.first_name, p.last_name " +
//                "FROM students s " +
//                "JOIN person p ON s.person_id = p.id " +
//                "JOIN courses c ON s.level_id = c.level_id " +
//                "WHERE c.id = ?";
//
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setLong(1, courseId);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Student student = new Student();
//                student.setId(rs.getLong("student_id"));
//                Person p = new Person();
//                p.setFirstName(rs.getString("first_name"));
//                p.setLastName(rs.getString("last_name"));
//                student.setPerson(p);
//                students.add(student);
//            }
//        } catch (SQLException e) { e.printStackTrace(); }
//        return students;
//    }

    public boolean markAttendance(long sessionId, long studentId, String status) {
        String sql = "INSERT INTO attendance (session_id, student_id, status) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, sessionId);
            stmt.setLong(2, studentId);
            stmt.setString(3, status);
            stmt.setString(4, status);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}

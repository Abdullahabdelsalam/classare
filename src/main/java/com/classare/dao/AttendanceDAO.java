package com.classare.dao;

import com.classare.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AttendanceDAO {


    // check if already attended
    public boolean isAlreadyMarked(long sessionId, long studentId) {

        String sql = "SELECT 1 FROM attendance WHERE session_id=? AND student_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, sessionId);
            ps.setLong(2, studentId);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // mark attendance
    public boolean markAttendance(long sessionId, long studentId) {

        String sql = "INSERT INTO attendance (session_id, student_id, status) VALUES (?, ?, 'PRESENT')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, sessionId);
            ps.setLong(2, studentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

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

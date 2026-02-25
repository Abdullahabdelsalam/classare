package com.classare.dao;

import com.classare.model.Session;
import com.classare.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SessionDAO {
    public boolean addSession(Session session) {
        String sql = "INSERT INTO sessions (course_id, center_id, session_date, start_time, end_time, status) VALUES (?, ?, ?, ?, ?, 'SCHEDULED')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, session.getCourseId());
            stmt.setLong(2, session.getCenterId());
            stmt.setDate(3, Date.valueOf(session.getSessionDate()));
            stmt.setTime(4, Time.valueOf(session.getStartTime()));
            stmt.setTime(5, Time.valueOf(session.getEndTime()));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Session> getSessionsByCourse(long courseId) {
        List<Session> sessions = new ArrayList<>();
        String sql = "SELECT * FROM sessions WHERE course_id = ? ORDER BY session_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, courseId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Session s = new Session();
                s.setId(rs.getLong("id"));
                s.setSessionDate(rs.getDate("session_date").toLocalDate());
                s.setStartTime(rs.getTime("start_time").toLocalTime());
                s.setStatus(rs.getString("status"));
                sessions.add(s);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return sessions;
    }
}

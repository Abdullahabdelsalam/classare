package com.classare.dao;

import com.classare.util.DBConnection;

import java.sql.*;
import java.util.*;

public class LectureDAO {

    public List<Map<String, Object>> getInstructorLectures(long instructorId) {

        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT l.id, l.lecture_date, l.start_time, l.end_time, c.id as course_id, s.name as subject " +
                "FROM lectures l " +
                "JOIN courses c ON l.course_id = c.id " +
                "LEFT JOIN subjects s ON c.subject_id = s.id " +
                "WHERE l.instructor_id=? " +
                "ORDER BY l.lecture_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, instructorId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("date", rs.getDate("lecture_date"));
                row.put("start", rs.getTime("start_time"));
                row.put("end", rs.getTime("end_time"));
                row.put("course_id", rs.getLong("course_id"));
                row.put("subject", rs.getString("subject"));

                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}

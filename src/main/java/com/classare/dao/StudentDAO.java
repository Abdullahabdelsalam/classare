package com.classare.dao;
import com.classare.model.*;
import com.classare.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StudentDAO {

    public List<Student> findAll(String keyword) {
        List<Student> list = new ArrayList<>();

        String sql = """
    SELECT s.id,
           s.person_id,
           s.level_id,
           s.faculty_id,
           s.active,
           CONCAT(p.first_name, ' ', p.last_name) AS full_name
    FROM students s
    JOIN person p ON s.person_id = p.id
    WHERE (? IS NULL
           OR s.id = ?
           OR p.first_name LIKE ?
           OR p.last_name LIKE ?)
    ORDER BY s.id DESC
""";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (keyword == null || keyword.isEmpty()) {

                ps.setNull(1, Types.VARCHAR);
                ps.setNull(2, Types.BIGINT);
                ps.setNull(3, Types.VARCHAR);
                ps.setNull(4, Types.VARCHAR);

            } else {

                ps.setString(1, keyword);

                try {
                    ps.setLong(2, Long.parseLong(keyword));
                } catch (Exception e) {
                    ps.setLong(2, -1);
                }

                ps.setString(3, "%" + keyword + "%");
                ps.setString(4, "%" + keyword + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();

                s.setId(rs.getLong("id"));
                s.setPersonId(rs.getLong("person_id"));
                s.setLevelId((Integer) rs.getObject("level_id"));
                s.setFacultyId((Integer) rs.getObject("faculty_id"));
                s.setActive(rs.getBoolean("active"));
                s.setFullName(rs.getString("full_name"));


                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void toggleActive(long id, boolean active) {
        String sql = "UPDATE students SET active=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, active);
            ps.setLong(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(long id) {
        String sql = "DELETE FROM students WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private long parseLong(String s) {
        try {
            return Long.parseLong(s);
        } catch (Exception e) {
            return -1;
        }
    }

    public static Student findByPersonId(long personId) {
        String sql = "SELECT * FROM students WHERE person_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, personId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student s = new Student();
                s.setId(rs.getLong("id"));
                s.setPersonId(rs.getLong("person_id"));
                s.setLevelId(rs.getInt("level_id"));
                s.setFacultyId(rs.getInt("faculty_id"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int countUpcomingLectures(long studentId) {
        String sql = """
        SELECT COUNT(*) 
        FROM lectures l
        JOIN courses c ON l.course_id = c.id
        JOIN students s ON s.level_id = c.level_id
        WHERE s.id = ?
        AND l.lecture_date = CURDATE()
    """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int countMyCourses(long studentId) {
        String sql = """
        SELECT COUNT(DISTINCT c.id)
        FROM courses c
        JOIN students s ON s.level_id = c.level_id
        WHERE s.id = ?
    """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countPendingExams(long studentId) {
        String sql = """
        SELECT COUNT(e.id)
        FROM exams e
        JOIN courses c ON e.course_id = c.id
        JOIN students s ON s.level_id = c.level_id
        LEFT JOIN exam_submissions es 
            ON es.exam_id = e.id AND es.student_id = s.id
        WHERE s.id = ?
        AND es.id IS NULL
    """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, Object>> getStudentLectures(long studentId) {

        List<Map<String, Object>> lectures = new ArrayList<>();

        String sql = "SELECT s.id as session_id, c.name as course_name, s.session_date, s.start_time, s.end_time " +
                "FROM sessions s " +
                "JOIN courses c ON s.course_id = c.id " +
                "JOIN student_courses sc ON sc.course_id = c.id " +
                "WHERE sc.student_id=? AND sc.status='ACTIVE' " +
                "ORDER BY s.session_date ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("session_id", rs.getLong("session_id"));
                row.put("course_name", rs.getString("course_name"));
                row.put("date", rs.getDate("session_date"));
                row.put("start", rs.getTime("start_time"));
                row.put("end", rs.getTime("end_time"));

                lectures.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lectures;
    }
}
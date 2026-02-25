package com.classare.dao;
import com.classare.model.*;
import com.classare.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    public List<Session> getUpcomingSessions(int levelId) {
        List<Session> sessions = new ArrayList<>();
        String sql = "SELECT sess.*, sub.name as subject_name, p.first_name, p.last_name " +
                "FROM sessions sess " +
                "JOIN courses c ON sess.course_id = c.id " +
                "JOIN subjects sub ON c.subject_id = sub.id " +
                "JOIN teachers t ON c.teacher_id = t.id " +
                "JOIN person p ON t.person_id = p.id " +
                "WHERE c.level_id = ? AND sess.session_date >= CURDATE() " +
                "ORDER BY sess.session_date, sess.start_time";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, levelId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

            }
        } catch (SQLException e) { e.printStackTrace(); }
        return sessions;
    }
}
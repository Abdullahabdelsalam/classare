package com.classare.dao;

import com.classare.util.DBConnection;

import java.sql.*;
import java.util.*;

public class PaymentDAO {

public boolean pay(long studentId, long courseId, double amount) {

    String sql = "INSERT INTO payments (student_id, course_id, amount, status) " +
            "VALUES (?, ?, ?, 'PAID')";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setLong(1, studentId);
        ps.setLong(2, courseId);
        ps.setDouble(3, amount);

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
public List<Map<String, Object>> getInstructorPayments(long instructorId) {

    List<Map<String, Object>> list = new ArrayList<>();

    String sql =
            "SELECT p.id, p.amount, p.status, p.payment_date, " +
                    "c.id as course_id, s.name as subject, " +
                    "per.first_name, per.last_name " +
                    "FROM payments p " +
                    "JOIN courses c ON p.course_id = c.id " +
                    "LEFT JOIN subjects s ON c.subject_id = s.id " +
                    "JOIN students st ON p.student_id = st.id " +
                    "JOIN person per ON st.person_id = per.id " +
                    "WHERE c.instructor_id=? " +
                    "ORDER BY p.payment_date DESC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setLong(1, instructorId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();

            row.put("id", rs.getLong("id"));
            row.put("course", rs.getString("subject"));
            row.put("student",
                    rs.getString("first_name") + " " + rs.getString("last_name"));
            row.put("amount", rs.getDouble("amount"));
            row.put("status", rs.getString("status"));
            row.put("date", rs.getTimestamp("payment_date"));

            list.add(row);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

}

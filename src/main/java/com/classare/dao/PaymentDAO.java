package com.classare.dao;

import com.classare.util.DBConnection;

import java.sql.*;
import java.util.*;

public class PaymentDAO {

    // get student payments
    public List<Map<String, Object>> getStudentPayments(long studentId) {

        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT p.id, c.name as course_name, p.amount, p.status, p.payment_date " +
                "FROM payments p " +
                "JOIN courses c ON p.course_id = c.id " +
                "WHERE p.student_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("course", rs.getString("course_name"));
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
    // create payment (mark as paid)
    public boolean pay(long studentId, long courseId, double amount) {

        String sql = "INSERT INTO payments (student_id, course_id, amount, status) VALUES (?, ?, ?, 'PAID')";

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
}

package com.classare.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class NotificationHelper {
    /**
     * ميثود عامة لإرسال إشعار لأي مستخدم في النظام
     */
    public void sendNotification(long userId, String title, String message) {
        String sql = "INSERT INTO notifications (user_id, title, message, is_read, created_at) " +
                "VALUES (?, ?, ?, FALSE, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            stmt.setString(2, title);
            stmt.setString(3, message);

            stmt.executeUpdate();
            System.out.println("Notification sent to user: " + userId);

        } catch (SQLException e) {
            System.err.println("Error sending notification: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

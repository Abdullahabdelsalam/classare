package com.classare.controller;

import com.classare.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userOtp = request.getParameter("otp");
        String email = request.getParameter("email");

        try {
            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "SELECT otp_code, otp_expiry FROM users WHERE email=?"
            );
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String dbOtp = rs.getString("otp_code");
                Timestamp expiry = rs.getTimestamp("otp_expiry");

                if (dbOtp.equals(userOtp) &&
                        expiry.after(new Timestamp(System.currentTimeMillis()))) {

                    PreparedStatement update = conn.prepareStatement(
                            "UPDATE users SET email_verified=TRUE, otp_code=NULL WHERE email=?"
                    );
                    update.setString(1, email);
                    update.executeUpdate();

                    response.sendRedirect("registration-success.jsp?verified=true");

                } else {
                    response.sendRedirect("verify-otp.jsp?error=invalid");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

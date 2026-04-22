package com.classare.controller;

import com.classare.util.DBConnection;
import com.classare.model.Instructor;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/add-course")
public class AddCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int subjectId = Integer.parseInt(req.getParameter("subject_id"));
        double price = Double.parseDouble(req.getParameter("price"));
        String type = req.getParameter("type");

        HttpSession session = req.getSession();
        Instructor instructor = (Instructor) session.getAttribute("instructor");

        String sql = "INSERT INTO courses (subject_id, instructor_id, level_id, center_id, price, type) " +
                "VALUES (?, ?, 1, 1, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, subjectId);
            ps.setLong(2, instructor.getId());
            ps.setDouble(3, price);
            ps.setString(4, type);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("manage_courses.jsp");
    }
}

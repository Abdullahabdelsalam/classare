package com.classare.service;

import com.classare.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


        @WebServlet("/admin/dashboard")
        public class AdminDashboardServlet extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            int totalCenters = 0;
            int totalStudents = 0;
            int totalInstructors = 0;
            int activeCourses = 0;

            String sqlCenters = "SELECT COUNT(*) AS cnt FROM centers";
            String sqlStudents = "SELECT COUNT(*) AS cnt FROM students";
            String sqlInstructors = "SELECT COUNT(*) AS cnt FROM instructors";
            String sqlCourses = "SELECT COUNT(*) AS cnt FROM courses";

            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement()) {

                // Centers
                ResultSet rs = stmt.executeQuery(sqlCenters);
                if(rs.next()) totalCenters = rs.getInt("cnt");
                rs.close();

                // Students
                rs = stmt.executeQuery(sqlStudents);
                if(rs.next()) totalStudents = rs.getInt("cnt");
                rs.close();

                // Instructors
                rs = stmt.executeQuery(sqlInstructors);
                if(rs.next()) totalInstructors = rs.getInt("cnt");
                rs.close();

                // Active Courses
                rs = stmt.executeQuery(sqlCourses);
                if(rs.next()) activeCourses = rs.getInt("cnt");
                rs.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

            // Set attributes for JSP
            request.setAttribute("totalCenters", totalCenters);
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("totalInstructors", totalInstructors);
            request.setAttribute("activeCourses", activeCourses);

            // Forward to JSP
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }

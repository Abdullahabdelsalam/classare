package com.classare.controller;

import com.classare.dao.CourseDAO;
import com.classare.model.Instructor;
import com.classare.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Map;

@WebServlet("/instructor/upload-exam")
@MultipartConfig
public class UploadExamServlet extends HttpServlet {

    CourseDAO courseDAO = new CourseDAO();

    // ================= GET =================
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        Instructor instructor = (Instructor) session.getAttribute("instructor");

        if (instructor == null) {
            res.sendRedirect("../login.jsp");
            return;
        }

        List<Map<String, Object>> courses =
                courseDAO.getInstructorCoursesSimple(instructor.getId());

        req.setAttribute("courses", courses);

        try {
            req.getRequestDispatcher("upload_exam.jsp")
                    .forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= POST =================
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        long courseId = Long.parseLong(req.getParameter("course_id"));
        String title = req.getParameter("title");

        HttpSession session = req.getSession();
        Instructor instructor = (Instructor) session.getAttribute("instructor");

        Part filePart = null;
        try {
            filePart = req.getPart("file");
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
        String fileName = Paths.get(filePart.getSubmittedFileName())
                .getFileName().toString();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "exams";
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        String sql = "INSERT INTO exams (course_id, title, file_url, uploaded_by_instructor) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, courseId);
            ps.setString(2, title);
            ps.setString(3, fileName);
            ps.setLong(4, instructor.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect(req.getContextPath() + "/instructor/upload-exam?msg=done");
    }
}

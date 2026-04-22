package com.classare.controller;

import com.classare.dao.ExamDAO;
import com.classare.model.Student;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/submit-exam")
@MultipartConfig
public class SubmitExamServlet extends HttpServlet {

    ExamDAO dao = new ExamDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, jakarta.servlet.ServletException {

        long examId = Long.parseLong(req.getParameter("exam_id"));

        HttpSession session = req.getSession();
        Student student = (Student) session.getAttribute("student");

        long studentId = student.getId();

        // 🔥 check first
        if (dao.isSubmitted(examId, studentId)) {
            res.sendRedirect("jsp/student/submit_exams.jsp?msg=already");
            return;
        }

        // upload file
        Part filePart = req.getPart("file");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        boolean success = dao.submitExam(examId, studentId, fileName);

        if (success) {
            res.sendRedirect("jsp/student/submit_exams.jsp?msg=done");
        } else {
            res.sendRedirect("jsp/student/submit_exams.jsp?msg=error");
        }
    }
}

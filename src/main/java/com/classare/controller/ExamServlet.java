package com.classare.controller;

import com.classare.dao.ExamDAO;
import com.classare.model.Exam;
import com.classare.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/dashboard/exams")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ExamServlet extends HttpServlet {
    private ExamDAO examDAO = new ExamDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Part filePart = request.getPart("examFile");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        filePart.write(uploadPath + File.separator + fileName);

        Exam exam = new Exam();
        exam.setTitle(request.getParameter("title"));
        exam.setCourseId(Long.parseLong(request.getParameter("courseId")));
        exam.setFileUrl("uploads/" + fileName);
        exam.setTeacherId(((User)request.getSession().getAttribute("currentUser")).getId());

        if(examDAO.uploadExam(exam)) {
            response.sendRedirect("exams?success=true");
        }
    }
}

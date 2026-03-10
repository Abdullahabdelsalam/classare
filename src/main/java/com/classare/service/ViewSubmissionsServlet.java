package com.classare.service;

import com.classare.dao.ExamDAO;
import com.classare.model.ExamSubmission;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/view-submissions")
public class ViewSubmissionsServlet extends HttpServlet {
    private ExamDAO examDAO = new ExamDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long examId = Long.parseLong(request.getParameter("examId"));

        List<ExamSubmission> submissions = examDAO.getSubmissionsByExam(examId);

        request.setAttribute("submissions", submissions);

        request.getRequestDispatcher("/grade-submissions.jsp").forward(request, response);
    }
}

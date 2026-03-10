package com.classare.service;

import com.classare.dao.ExamDAO;
import com.classare.util.NotificationHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dashboard/grade-exam")
public class GradingServlet extends HttpServlet {

    private ExamDAO examDAO = new ExamDAO();
    private NotificationHelper notify = new NotificationHelper();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long submissionId = Long.parseLong(request.getParameter("submissionId"));
        double grade = Double.parseDouble(request.getParameter("grade"));
        long studentUserId = Long.parseLong(request.getParameter("studentUserId"));

        if (examDAO.gradeSubmission(submissionId, grade)) {

            notify.sendNotification(studentUserId, "تم تصحيح امتحانك", "درجتك في الامتحان هي: " + grade);

            response.sendRedirect("view-submissions?success=true");
        }
    }
}

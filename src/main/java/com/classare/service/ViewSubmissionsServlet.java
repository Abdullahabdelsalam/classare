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

        // 1. استقبال معرف الامتحان من الرابط
        long examId = Long.parseLong(request.getParameter("examId"));

        // 2. جلب القائمة من الـ DAO (اللي عدلناه عشان يرجع الاسم جوه الكائن)
        List<ExamSubmission> submissions = examDAO.getSubmissionsByExam(examId);

        // 3. وضع القائمة في الـ request لتصل للـ JSP
        request.setAttribute("submissions", submissions);

        // 4. التوجيه لصفحة العرض
        request.getRequestDispatcher("/grade-submissions.jsp").forward(request, response);
    }
}

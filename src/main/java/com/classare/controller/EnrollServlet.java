package com.classare.controller;


import com.classare.service.StudentCourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class EnrollServlet extends HttpServlet {

    StudentCourseService service = new StudentCourseService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long courseId = Long.parseLong(request.getParameter("course_id"));

        HttpSession session = request.getSession();
        long studentId = (long) session.getAttribute("student_id");

        String result = service.enrollStudent(studentId, courseId);

        if (result.equals("ENROLLED_SUCCESS")) {
            response.sendRedirect("jsp/student/courses.jsp?msg=success");
        } else if (result.equals("ALREADY_ENROLLED")) {
            response.sendRedirect("jsp/student/courses.jsp?msg=exists");
        } else {
            response.sendRedirect("jsp/student/courses.jsp?msg=error");
        }
    }
}

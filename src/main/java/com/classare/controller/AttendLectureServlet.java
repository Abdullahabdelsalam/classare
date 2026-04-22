package com.classare.controller;

import com.classare.dao.AttendanceDAO;
import com.classare.model.Student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/attend")
public class AttendLectureServlet extends HttpServlet {

    AttendanceDAO dao = new AttendanceDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        long sessionId = Long.parseLong(req.getParameter("session_id"));

        HttpSession session = req.getSession();
        Student student = (Student) session.getAttribute("student");
        long studentId = student.getId();

        // 🔥 CHECK FIRST
        if (dao.isAlreadyMarked(sessionId, studentId)) {
            res.sendRedirect("jsp/student/attend_lectures.jsp?msg=already");
            return;
        }

        boolean success = dao.markAttendance(sessionId, studentId);

        if (success) {
            res.sendRedirect("jsp/student/attend_lectures.jsp?msg=done");
        } else {
            res.sendRedirect("jsp/student/attend_lectures.jsp?msg=error");
        }
    }
}

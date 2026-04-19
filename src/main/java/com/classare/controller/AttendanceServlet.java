package com.classare.controller.service;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/dashboard/attendance")
public class AttendanceServlet extends HttpServlet {
//    private AttendanceDAO attendanceDAO = new AttendanceDAO();
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        long sessionId = Long.parseLong(request.getParameter("sessionId"));
//        long courseId = Long.parseLong(request.getParameter("courseId"));
//
//        List<Student> students = attendanceDAO.getStudentsByCourseLevel(courseId);
//        request.setAttribute("students", students);
//        request.setAttribute("sessionId", sessionId);
//
//        request.getRequestDispatcher("/mark-attendance.jsp").forward(request, response);
//    }
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        long sessionId = Long.parseLong(request.getParameter("sessionId"));
//        String[] studentIds = request.getParameterValues("studentIds");
//
//        for (String id : studentIds) {
//            String status = request.getParameter("status_" + id); // PRESENT or ABSENT
//            attendanceDAO.markAttendance(sessionId, Long.parseLong(id), status);
//        }
//        response.sendRedirect("sessions?courseId=" + request.getParameter("courseId") + "&attendance_saved=true");
//    }
}

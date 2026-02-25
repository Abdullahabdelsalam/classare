package com.classare.service;

import com.classare.dao.SessionDAO;
import com.classare.model.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/dashboard/sessions")
public class SessionServlet extends HttpServlet {
    private SessionDAO sessionDAO = new SessionDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long courseId = Long.parseLong(request.getParameter("courseId"));
        // جلب الحصص القديمة لعرضها
        List<Session> sessions = sessionDAO.getSessionsByCourse(courseId);
        request.setAttribute("sessions", sessions);
        request.setAttribute("courseId", courseId);
        request.getRequestDispatcher("/manage-sessions.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session s = new Session();
        s.setCourseId(Long.parseLong(request.getParameter("courseId")));
        s.setCenterId(Long.parseLong(request.getParameter("centerId"))); // هتاخده من بيانات الكورس
        s.setSessionDate(LocalDate.parse(request.getParameter("date")));
        s.setStartTime(LocalTime.parse(request.getParameter("startTime")));
        s.setEndTime(LocalTime.parse(request.getParameter("endTime")));

        if(sessionDAO.addSession(s)) {
            response.sendRedirect("sessions?courseId=" + s.getCourseId() + "&success=true");
        } else {
            response.sendRedirect("sessions?courseId=" + s.getCourseId() + "&error=true");
        }
    }
}

package com.classare.controller;

import com.classare.dao.LectureDAO;
import com.classare.model.Instructor;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/instructor/lectures")
public class ManageLecturesServlet extends HttpServlet {

    LectureDAO dao = new LectureDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        Instructor instructor = (Instructor) session.getAttribute("instructor");

        if (instructor == null) {
            res.sendRedirect("../login.jsp");
            return;
        }

        var lectures = dao.getInstructorLectures(instructor.getId());

        req.setAttribute("lectures", lectures);

        try {
            req.getRequestDispatcher("manage_lectures.jsp")
                    .forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

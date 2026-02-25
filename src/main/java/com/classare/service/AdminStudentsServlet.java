package com.classare.service;

import com.classare.dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/students")
public class AdminStudentsServlet  extends HttpServlet {

    private StudentDAO dao = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("search");

        request.setAttribute("students", dao.findAll(keyword));
        request.getRequestDispatcher("/admin/admin-students.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");
        long id = Long.parseLong(request.getParameter("id"));

        if ("toggle".equals(action)) {
            boolean active = Boolean.parseBoolean(request.getParameter("active"));
            dao.toggleActive(id, !active);
        }

        if ("delete".equals(action)) {
            dao.delete(id);
        }

        response.sendRedirect(request.getContextPath() + "/admin/students");
    }
}
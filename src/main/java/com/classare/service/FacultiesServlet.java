package com.classare.service;

import com.classare.dao.FacultyDAO;
import com.classare.model.Faculty;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/faculties")
public class FacultiesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Faculty> faculties = FacultyDAO.getAllFaculties();
        request.setAttribute("faculties", faculties);
        request.getRequestDispatcher("/admin/faculties.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("faculties");
            return;
        }

        switch (action) {
            case "create":
                String name = request.getParameter("name");
                FacultyDAO.createFaculty(name);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                String newName = request.getParameter("name");
                FacultyDAO.updateFaculty(id, newName);
                break;
            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                FacultyDAO.deleteFaculty(delId);
                break;
        }

        response.sendRedirect("faculties");
    }
}

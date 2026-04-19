package com.classare.controller;

import com.classare.dao.SubjectDAO;
import com.classare.dao.LevelDAO;
import com.classare.model.Subject;
import com.classare.model.Level;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/subjects")
public class SubjectsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Subject> subjects = SubjectDAO.getAllSubjects();
        List<Level> levels = LevelDAO.getAllLevels();

        request.setAttribute("subjects", subjects);
        request.setAttribute("levels", levels);
        request.getRequestDispatcher("/admin/subjects.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("subjects");
            return;
        }

        switch (action) {
            case "create":
                String name = request.getParameter("name");
                int levelId = Integer.parseInt(request.getParameter("levelId"));
                SubjectDAO.createSubject(name, levelId);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                String newName = request.getParameter("name");
                int newLevelId = Integer.parseInt(request.getParameter("levelId"));
                SubjectDAO.updateSubject(id, newName, newLevelId);
                break;
            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                SubjectDAO.deleteSubject(delId);
                break;
        }

        response.sendRedirect("subjects");
    }
}

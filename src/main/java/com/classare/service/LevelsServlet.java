package com.classare.service;

import com.classare.dao.LevelDAO;
import com.classare.model.Level;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/levels")
public class LevelsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Level> levels = LevelDAO.getAllLevels();
        request.setAttribute("levels", levels);
        request.getRequestDispatcher("/admin/levels.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("levels");
            return;
        }

        switch (action) {
            case "create":
                String name = request.getParameter("name");
                LevelDAO.createLevel(name);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                String newName = request.getParameter("name");
                LevelDAO.updateLevel(id, newName);
                break;
            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                LevelDAO.deleteLevel(delId);
                break;
        }

        response.sendRedirect("levels");
    }
}
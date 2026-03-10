package com.classare.service;

import com.classare.dao.AcademicDAO;
import com.classare.model.Stage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/academic")
public class AcademicServlet extends HttpServlet {

    private AcademicDAO academicDAO = new AcademicDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Stage> stages = academicDAO.getAllStages();
        request.setAttribute("stages", stages);

        request.getRequestDispatcher("academic-mgmt.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        boolean success = false;

        if ("addStage".equals(action)) {
            String name = request.getParameter("stageName");
            success = academicDAO.addStage(name);
        }
        else if ("addLevel".equals(action)) {
            int stageId = Integer.parseInt(request.getParameter("stageId"));
            String levelName = request.getParameter("levelName");
            success = academicDAO.addLevel(stageId, levelName);
        }
        else if ("addSubject".equals(action)) {
            int stageId = Integer.parseInt(request.getParameter("stageId"));
            String subjectName = request.getParameter("subjectName");
            success = academicDAO.addSubject(stageId, subjectName);
        }

        if (success) {
            response.sendRedirect("academic?success=true");
        } else {
            response.sendRedirect("academic?error=true");
        }
    }
}

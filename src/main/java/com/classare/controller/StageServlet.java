package com.classare.controller;
import com.classare.dao.StageDAO;
import com.classare.model.Stage;
import com.classare.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/stages")
public class StageServlet extends HttpServlet {

    private StageDAO stageDAO;

    @Override
    public void init() {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        stageDAO = new StageDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<Stage> stages = stageDAO.getAllStages();
            req.setAttribute("stages", stages);
            req.getRequestDispatcher("/admin/stages.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500, "Database Error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                String name = req.getParameter("name");
                Stage stage = new Stage();
                stage.setName(name);
                stageDAO.addStage(stage);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                Stage stage = new Stage();
                stage.setId(id);
                stage.setName(name);
                stageDAO.updateStage(stage);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                stageDAO.deleteStage(id);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/stages");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500, "Database Error");
        }
    }
}

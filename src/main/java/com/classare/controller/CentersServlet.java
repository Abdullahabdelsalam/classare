package com.classare.controller.service;


import com.classare.dao.CenterDAO;
import com.classare.model.Center;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/centers")
public class CentersServlet extends HttpServlet {

    // عرض الصفحة
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action != null && action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            CenterDAO.deleteCenter(id);
            response.sendRedirect("centers");
            return;
        }

        List<Center> centers = CenterDAO.getAllCenters();
        request.setAttribute("centers", centers);
        request.getRequestDispatcher("/admin/centers.jsp").forward(request, response);
    }

    // إضافة أو تعديل
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");

        if ("create".equals(action)) {

            CenterDAO.createCenter(name, address, phone, location);

        } else if ("update".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            CenterDAO.updateCenter(id, name, address, phone, location);
        }

        response.sendRedirect("centers");
    }
}
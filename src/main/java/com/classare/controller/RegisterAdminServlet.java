package com.classare.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.classare.service.AdminService;
import jakarta.servlet.http.*;

@WebServlet("/register-admin")
public class RegisterAdminServlet extends HttpServlet {

    private final AdminService service = new AdminService();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");

        boolean created = service.createAdmin(firstName, lastName, email, password);

        if (created) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard?success=admin_created");
        } else {
            res.sendRedirect("admin-register.jsp?error=email_exists_or_failed");
        }
    }
}

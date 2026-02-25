package com.classare.service;

import com.classare.dao.InstructorDAO;
import com.classare.dao.StudentDAO;
import com.classare.dao.UserDAO;
import com.classare.model.User;
import com.classare.util.PasswordUtil;
import com.classare.dao.InstructorDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = UserDAO.findByEmail(email);
        if (user == null || !PasswordUtil.check(password, user.getPasswordHash())) {
            res.sendRedirect("login.jsp?error=invalid");
            return;
        }
        if (!user.isActive()) {
            res.sendRedirect("login.jsp?error=inactive");
            return;
        }
        HttpSession session = req.getSession(true);
        session.setMaxInactiveInterval(30 * 60);

        session.setAttribute("user", user);
        session.setAttribute("person", user.getPerson());
        session.setAttribute("roles", user.getRoles());

        if  (user.hasRole("ADMIN")) {
            res.sendRedirect("admin/dashboard");
        } else if (user.hasRole("STUDENT")) {
            session.setAttribute("student",
                    StudentDAO.findByPersonId(user.getPerson().getId()));
            res.sendRedirect("student/dashboard.jsp");
        } else if (user.hasRole("INSTRUCTOR")) {
            session.setAttribute("instructor",
                    InstructorDAO.findByPersonId(user.getPerson().getId()));
            res.sendRedirect("instructor/dashboard.jsp");
        } else {
            res.sendRedirect("dashboard.jsp");
        }
    }
}

package com.classare.service;


import com.classare.dao.UserDAO;
import com.classare.model.Person;
import com.classare.model.User;
import com.classare.model.Role;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.Collections;

@WebServlet("/register-admin")
public class RegisterAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");

        Person person = new Person();
        person.setFirstName(firstName);
        person.setLastName(lastName);

        User user = new User();
        user.setEmail(email);
        user.setPasswordHash(BCrypt.hashpw(password, BCrypt.gensalt()));
        user.setPerson(person);

        Role adminRole = new Role();
        adminRole.setId(1);
        adminRole.setName("ADMIN");

        user.setRoles(Collections.singletonList(adminRole));

        boolean created = UserDAO.createAdmin(user);
        if (created) {
            res.sendRedirect("login.jsp?success=admin_created");
        } else {
            res.sendRedirect("admin-register.jsp?error=failed");
        }
    }
}

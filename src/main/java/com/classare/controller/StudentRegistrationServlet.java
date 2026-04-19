package com.classare.controller;

import com.classare.dao.AcademicDAO;
import com.classare.dao.RegistrationDAO;
import com.classare.model.Level;
import com.classare.model.Person;
import com.classare.model.Stage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/register-student")
public class StudentRegistrationServlet extends HttpServlet {

    private RegistrationDAO regDAO = new RegistrationDAO();
    private AcademicDAO academicDAO = new AcademicDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Stage> stages = academicDAO.getAllStages();

        List<Level> levels = academicDAO.getAllLevels();

        request.setAttribute("stages", stages);
        request.setAttribute("levels", levels);
        request.setAttribute("faculties", academicDAO.getAllFaculties());


        request.getRequestDispatcher("student-reg.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Person p = new Person();
            p.setFirstName(request.getParameter("firstName"));
            p.setLastName(request.getParameter("lastName"));
            p.setBirthDate(LocalDate.parse(request.getParameter("birthDate")));
            p.setNationalId(request.getParameter("nationalId"));
            p.setGender(request.getParameter("gender"));
            p.setPhone(request.getParameter("phone"));
            p.setAddress(request.getParameter("address"));
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String levelIdRaw = request.getParameter("levelId");
            if (levelIdRaw == null || email == null || pass == null) {
                response.sendRedirect("register-student?error=missing_fields");
                return;
            }

            int levelId = Integer.parseInt(levelIdRaw);
            String facultyIdRaw = request.getParameter("facultyId");
            int facultyId = 0;
            if (facultyIdRaw != null && !facultyIdRaw.isEmpty()) {
                facultyId = Integer.parseInt(facultyIdRaw);
            }

            boolean success = regDAO.registerStudent(p, email, pass, levelId, facultyId);

            if (success) {
                response.sendRedirect("registration-success.jsp");
            } else {
                response.sendRedirect("register-student?error=db_error");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("register-student?error=invalid_data");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register-student?error=server_error");
        }
    }
}
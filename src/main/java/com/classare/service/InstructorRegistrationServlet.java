package com.classare.service;

import com.classare.dao.RegistrationDAO;
import com.classare.model.Instructor;
import com.classare.model.Person;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register-instructor")
public class InstructorRegistrationServlet extends HttpServlet {

    private final RegistrationDAO registrationDAO = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // فتح صفحة التسجيل
        request.getRequestDispatcher("instructor-reg.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ===============================
            // 1️⃣ قراءة البيانات من الفورم
            // ===============================
            String firstName     = request.getParameter("firstName");
            String lastName      = request.getParameter("lastName");
            String nationalId    = request.getParameter("nationalId");
            String gender        = request.getParameter("gender");
            String phone         = request.getParameter("phone");
            String address       = request.getParameter("address");
            String specialization= request.getParameter("specialization");

            String email         = request.getParameter("email");
            String password      = request.getParameter("password");
            String birthDateStr  = request.getParameter("birthDate");

            // ===============================
            // 2️⃣ تجهيز Person
            // ===============================
            Person person = new Person();
            person.setFirstName(firstName);
            person.setLastName(lastName);
            person.setNationalId(nationalId);
            person.setGender(gender);
            person.setPhone(phone);
            person.setAddress(address);

            // تحويل تاريخ الميلاد (HTML → LocalDate)
            if (birthDateStr != null && !birthDateStr.isBlank()) {
                person.setBirthDate(LocalDate.parse(birthDateStr));
            }

            // ===============================
            // 3️⃣ تجهيز Instructor
            // ===============================
            Instructor instructor = new Instructor();
            instructor.setPerson(person);
            instructor.setSpecialization(specialization);

            // ===============================
            // 4️⃣ الحفظ في الداتابيز
            // ===============================
            boolean success =
                    registrationDAO.registerInstructor(instructor, email, password);

            // ===============================
            // 5️⃣ Navigation
            // ===============================
            if (success) {
                response.sendRedirect("registration-success.jsp");
            } else {
                request.setAttribute(
                        "error",
                        "Registration failed. Email or National ID already exists."
                );
                request.getRequestDispatcher("instructor-reg.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute(
                    "error",
                    "Unexpected error: " + e.getMessage()
            );
            request.getRequestDispatcher("instructor-reg.jsp")
                    .forward(request, response);
        }
    }
}

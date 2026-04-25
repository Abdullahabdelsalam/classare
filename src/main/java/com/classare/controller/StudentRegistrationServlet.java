package com.classare.controller;

import com.classare.dao.AcademicDAO;
import com.classare.dao.RegistrationDAO;
import com.classare.model.Level;
import com.classare.model.Person;
import com.classare.model.Stage;
import com.classare.util.EmailUtil;
import com.classare.util.OTPUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 2, // 2MB
        maxRequestSize = 1024 * 1024 * 5
)
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

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String birthDateRaw = request.getParameter("birthDate");
            String nationalId = request.getParameter("nationalId");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String levelIdRaw = request.getParameter("levelId");

            if (firstName == null || lastName == null || birthDateRaw == null ||
                    email == null || pass == null || levelIdRaw == null) {

                response.sendRedirect("register-student?error=missing_fields");
                return;
            }


            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                response.sendRedirect("register-student?error=invalid_email");
                return;
            }


            if (pass.length() < 6) {
                response.sendRedirect("register-student?error=weak_password");
                return;
            }

            Part imagePart = request.getPart("profileImage");

            if (imagePart == null || imagePart.getSize() == 0) {
                response.sendRedirect("register-student?error=no_image");
                return;
            }

            if (!imagePart.getContentType().startsWith("image/")) {
                response.sendRedirect("register-student?error=invalid_image");
                return;
            }

            String originalFileName = new File(imagePart.getSubmittedFileName()).getName();
            String fileName = System.currentTimeMillis() + "_" + originalFileName;

            String uploadPath = "C:/classare/uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            imagePart.write(uploadPath + File.separator + fileName);

            String imagePath = "uploads/" + fileName;

            LocalDate birthDate = LocalDate.parse(birthDateRaw);
            int levelId = Integer.parseInt(levelIdRaw);

            String facultyIdRaw = request.getParameter("facultyId");
            int facultyId = 0;
            if (facultyIdRaw != null && !facultyIdRaw.isEmpty()) {
                facultyId = Integer.parseInt(facultyIdRaw);
            }


            Person p = new Person();
            p.setFirstName(firstName);
            p.setLastName(lastName);
            p.setBirthDate(birthDate);
            p.setNationalId(nationalId);
            p.setGender(gender);
            p.setPhone(phone);
            p.setAddress(address);
            p.setProfileImageUrl(imagePath);

            boolean success = regDAO.registerStudent(p, email, pass, levelId, facultyId);

            if (!success) {
                response.sendRedirect("register-student?error=db_error");
                return;
            }


            String otp = OTPUtil.generateOTP();
            regDAO.saveOTP(email, otp);

            try {
                EmailUtil.sendOTP(email, otp);
                System.out.println("EMAIL SENT SUCCESSFULLY");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("register-student?error=email_failed");
                return;
            }


            HttpSession session = request.getSession();
            session.setAttribute("email", email);

            response.sendRedirect("verify-otp.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("register-student?error=invalid_numbers");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register-student?error=server_error");
        }
    }
}
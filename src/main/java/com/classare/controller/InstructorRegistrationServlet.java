package com.classare.controller;

import com.classare.dao.RegistrationDAO;
import com.classare.model.Instructor;
import com.classare.model.InstructorDocument;
import com.classare.model.Person;
import com.classare.util.EmailUtil;
import com.classare.util.OTPUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/register-instructor")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class InstructorRegistrationServlet extends HttpServlet {

    private final RegistrationDAO dao = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("instructor-reg.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || password == null ||
                    request.getParameter("firstName") == null) {
                response.sendRedirect("instructor-reg.jsp?error=missing_fields");
                return;
            }

            String basePath = "C:/classare/uploads/instructors";

            File dir = new File(basePath);
            if (!dir.exists()) dir.mkdirs();

            Part profilePart = request.getPart("profileImage");

            String profileName = System.currentTimeMillis() + "_"
                    + profilePart.getSubmittedFileName();

            String profilePath = basePath + "/" + profileName;
            profilePart.write(profilePath);

            String profileUrl = "uploads/instructors/" + profileName;

            Person p = new Person();
            p.setFirstName(request.getParameter("firstName"));
            p.setLastName(request.getParameter("lastName"));
            p.setNationalId(request.getParameter("nationalId"));
            p.setGender(request.getParameter("gender"));
            p.setPhone(request.getParameter("phone"));
            p.setAddress(request.getParameter("address"));
            p.setBirthDate(LocalDate.parse(request.getParameter("birthDate")));
            p.setProfileImageUrl(profileUrl);

            Instructor ins = new Instructor();
            ins.setPerson(p);
            ins.setSpecialization(request.getParameter("specialization"));

            List<InstructorDocument> docs = new ArrayList<>();

            for (Part part : request.getParts()) {

                if ("document".equals(part.getName()) && part.getSize() > 0) {

                    String docName = System.currentTimeMillis() + "_"
                            + part.getSubmittedFileName();

                    String docPath = basePath + "/" + docName;

                    part.write(docPath);

                    InstructorDocument doc = new InstructorDocument();
                    doc.setFileUrl("uploads/instructors/" + docName);
                    doc.setFileType(part.getContentType());

                    docs.add(doc);
                }
            }

            boolean success = dao.registerInstructor(
                    ins,
                    email,
                    password,
                    docs
            );

            if (!success) {
                response.sendRedirect("register-instructor?error=db_error");
                return;
            }
            String otp = OTPUtil.generateOTP();
            dao.saveOTP(email, otp);

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
            response.sendRedirect("instructor-reg.jsp?error=server_error");
        }
    }
}
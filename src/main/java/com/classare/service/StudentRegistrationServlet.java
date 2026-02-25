package com.classare.service;

import com.classare.dao.AcademicDAO;
import com.classare.dao.RegistrationDAO;
import com.classare.model.Faculty;
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

        // 1. جلب كل المراحل (Primary, Middle, High... etc)
        List<Stage> stages = academicDAO.getAllStages();

        // 2. جلب كل المستويات (Grade 1, Grade 2... etc)
        List<Level> levels = academicDAO.getAllLevels();
//        List<Faculty> faculties = academicDAO.getAllFaculties();

        // 3. تمرير البيانات للـ JSP
        request.setAttribute("stages", stages);
        request.setAttribute("levels", levels);
        request.setAttribute("faculties", academicDAO.getAllFaculties());


        // 4. التوجه لصفحة التسجيل
        request.getRequestDispatcher("student-reg.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. استخراج بيانات الشخص من الفورم
            Person p = new Person();
            p.setFirstName(request.getParameter("firstName"));
            p.setLastName(request.getParameter("lastName"));
            p.setBirthDate(LocalDate.parse(request.getParameter("birthDate")));
            p.setNationalId(request.getParameter("nationalId"));
            p.setGender(request.getParameter("gender"));
            p.setPhone(request.getParameter("phone"));
            p.setAddress(request.getParameter("address"));

            // 2. استخراج بيانات الحساب والمستوى الدراسي
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String levelIdRaw = request.getParameter("levelId");

            // التحقق من وجود البيانات الأساسية
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

            // 3. تنفيذ عملية التسجيل عبر الـ DAO
            // الـ DAO يقوم داخلياً بإنشاء (Person -> User -> Student) في Transaction واحدة
            boolean success = regDAO.registerStudent(p, email, pass, levelId, facultyId);

            if (success) {
                // التوجه لصفحة النجاح بدلاً من صفحة اللوجن مباشرة
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
package com.classare.controller.service;

import com.classare.dao.AcademicDAO;
import com.classare.dao.CenterDAO;
import com.classare.dao.CourseDAO;
import com.classare.dao.InstructorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/manage-courses")
public class CourseServlet extends HttpServlet {

    private CourseDAO courseDAO = new CourseDAO();
    private AcademicDAO academicDAO = new AcademicDAO();
    private CenterDAO centerDAO = new CenterDAO();
    InstructorDAO instructorDAO = new InstructorDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("subjects", academicDAO.getAllSubjects());
        request.setAttribute("levels", academicDAO.getAllLevels());
        request.setAttribute("centers", centerDAO.getAllCenters());
        request.setAttribute("instructors", instructorDAO.getAllInstructors());

        request.getRequestDispatcher("add-course.jsp").forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long subjectId = Long.parseLong(request.getParameter("subjectId"));
        long teacherId = Long.parseLong(request.getParameter("teacherId"));
        int levelId = Integer.parseInt(request.getParameter("levelId"));
        long centerId = Long.parseLong(request.getParameter("centerId"));
        double price = Double.parseDouble(request.getParameter("price"));
        String type = request.getParameter("type");
        int maxStudents = Integer.parseInt(request.getParameter("maxStudents"));

        if (courseDAO.addCourse(subjectId, teacherId, levelId, centerId, price, type, maxStudents)) {
            response.sendRedirect("manage-courses?success=true");
        } else {
            response.sendRedirect("manage-courses?error=true");
        }
    }

}

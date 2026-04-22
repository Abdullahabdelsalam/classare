package com.classare.controller;

import com.classare.dao.PaymentDAO;
import com.classare.model.Student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/pay")
public class PaymentServlet extends HttpServlet {

    PaymentDAO dao = new PaymentDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        long courseId = Long.parseLong(req.getParameter("course_id"));
        double amount = Double.parseDouble(req.getParameter("amount"));

        HttpSession session = req.getSession();
        Student student = (Student) session.getAttribute("student");

        boolean success = dao.pay(student.getId(), courseId, amount);

        if (success) {
            res.sendRedirect("jsp/student/payments.jsp?msg=success");
        } else {
            res.sendRedirect("jsp/student/payments.jsp?msg=error");
        }
    }
}
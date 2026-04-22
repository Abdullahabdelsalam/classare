package com.classare.controller;

import com.classare.dao.PaymentDAO;
import com.classare.model.Instructor;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/instructor/payments")
public class InstructorPaymentsServlet extends HttpServlet {

    PaymentDAO dao = new PaymentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        Instructor instructor = (Instructor) session.getAttribute("instructor");

        if (instructor == null) {
            res.sendRedirect("../login.jsp");
            return;
        }

        var payments = dao.getInstructorPayments(instructor.getId());

        req.setAttribute("payments", payments);

        try {
            req.getRequestDispatcher("view_payments.jsp")
                    .forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

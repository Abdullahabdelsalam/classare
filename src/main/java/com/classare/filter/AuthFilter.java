package com.classare.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter({"/student/*", "/instructor/*"})
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpSession session = ((HttpServletRequest) req).getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            ((HttpServletResponse) res).sendRedirect("/login.jsp");
            return;
        }
        chain.doFilter(req, res);
    }
}

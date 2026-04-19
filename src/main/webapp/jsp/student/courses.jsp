<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.classare.util.DBConnection" %>
<%@ page import="com.classare.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("../../login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM courses");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Explore Courses | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --bg: #f1f5f9; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg); color: #1e293b; }
        .course-grid { padding: 3rem 0; }

        .course-card {
            background: white;
            border-radius: 24px;
            border: none;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            height: 100%;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }

        .course-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
        }

        .course-banner {
            height: 140px;
            background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
        }

        .course-body { padding: 1.5rem; }
        .course-title { font-weight: 800; font-size: 1.1rem; margin-bottom: 0.5rem; color: #0f172a; }
        .course-info { font-size: 0.85rem; color: #64748b; margin-bottom: 1.5rem; }

        .btn-enroll {
            width: 100%;
            background: #0f172a;
            color: white;
            border-radius: 12px;
            font-weight: 700;
            padding: 0.75rem;
            border: none;
            transition: 0.3s;
        }

        .btn-enroll:hover {
            background: var(--accent);
            transform: scale(1.02);
        }

        .badge-new {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="container course-grid">
    <div class="header-section mb-5 text-center">
        <h2 class="fw-800">Available Courses &#128640;</h2>
        <p class="text-muted">Unlock your potential by enrolling in our top-rated academic programs.</p>
    </div>

    <div class="row g-4">
        <% while(rs.next()) { %>
        <div class="col-md-4 col-lg-3">
            <div class="course-card shadow-sm">
                <div class="course-banner">
                    <i class="fa-solid fa-graduation-cap"></i>
                    <span class="badge-new">New</span>
                </div>

                <div class="course-body">
                    <h5 class="course-title"><%= rs.getString("name") %></h5>
                    <p class="course-info">
                        <i class="fa-regular fa-clock me-1"></i> Self-paced learning
                    </p>

                    <form action="../../EnrollServlet" method="post">
                        <input type="hidden" name="course_id" value="<%= rs.getLong("id") %>">
                        <button type="submit" class="btn-enroll">
                            <i class="fa-solid fa-user-plus me-2"></i> Enroll Now
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.classare.model.*" %>
<%@ page import="com.classare.dao.*" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("INSTRUCTOR")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Instructor instructor = (Instructor) session.getAttribute("instructor");
    CourseDAO dao = new CourseDAO();

    List<Course> courses = null;
    if (instructor != null) {
        courses = dao.getInstructorCourses(instructor.getId());
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --instructor-primary: #4f46e5; --bg-light: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-light); color: #1e293b; }

        .main-container { padding: 3rem 1.5rem; max-width: 1200px; margin: 0 auto; }

        .page-header { margin-bottom: 3rem; }
        .page-title { font-weight: 800; font-size: 2.2rem; color: #0f172a; }

        /* Course Card Styling */
        .instructor-course-card {
            background: white;
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .instructor-course-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.05);
            border-color: var(--instructor-primary);
        }

        .card-top {
            padding: 2rem 1.5rem;
            background: #f1f5f9;
            text-align: center;
            font-size: 3rem;
            color: var(--instructor-primary);
        }

        .card-content { padding: 1.5rem; flex-grow: 1; }
        .course-badge {
            background: #eef2ff;
            color: var(--instructor-primary);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 800;
            margin-bottom: 0.8rem;
            display: inline-block;
        }

        .course-name { font-weight: 800; font-size: 1.2rem; color: #0f172a; margin-bottom: 0.5rem; }
        .price-tag { font-weight: 700; color: #10b981; font-size: 1.1rem; }

        /* Buttons */
        .btn-add-course {
            background: var(--instructor-primary);
            color: white;
            border-radius: 14px;
            padding: 10px 24px;
            font-weight: 700;
            border: none;
            transition: 0.3s;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }
        .btn-add-course:hover {
            background: #4338ca;
            color: white;
            transform: translateY(-2px);
        }

        .btn-manage {
            background: #f8fafc;
            color: #475569;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            font-weight: 700;
            width: 100%;
            padding: 0.7rem;
            transition: 0.2s;
        }
        .btn-manage:hover {
            background: var(--instructor-primary);
            color: white;
            border-color: var(--instructor-primary);
        }

        .empty-state {
            background: white; border-radius: 30px; padding: 5rem 2rem;
            text-align: center; border: 2px dashed #cbd5e1;
        }
    </style>
</head>
<body>

<div class="main-container">

    <header class="page-header d-flex justify-content-between align-items-center">
        <div>
            <h1 class="page-title">Curriculum Manager 📚</h1>
            <p class="text-muted mb-0">Create and oversee your educational content on Classare.</p>
        </div>
        <a href="add_course.jsp" class="btn btn-add-course">
            <i class="fa-solid fa-plus me-2"></i> Create New Course
        </a>
    </header>

    <% if (courses == null || courses.isEmpty()) { %>
        <div class="empty-state">
            <div class="bg-light d-inline-block p-4 rounded-circle mb-4">
                <i class="fa-solid fa-book-open fs-1 text-muted"></i>
            </div>
            <h4 class="fw-bold">No Courses Yet</h4>
            <p class="text-muted mb-4">Start by creating your first course to begin teaching.</p>
            <a href="add_course.jsp" class="btn btn-add-course px-5">Get Started</a>
        </div>
    <% } else { %>

    <div class="row g-4">
        <% for (Course c : courses) { %>
        <div class="col-md-4">
            <div class="instructor-course-card shadow-sm">
                <div class="card-top">
                    <i class="fa-solid fa-graduation-cap"></i>
                </div>
                <div class="card-content">
                    <span class="course-badge"><%= c.getType() %></span>
                    <h5 class="course-name text-truncate"><%= c.getName() %></h5>
                    <p class="price-tag mb-4">$<%= c.getPrice() %></p>

                    <a href="course_details.jsp?id=<%= c.getId() %>" class="btn btn-manage text-decoration-none d-block text-center">
                        <i class="fa-solid fa-sliders me-2"></i> Manage Course
                    </a>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
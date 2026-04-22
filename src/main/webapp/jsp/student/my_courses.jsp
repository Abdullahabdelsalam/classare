<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.classare.model.*" %>
<%@ page import="com.classare.dao.*" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("STUDENT")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Student student = (Student) session.getAttribute("student");
    StudentCourseDAO dao = new StudentCourseDAO();

    List<Course> courses = null;
    if (student != null) {
        courses = dao.getMyCourses(student.getId());
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Learning | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --student-bg: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--student-bg); color: #1e293b; }

        .main-container { padding: 3rem 1.5rem; max-width: 1200px; margin: 0 auto; }

        .page-header { margin-bottom: 3rem; }
        .page-title { font-weight: 800; font-size: 2rem; color: #0f172a; letter-spacing: -0.5px; }

        /* Learning Card Styling */
        .learning-card {
            background: white;
            border-radius: 20px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .learning-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.05);
            border-color: #cbd5e1;
        }

        .card-banner {
            height: 120px;
            background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: rgba(255,255,255,0.8);
            position: relative;
        }

        .course-type-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.9);
            color: #0f172a;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 800;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .card-body { padding: 1.5rem; flex-grow: 1; display: flex; flex-direction: column; justify-content: space-between; }
        .course-title { font-weight: 800; font-size: 1.1rem; color: #0f172a; margin-bottom: 1rem; line-height: 1.4; }

        /* Fake Progress Bar for UI enhancement */
        .progress-container { margin-bottom: 1.5rem; }
        .progress { height: 6px; border-radius: 10px; background-color: #e2e8f0; }
        .progress-bar { background-color: #10b981; border-radius: 10px; }
        .progress-text { font-size: 0.75rem; color: #64748b; font-weight: 600; margin-top: 5px; display: block; }

        .btn-continue {
            background: #f8fafc;
            color: var(--accent);
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            font-weight: 700;
            padding: 0.7rem;
            width: 100%;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-continue:hover { background: var(--accent); color: white; border-color: var(--accent); }

        /* Empty State Styling */
        .empty-state {
            background: white; border-radius: 24px; padding: 4rem 2rem;
            text-align: center; border: 1px dashed #cbd5e1;
        }
        .empty-icon { font-size: 4rem; color: #94a3b8; margin-bottom: 1.5rem; }

        .back-link { color: #64748b; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: 0.3s; }
        .back-link:hover { color: #0f172a; }
    </style>
</head>
<body>

<div class="main-container">

    <div class="mb-4">
        <a href="dashboard.jsp" class="back-link">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>

    <header class="page-header d-flex justify-content-between align-items-end border-bottom pb-4">
        <div>
            <h1 class="page-title">My Learning 📚</h1>
            <p class="text-muted mb-0">Track your progress and continue your courses.</p>
        </div>
        <div>
            <span class="badge bg-dark rounded-pill px-3 py-2 fw-bold shadow-sm">
                <%= (courses != null) ? courses.size() : 0 %> Enrolled
            </span>
        </div>
    </header>

    <% if (courses == null || courses.isEmpty()) { %>
        <div class="empty-state shadow-sm">
            <i class="fa-solid fa-folder-open empty-icon"></i>
            <h4 class="fw-bold text-dark">No Active Courses Yet</h4>
            <p class="text-muted mb-4">You haven't enrolled in any educational programs. Start your learning journey today!</p>
            <a href="available_courses.jsp" class="btn btn-primary rounded-pill px-4 py-2 fw-bold">
                Explore Available Courses <i class="fa-solid fa-arrow-right ms-2"></i>
            </a>
        </div>
    <% } else { %>
        <div class="row g-4">
            <% for (Course c : courses) { %>
                <div class="col-md-4 col-lg-3">
                    <div class="learning-card">
                        <div class="card-banner">
                            <i class="fa-solid fa-laptop-code"></i>
                            <span class="course-type-badge">
                                <i class="fa-solid fa-tag text-muted me-1 small"></i> <%= c.getType() %>
                            </span>
                        </div>

                        <div class="card-body">
                            <div>
                                <h5 class="course-title"><%= c.getName() %></h5>

                                <div class="progress-container">
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" style="width: 15%;"></div>
                                    </div>
                                    <span class="progress-text">In Progress</span>
                                </div>
                            </div>

                            <a href="course_details.jsp?id=<%= c.getId() %>" class="btn-continue">
                                Continue Learning <i class="fa-regular fa-circle-play ms-1"></i>
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
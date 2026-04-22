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
    StudentDAO dao = new StudentDAO();

    List<Map<String, Object>> lectures = null;
    if (student != null) {
        lectures = dao.getStudentLectures(student.getId());
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecture Attendance | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --student-bg: #f8fafc; --success: #10b981; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--student-bg); color: #1e293b; }

        .main-container { padding: 3rem 1.5rem; max-width: 1000px; margin: 0 auto; }

        /* Navigation & Header */
        .back-link { color: #64748b; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: 0.3s; }
        .back-link:hover { color: #0f172a; }
        .page-header { margin-bottom: 2.5rem; }
        .page-title { font-weight: 800; font-size: 2.2rem; color: #0f172a; letter-spacing: -1px; }

        /* Schedule Card & Table */
        .schedule-card {
            background: white;
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 30px -10px rgba(0,0,0,0.03);
            overflow: hidden;
        }

        .table-agenda { margin-bottom: 0; }
        .table-agenda thead th {
            background: #f8fafc;
            color: #64748b;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .table-agenda tbody td {
            padding: 1.5rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }
        .table-agenda tbody tr:last-child td { border-bottom: none; }

        /* Badges & Icons */
        .time-badge {
            background: #f1f5f9;
            color: #475569;
            padding: 6px 12px;
            border-radius: 10px;
            font-size: 0.85rem;
            font-weight: 700;
            border: 1px solid #e2e8f0;
        }
        .course-name { font-weight: 800; color: #0f172a; font-size: 1.1rem; }

        /* Action Button */
        .btn-attend {
            background-color: #ecfdf5;
            color: var(--success);
            border: 1px solid #a7f3d0;
            border-radius: 12px;
            padding: 10px 22px;
            font-weight: 700;
            transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-attend:hover {
            background-color: var(--success);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(16, 185, 129, 0.2);
        }

        /* Empty State */
        .empty-state {
            background: white; border-radius: 24px; padding: 5rem 2rem;
            text-align: center; border: 2px dashed #e2e8f0;
        }
    </style>
</head>
<body>

<div class="main-container">

    <div class="mb-4">
        <a href="dashboard.jsp" class="back-link">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Hub
        </a>
    </div>

    <header class="page-header d-flex justify-content-between align-items-center">
        <div>
            <h1 class="page-title">Lecture Agenda 📅</h1>
            <p class="text-muted mb-0">Stay on track with your daily learning schedule.</p>
        </div>
        <div class="text-end">
            <span class="badge bg-white text-dark border rounded-pill px-3 py-2 fw-bold shadow-sm">
                <%= (lectures != null) ? lectures.size() : 0 %> Sessions Today
            </span>
        </div>
    </header>

    <%
        String msg = request.getParameter("msg");
        if ("already".equals(msg)) {
    %>
        <div class="alert alert-warning alert-dismissible fade show rounded-4 border-warning-subtle shadow-sm d-flex align-items-center p-3 mb-4" role="alert">
            <div class="fs-2 text-warning me-3"><i class="fa-solid fa-circle-exclamation"></i></div>
            <div>
                <h6 class="fw-bold mb-1 text-dark">Quick Note!</h6>
                <div class="small text-muted">You've already marked your attendance for this lecture.</div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        } else if ("done".equals(msg)) {
    %>
        <div class="alert alert-success alert-dismissible fade show rounded-4 border-success-subtle shadow-sm d-flex align-items-center p-3 mb-4" role="alert">
            <div class="fs-2 text-success me-3"><i class="fa-solid fa-circle-check"></i></div>
            <div>
                <h6 class="fw-bold mb-1 text-dark">Success!</h6>
                <div class="small text-muted">Attendance recorded. Have a productive learning session!</div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        }
    %>

    <% if (lectures == null || lectures.isEmpty()) { %>
        <div class="empty-state">
            <div class="bg-light d-inline-block p-4 rounded-circle mb-4 text-muted">
                <i class="fa-solid fa-calendar-check fs-1"></i>
            </div>
            <h4 class="fw-bold">All caught up!</h4>
            <p class="text-muted">No lectures are currently scheduled for your courses.</p>
        </div>
    <% } else { %>
        <div class="schedule-card">
            <div class="table-responsive">
                <table class="table table-agenda align-middle">
                    <thead>
                        <tr>
                            <th width="40%">Course & Session</th>
                            <th width="15%">Date</th>
                            <th width="25%">Timing</th>
                            <th width="20%" class="text-end">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, Object> lec : lectures) { %>
                        <tr>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="bg-indigo bg-opacity-10 p-3 rounded-4 text-primary" style="background: #eef2ff;">
                                        <i class="fa-solid fa-book-open-reader"></i>
                                    </div>
                                    <div class="course-name"><%= lec.get("course_name") %></div>
                                </div>
                            </td>
                            <td class="text-muted fw-600">
                                <i class="fa-regular fa-calendar-alt me-1 opacity-50"></i> <%= lec.get("date") %>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="time-badge"><%= lec.get("start") %></span>
                                    <span class="text-muted small">→</span>
                                    <span class="time-badge"><%= lec.get("end") %></span>
                                </div>
                            </td>
                            <td class="text-end">
                                <form action="../../attend" method="post" class="m-0">
                                    <input type="hidden" name="session_id" value="<%= lec.get("session_id") %>">
                                    <button type="submit" class="btn-attend shadow-sm">
                                        Mark Attendance
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
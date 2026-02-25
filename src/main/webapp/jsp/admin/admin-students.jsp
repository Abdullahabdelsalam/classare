<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.classare.model.Student" %>
<%@ page import="com.classare.model.User" %>

<%
    // Security Check
    User adminUser = (User) session.getAttribute("user");
    if(adminUser == null || !adminUser.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Student> list = (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Student Directory | Classare Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --bg: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg); color: #1e293b; }
        .main-wrapper { padding: 2.5rem; }

        .student-card {
            background: white; border-radius: 20px; border: none;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); padding: 1.5rem;
        }

        .search-bar {
            background: white; border-radius: 15px; border: 1px solid #e2e8f0;
            padding: 10px 20px; display: flex; align-items: center; gap: 10px;
            max-width: 400px; margin-bottom: 2rem;
        }

        .search-bar input { border: none; outline: none; width: 100%; font-size: 0.9rem; }

        .status-pill {
            padding: 4px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 700;
        }
        .status-active { background: #dcfce7; color: #166534; }
        .status-inactive { background: #fee2e2; color: #991b1b; }

        .student-avatar {
            width: 35px; height: 35px; background: #f1f5f9;
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; color: #64748b; font-size: 0.8rem;
        }

        .table-custom thead th {
            background: #f8fafc; text-transform: uppercase; font-size: 0.7rem;
            letter-spacing: 1px; font-weight: 800; color: #64748b; border: none; padding: 1rem;
        }
    </style>
</head>
<body>

<div class="main-wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-extrabold mb-1">Student Directory &#128101;</h3>
            <p class="text-muted small">Manage enrollment, academic levels, and account statuses.</p>
        </div>
        <div class="text-end">
            <span class="badge bg-dark rounded-pill px-3 py-2">Total: <%= (list != null) ? list.size() : 0 %> Students</span>
        </div>
    </div>

    <form method="get" action="students" class="search-bar shadow-sm">
        <i class="fa-solid fa-magnifying-glass text-muted"></i>
        <input type="text" name="search" placeholder="Search by Student ID, Name or Email..."
               value="<%= (request.getParameter("search") != null) ? request.getParameter("search") : "" %>">
        <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
    </form>

    <div class="student-card">
        <div class="table-responsive">
            <table class="table table-custom align-middle">
                <thead>
                    <tr>
                        <th width="10%">Student ID</th>
                        <th width="25%">Full Name / Info</th>
                        <th width="15%">Academic Level</th>
                        <th width="15%">Faculty</th>
                        <th width="10%">Status</th>
                        <th width="25%" class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (list != null && !list.isEmpty()) {
                        for (Student s : list) { %>
                        <tr>
                            <td><span class="fw-bold text-primary">#STU-<%= s.getId() %></span></td>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="student-avatar"><i class="fa-solid fa-user"></i></div>
                                    <div>
                                        <div class="fw-bold small text-dark">ID: <%= s.getPersonId() %></div>
                                        <div class="text-muted" style="font-size: 0.75rem;"> <%= s.getFullName() %> <br/>
                                        Registered User</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge bg-light text-dark border"><%= s.getLevelId() %></span></td>
                            <td><span class="text-muted small fw-600"><%= (s.getFacultyId() != null ? "Faculty " + s.getFacultyId() : "N/A") %></span></td>
                            <td>
                                <span class="status-pill <%= s.isActive() ? "status-active" : "status-inactive" %>">
                                    <%= s.isActive() ? "Active" : "Disabled" %>
                                </span>
                            </td>
                            <td class="text-end">
                                <form method="post" action="students" class="d-inline">
                                    <input type="hidden" name="id" value="<%= s.getId() %>">
                                    <input type="hidden" name="active" value="<%= s.isActive() %>">
                                    <input type="hidden" name="action" value="toggle">
                                    <button type="submit" class="btn btn-sm <%= s.isActive() ? "btn-outline-warning" : "btn-outline-success" %> rounded-pill px-3 me-1">
                                        <i class="fa-solid <%= s.isActive() ? "fa-user-slash" : "fa-user-check" %> me-1"></i>
                                        <%= s.isActive() ? "Disable" : "Enable" %>
                                    </button>
                                </form>

                                <form method="post" action="students" class="d-inline" onsubmit="return confirm('Permanently delete this student? This action cannot be undone.');">
                                    <input type="hidden" name="id" value="<%= s.getId() %>">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="6" class="text-center p-5 text-muted">No students found matching your criteria.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
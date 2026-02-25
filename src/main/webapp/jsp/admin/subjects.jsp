<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.classare.model.Subject" %>
<%@ page import="com.classare.model.Level" %>
<%@ page import="com.classare.model.User" %>

<%
    User adminUser = (User) session.getAttribute("user");
    if(adminUser == null || !adminUser.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
    List<Level> levels = (List<Level>) request.getAttribute("levels");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Manage Subjects | Classare Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --bg: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg); color: #1e293b; }
        .main-wrapper { padding: 2.5rem; }

        .subject-card {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            padding: 1.5rem;
        }

        .badge-stage { background: #eef2ff; color: #4338ca; border: 1px solid #c7d2fe; font-size: 0.7rem; font-weight: 700; }
        .badge-level { background: #f0fdf4; color: #15803d; border: 1px solid #bbf7d0; font-size: 0.7rem; font-weight: 700; }

        .btn-add-subject {
            background: #0f172a;
            color: white;
            border-radius: 12px;
            font-weight: 700;
            padding: 0.6rem 1.5rem;
            transition: 0.3s;
        }

        .table-custom thead th {
            background: #f8fafc;
            text-transform: uppercase;
            font-size: 0.7rem;
            letter-spacing: 1px;
            font-weight: 800;
            color: #64748b;
            padding: 1rem;
        }

        .subject-name-cell { font-weight: 700; color: #1e293b; font-size: 0.95rem; }
    </style>
</head>
<body>

<div class="main-wrapper">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h3 class="fw-extrabold mb-1">Curriculum Subjects &#128218;</h3>
            <p class="text-muted small mb-0">Organize and assign academic subjects to grade levels.</p>
        </div>
        <button class="btn btn-add-subject shadow-sm" data-bs-toggle="collapse" data-bs-target="#addSubjectForm">
            <i class="fa-solid fa-plus-circle me-2"></i> Create New Subject
        </button>
    </div>

    <div class="collapse mb-4" id="addSubjectForm">
        <div class="subject-card border-start border-4 border-indigo" style="border-left-color: var(--accent) !important;">
            <h6 class="fw-bold mb-3">Define New Subject</h6>
            <form action="subjects" method="post" class="row g-3">
                <input type="hidden" name="action" value="create">
                <div class="col-md-5">
                    <label class="form-label small fw-bold">Subject Name</label>
                    <input type="text" name="name" class="form-control" placeholder="e.g. Advanced Mathematics" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Target Grade Level</label>
                    <select name="levelId" class="form-select" required>
                        <option value="" disabled selected>Choose Level...</option>
                        <% if(levels != null) { for (Level l : levels) { %>
                            <option value="<%= l.getId() %>">
                                <%= l.getStage().getName() %> &raquo; <%= l.getName() %>
                            </option>
                        <% } } %>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button class="btn btn-primary w-100 fw-bold py-2">Add to Curriculum</button>
                </div>
            </form>
        </div>
    </div>

    <div class="subject-card">
        <div class="table-responsive">
            <table class="table align-middle table-hover">
                <thead>
                    <tr>
                        <th width="8%">ID</th>
                        <th width="27%">Subject Name</th>
                        <th width="20%">Grade Level</th>
                        <th width="15%">Academic Stage</th>
                        <th width="30%" class="text-end">Controls</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(subjects != null && !subjects.isEmpty()) { for (Subject s : subjects) { %>
                    <tr>
                        <td><span class="text-muted small fw-bold">#SBJ-<%= s.getId() %></span></td>
                        <td><span class="subject-name-cell"><%= s.getName() %></span></td>
                        <td><span class="badge badge-level"><%= s.getLevel().getName() %></span></td>
                        <td><span class="badge badge-stage"><%= s.getLevel().getStage().getName() %></span></td>
                        <td class="text-end">
                            <form action="subjects" method="post" class="d-inline-block me-1">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <div class="input-group input-group-sm">
                                    <input type="text" name="name" value="<%= s.getName() %>" class="form-control border-end-0" style="width: 130px;">
                                    <select name="levelId" class="form-select border-start-0" style="width: 120px; font-size: 0.75rem;">
                                        <% for (Level l : levels) { %>
                                            <option value="<%= l.getId() %>" <%= (l.getId() == s.getLevel().getId()) ? "selected" : "" %>>
                                                <%= l.getName() %>
                                            </option>
                                        <% } %>
                                    </select>
                                    <button class="btn btn-warning text-white"><i class="fa-solid fa-check"></i></button>
                                </div>
                            </form>

                            <form action="subjects" method="post" class="d-inline" onsubmit="return confirm('Delete this subject? This will affect linked courses and exams.');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <button class="btn btn-sm btn-outline-danger border-0 rounded-circle"><i class="fa-solid fa-trash-can"></i></button>
                            </form>
                        </td>
                    </tr>
                    <% } } else { %>
                        <tr><td colspan="5" class="text-center p-5 text-muted">No subjects found. Use the button above to add one.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
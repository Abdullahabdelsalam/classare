<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.classare.model.Level" %>
<%@ page import="com.classare.model.Stage" %>
<%@ page import="com.classare.model.User" %>

<%
    // Security Check
    User adminUser = (User) session.getAttribute("user");
    if(adminUser == null || !adminUser.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Level> levels = (List<Level>) request.getAttribute("levels");
    List<Stage> stages = (List<Stage>) request.getAttribute("stages");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Manage Levels | Classare Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --bg: #f1f5f9; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg); color: #1e293b; }
        .main-wrapper { padding: 2.5rem; }
        .data-card { background: white; border-radius: 20px; border: none; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); padding: 1.5rem; }
        .btn-add { background: var(--accent); color: white; border-radius: 12px; font-weight: 700; padding: 0.6rem 1.5rem; }
        .stage-tag { font-size: 0.7rem; background: #e0e7ff; color: #4338ca; padding: 4px 10px; border-radius: 20px; font-weight: 700; }
        .level-name { font-weight: 600; color: #1e293b; }
    </style>
</head>
<body>

<div class="main-wrapper">
    <div class="page-header d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-extrabold mb-1">Grade Levels &#128200;</h3>
            <p class="text-muted small">Manage specific school years and academic grades.</p>
        </div>
        <button class="btn btn-add" data-bs-toggle="collapse" data-bs-target="#addLevelForm">
            <i class="fa-solid fa-plus me-2"></i> Create New Level
        </button>
    </div>

    <div class="collapse mb-4" id="addLevelForm">
        <div class="data-card border-start border-4 border-primary">
            <form action="levels" method="post" class="row g-3">
                <input type="hidden" name="action" value="create">
                <div class="col-md-5">
                    <label class="form-label small fw-bold">Level Name</label>
                    <input type="text" name="name" class="form-control" placeholder="e.g. Grade 10" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Assign to Stage</label>
                    <select name="stageId" class="form-select" required>
                        <option value="" disabled selected>Select Stage...</option>
                        <% if(stages != null) { for(Stage s : stages) { %>
                            <option value="<%= s.getId() %>"><%= s.getName() %></option>
                        <% } } %>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button class="btn btn-primary w-100 fw-bold py-2">Save Level</button>
                </div>
            </form>
        </div>
    </div>

    <div class="data-card">
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr class="text-muted small">
                        <th width="10%">ID</th>
                        <th width="30%">Level Name</th>
                        <th width="30%">Parent Stage</th>
                        <th width="30%" class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(levels != null && !levels.isEmpty()) { for(Level l : levels) { %>
                    <tr>
                        <td><span class="text-muted fw-bold">#<%= l.getId() %></span></td>
                        <td><span class="level-name"><%= l.getName() %></span></td>
                        <td>
                            <span class="stage-tag">
                                <i class="fa-solid fa-layer-group me-1"></i>
                                <%= (l.getStage() != null) ? l.getStage().getName() : "Unassigned" %>
                            </span>
                        </td>
                        <td class="text-end">
                            <form action="levels" method="post" class="d-inline-block me-2">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= l.getId() %>">
                                <div class="input-group input-group-sm">
                                    <input type="text" name="name" value="<%= l.getName() %>" class="form-control">
                                    <button class="btn btn-success"><i class="fa-solid fa-check"></i></button>
                                </div>
                            </form>

                            <form action="levels" method="post" class="d-inline" onsubmit="return confirm('Delete this level?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= l.getId() %>">
                                <button class="btn btn-sm btn-outline-danger border-0"><i class="fa-solid fa-trash"></i></button>
                            </form>
                        </td>
                    </tr>
                    <% } } else { %>
                        <tr><td colspan="4" class="text-center p-5 text-muted">No levels created yet.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
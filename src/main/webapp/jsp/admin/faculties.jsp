<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.classare.model.Faculty" %>
<%@ page import="com.classare.model.User" %>

<%
    // Security Check
    User adminUser = (User) session.getAttribute("user");
    if(adminUser == null || !adminUser.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // جلب البيانات
    List<Faculty> faculties = (List<Faculty>) request.getAttribute("faculties");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Manage Faculties | Classare Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --admin-primary: #0f172a; --accent: #6366f1; --bg: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg); color: #1e293b; }
        .main-wrapper { padding: 2.5rem; }

        .faculty-card {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            padding: 1.5rem;
        }

        .faculty-icon {
            width: 48px;
            height: 48px;
            background: #f1f5f9;
            color: var(--accent);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-right: 1rem;
        }

        .btn-create {
            background: var(--admin-primary);
            color: white;
            border-radius: 12px;
            font-weight: 700;
            padding: 0.6rem 1.5rem;
            transition: 0.3s;
        }

        .btn-create:hover { background: #1e293b; color: white; transform: translateY(-2px); }

        .table-custom thead th {
            background: #f8fafc;
            text-transform: uppercase;
            font-size: 0.7rem;
            letter-spacing: 1px;
            font-weight: 800;
            color: #64748b;
            border: none;
            padding: 1rem;
        }
    </style>
</head>
<body>

<div class="main-wrapper">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h3 class="fw-extrabold mb-1">Higher Education Faculties &#127891;</h3>
            <p class="text-muted small mb-0">Manage university departments and academic faculties.</p>
        </div>
        <button class="btn btn-create shadow-sm" data-bs-toggle="modal" data-bs-target="#addFacultyModal">
            <i class="fa-solid fa-building-columns me-2"></i> Add New Faculty
        </button>
    </div>

    <div class="faculty-card">
        <div class="table-responsive">
            <table class="table table-custom align-middle mb-0">
                <thead>
                    <tr>
                        <th width="15%">Faculty ID</th>
                        <th width="45%">Faculty Name</th>
                        <th width="40%" class="text-end">Actions & Controls</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(faculties != null && !faculties.isEmpty()) {
                        for (Faculty f : faculties) { %>
                        <tr>
                            <td><span class="fw-bold text-primary">#FAC-<%= f.getId() %></span></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="faculty-icon"><i class="fa-solid fa-graduation-cap"></i></div>
                                    <span class="fw-bold text-dark"><%= f.getName() %></span>
                                </div>
                            </td>
                            <td class="text-end">
                                <form action="faculties" method="post" class="d-inline-block">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= f.getId() %>">
                                    <div class="input-group input-group-sm" style="width: 250px;">
                                        <input type="text" name="name" value="<%= f.getName() %>" class="form-control border-end-0 rounded-start-pill">
                                        <button class="btn btn-success rounded-end-pill px-3"><i class="fa-solid fa-save"></i></button>
                                    </div>
                                </form>

                                <form action="faculties" method="post" class="d-inline ms-2" onsubmit="return confirm('Delete this faculty? All linked courses might be affected.');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= f.getId() %>">
                                    <button class="btn btn-sm btn-outline-danger rounded-circle" style="width:32px; height:32px; padding:0;">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="3" class="text-center p-5 text-muted">No faculties registered yet.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="addFacultyModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow" style="border-radius: 24px;">
            <div class="modal-header border-0 p-4 pb-0">
                <h5 class="fw-bold">Register New Faculty</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <form action="faculties" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-4">
                        <label class="form-label small fw-bold text-muted">FACULTY NAME</label>
                        <input type="text" name="name" class="form-control form-control-lg bg-light" placeholder="e.g. Faculty of Engineering" required>
                    </div>
                    <button class="btn btn-primary w-100 py-3 fw-bold rounded-4 shadow-sm">Save Faculty Details</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
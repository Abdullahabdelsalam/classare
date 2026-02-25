<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.classare.model.Stage" %>
<%@ page import="com.classare.model.User" %>

<%
    User adminUser = (User) session.getAttribute("user");
    if(adminUser == null || !adminUser.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }
    List<Stage> stages = (List<Stage>) request.getAttribute("stages");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Manage Stages | Classare Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --bg: #f1f5f9; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg); color: #1e293b; }

        .main-wrapper { padding: 2.5rem; }
        .page-header { margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; }

        .data-card {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            padding: 1.5rem;
        }

        .table thead th {
            background: #f8fafc;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            color: #64748b;
            border-bottom: 2px solid #edf2f7;
            padding: 1rem;
        }

        .table tbody td { padding: 1rem; vertical-align: middle; }

        .btn-add {
            background: var(--accent);
            color: white;
            border-radius: 12px;
            font-weight: 700;
            padding: 0.6rem 1.5rem;
            transition: 0.3s;
        }

        .form-inline-edit {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 700;
            background: #eef2ff;
            color: var(--accent);
        }
    </style>
</head>
<body>

<div class="main-wrapper">
    <div class="page-header">
        <div>
            <h3 class="fw-extrabold mb-1">Academic Stages &#127891;</h3>
            <p class="text-muted small">Define and manage educational levels for Classare ecosystem.</p>
        </div>
        <button class="btn btn-add" data-bs-toggle="collapse" data-bs-target="#addStageForm">
            <i class="fa-solid fa-plus me-2"></i> Create New Stage
        </button>
    </div>

    <div class="collapse mb-4" id="addStageForm">
        <div class="data-card border-start border-4 border-primary">
            <h6 class="fw-bold mb-3">Add New Academic Stage</h6>
            <form action="stages" method="post" class="row g-3">
                <input type="hidden" name="action" value="add">
                <div class="col-md-8">
                    <input type="text" name="name" class="form-control form-control-lg"
                           placeholder="e.g. Primary School, Secondary, University" required>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-primary btn-lg w-100 fw-bold">Save Stage</button>
                </div>
            </form>
        </div>
    </div>

    <div class="data-card">
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr>
                        <th width="10%">ID</th>
                        <th width="40%">Stage Name</th>
                        <th width="50%" class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(stages != null) { for(Stage s : stages) { %>
                    <tr>
                        <td><span class="text-muted fw-bold">#<%= s.getId() %></span></td>
                        <td>
                            <span class="status-badge"><%= s.getName() %></span>
                        </td>
                        <td class="text-end">
                            <form action="stages" method="post" class="d-inline-block me-2">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <div class="input-group input-group-sm">
                                    <input type="text" name="name" value="<%= s.getName() %>"
                                           class="form-control rounded-start-pill" style="width:160px;">
                                    <button class="btn btn-warning text-white"><i class="fa-solid fa-pen"></i></button>
                                </div>
                            </form>

                            <form action="stages" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this stage?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <button class="btn btn-sm btn-outline-danger rounded-circle" style="width:32px; height:32px; padding:0;">
                                    <i class="fa-solid fa-trash-can"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } } else { %>
                        <tr><td colspan="3" class="text-center text-muted p-5">No stages found. Start by adding one!</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
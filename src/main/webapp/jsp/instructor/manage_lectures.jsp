<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.classare.model.*" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("INSTRUCTOR")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Map<String, Object>> lectures = (List<Map<String, Object>>) request.getAttribute("lectures");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Lectures | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --instructor-primary: #4f46e5; --bg-light: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-light); color: #1e293b; }

        .main-container { padding: 3rem 1.5rem; max-width: 1100px; margin: 0 auto; }

        /* Header Styling */
        .page-title { font-weight: 800; font-size: 2rem; color: #0f172a; letter-spacing: -1px; }

        .btn-add {
            background: var(--instructor-primary);
            color: white;
            border-radius: 12px;
            padding: 10px 20px;
            font-weight: 700;
            border: none;
            transition: 0.3s;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.2);
        }
        .btn-add:hover { background: #4338ca; color: white; transform: translateY(-2px); }

        /* Table Card */
        .table-card {
            background: white;
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.02);
            overflow: hidden;
            margin-top: 1.5rem;
        }

        .table-custom { margin-bottom: 0; }
        .table-custom thead th {
            background: #f8fafc;
            color: #64748b;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .table-custom tbody td {
            padding: 1.2rem 1.5rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }

        /* Subject Badge */
        .subject-info { display: flex; align-items: center; gap: 12px; }
        .subject-icon {
            width: 40px;
            height: 40px;
            background: #eef2ff;
            color: var(--instructor-primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
        }
        .subject-name { font-weight: 700; color: #0f172a; }

        /* Time & Date */
        .time-badge {
            background: #f1f5f9;
            color: #475569;
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        /* Action Buttons */
        .btn-action {
            width: 35px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            transition: 0.2s;
            text-decoration: none;
        }
        .btn-edit { background: #fffbeb; color: #d97706; border: 1px solid #fef3c7; }
        .btn-edit:hover { background: #fef3c7; }
        .btn-delete { background: #fef2f2; color: #dc2626; border: 1px solid #fee2e2; }
        .btn-delete:hover { background: #fee2e2; }

        .empty-state {
            background: white; border-radius: 24px; padding: 4rem;
            text-align: center; border: 2px dashed #cbd5e1;
        }
    </style>
</head>
<body>

<div class="main-container">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="page-title">Lecture Management 🎓</h2>
            <p class="text-muted mb-0">Schedule, update, or remove your academic sessions.</p>
        </div>
        <a href="add_lecture.jsp" class="btn btn-add">
            <i class="fa-solid fa-plus me-2"></i> New Lecture
        </a>
    </div>

    <% if (lectures == null || lectures.isEmpty()) { %>
        <div class="empty-state">
            <i class="fa-solid fa-calendar-xmark text-muted fs-1 mb-3"></i>
            <h5 class="fw-bold">No lectures scheduled</h5>
            <p class="text-muted">Start by adding a new lecture to your calendar.</p>
        </div>
    <% } else { %>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-custom align-middle">
                <thead>
                    <tr>
                        <th width="35%">Subject / Course</th>
                        <th width="20%">Date</th>
                        <th width="25%">Schedule</th>
                        <th width="20%" class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> l : lectures) { %>
                    <tr>
                        <td>
                            <div class="subject-info">
                                <div class="subject-icon">
                                    <i class="fa-solid fa-chalkboard"></i>
                                </div>
                                <div class="subject-name text-truncate"><%= l.get("subject") %></div>
                            </div>
                        </td>
                        <td>
                            <span class="text-muted fw-600">
                                <i class="fa-regular fa-calendar me-1 opacity-50"></i> <%= l.get("date") %>
                            </span>
                        </td>
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <span class="time-badge"><%= l.get("start") %></span>
                                <span class="text-muted small">to</span>
                                <span class="time-badge"><%= l.get("end") %></span>
                            </div>
                        </td>
                        <td class="text-end">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="edit_lecture.jsp?id=<%= l.get("id") %>"
                                   class="btn-action btn-edit shadow-sm" title="Edit Lecture">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <a href="../../delete-lecture?id=<%= l.get("id") %>"
                                   class="btn-action btn-delete shadow-sm"
                                   title="Delete Lecture"
                                   onclick="return confirm('Are you sure you want to delete this lecture?')">
                                    <i class="fa-solid fa-trash-can"></i>
                                </a>
                            </div>
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
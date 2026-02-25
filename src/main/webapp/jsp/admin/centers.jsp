<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.classare.model.Center" %>
<%@ page import="com.classare.model.User" %>

<%
    // Security Check
    User adminUser = (User) session.getAttribute("user");
    if(adminUser == null || !adminUser.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Center> centers = (List<Center>) request.getAttribute("centers");
    String editId = request.getParameter("editId");
    Center editCenter = null;

    if (editId != null && centers != null) {
        for (Center c : centers) {
            if (c.getId() == Integer.parseInt(editId)) {
                editCenter = c;
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Centers Management | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --bg: #f8fafc; --dark: #0f172a; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg); color: #1e293b; }
        .main-wrapper { padding: 2.5rem; }

        /* Form Card Styling */
        .form-card {
            background: white; border-radius: 24px; border: none;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.05); padding: 2rem;
            margin-bottom: 3rem; border-top: 5px solid var(--accent);
        }

        /* Table Styling */
        .data-card {
            background: white; border-radius: 20px; border: none;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); padding: 1.5rem;
        }

        .table thead th {
            background: #f8fafc; text-transform: uppercase; font-size: 0.7rem;
            letter-spacing: 1px; font-weight: 800; color: #64748b; border: none;
        }

        .btn-action { width: 35px; height: 35px; border-radius: 10px; display: inline-flex; align-items: center; justify-content: center; transition: 0.3s; }
        .map-badge { background: #eff6ff; color: #2563eb; padding: 6px 12px; border-radius: 12px; font-weight: 700; font-size: 0.8rem; text-decoration: none; }
        .map-badge:hover { background: #2563eb; color: white; }
    </style>
</head>
<body>

<div class="main-wrapper">
    <div class="mb-5">
        <h3 class="fw-extrabold mb-1">Educational Centers &#128205;</h3>
        <p class="text-muted small">Manage physical locations, contact info, and Google Maps integration.</p>
    </div>

    <div class="form-card">
        <h5 class="fw-bold mb-4">
            <%= (editCenter != null ? "<i class='fa-solid fa-pen-to-square me-2 text-warning'></i> Update Center" : "<i class='fa-solid fa-plus-circle me-2 text-primary'></i> Register New Center") %>
        </h5>

        <form action="centers" method="post" class="row g-4">
            <% if (editCenter != null) { %>
                <input type="hidden" name="id" value="<%= editCenter.getId() %>">
                <input type="hidden" name="action" value="update">
            <% } else { %>
                <input type="hidden" name="action" value="create">
            <% } %>

            <div class="col-md-3">
                <label class="form-label small fw-bold text-muted text-uppercase">Center Name</label>
                <input type="text" name="name" class="form-control bg-light" placeholder="e.g. Downtown Branch"
                       value="<%= (editCenter != null ? editCenter.getName() : "") %>" required>
            </div>

            <div class="col-md-3">
                <label class="form-label small fw-bold text-muted text-uppercase">Physical Address</label>
                <input type="text" name="address" class="form-control bg-light" placeholder="Street name, City"
                       value="<%= (editCenter != null ? editCenter.getAddress() : "") %>">
            </div>

            <div class="col-md-3">
                <label class="form-label small fw-bold text-muted text-uppercase">Contact Phone</label>
                <input type="text" name="phone" class="form-control bg-light" placeholder="+20 123..."
                       value="<%= (editCenter != null ? editCenter.getPhone() : "") %>">
            </div>

            <div class="col-md-3">
                <label class="form-label small fw-bold text-muted text-uppercase">Google Maps URL</label>
                <input type="text" name="location" class="form-control bg-light" placeholder="https://goo.gl/maps/..."
                       value="<%= (editCenter != null ? editCenter.getLocation() : "") %>">
            </div>

            <div class="col-12 mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-dark px-4 fw-bold rounded-pill">
                    <%= (editCenter != null ? "Save Changes" : "Register Center") %>
                </button>
                <% if (editCenter != null) { %>
                    <a href="centers" class="btn btn-outline-secondary px-4 rounded-pill fw-bold">Cancel Edit</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="data-card">
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr>
                        <th width="5%">ID</th>
                        <th width="20%">Center Name</th>
                        <th width="25%">Address</th>
                        <th width="15%">Phone</th>
                        <th width="15%">Map View</th>
                        <th width="20%" class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (centers != null && !centers.isEmpty()) {
                        for (Center c : centers) { %>
                        <tr>
                            <td class="text-muted small fw-bold">#<%= c.getId() %></td>
                            <td><span class="fw-bold text-dark"><%= c.getName() %></span></td>
                            <td><span class="text-muted small"><i class="fa-solid fa-location-dot me-1"></i> <%= c.getAddress() %></span></td>
                            <td><span class="fw-600"><i class="fa-solid fa-phone-flip me-1 small opacity-50"></i> <%= c.getPhone() %></span></td>
                            <td>
                                <% if (c.getLocation() != null && !c.getLocation().isEmpty()) { %>
                                    <a href="<%= c.getLocation() %>" target="_blank" class="map-badge">
                                        <i class="fa-solid fa-map-location-dot me-1"></i> Live Map
                                    </a>
                                <% } else { %>
                                    <span class="text-muted small">N/A</span>
                                <% } %>
                            </td>
                            <td class="text-end">
                                <a href="centers?editId=<%= c.getId() %>" class="btn-action bg-warning text-white me-1 text-decoration-none">
                                    <i class="fa-solid fa-pen small"></i>
                                </a>
                                <a href="centers?action=delete&id=<%= c.getId() %>"
                                   class="btn-action bg-danger text-white text-decoration-none"
                                   onclick="return confirm('Deleting this center might affect associated schedules. Continue?')">
                                    <i class="fa-solid fa-trash-can small"></i>
                                </a>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="6" class="text-center p-5 text-muted">No centers registered yet.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.classare.model.*" %>

<%

    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("INSTRUCTOR")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Map<String, Object>> payments = (List<Map<String, Object>>) request.getAttribute("payments");

    double totalEarnings = 0;
    if (payments != null) {
        for (Map<String, Object> p : payments) {
            if ("PAID".equals(p.get("status"))) {
                totalEarnings += Double.parseDouble(p.get("amount").toString());
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financial Overview | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --instructor-primary: #4f46e5; --bg-light: #f8fafc; --success: #10b981; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-light); color: #1e293b; }

        .main-container { padding: 3rem 1.5rem; max-width: 1100px; margin: 0 auto; }

        .page-title { font-weight: 800; font-size: 2.2rem; color: #0f172a; letter-spacing: -1px; }

        /* Stats Cards */
        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02);
        }
        .stat-icon {
            width: 48px; height: 48px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.25rem;
        }

        /* Table Styling */
        .billing-card {
            background: white;
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.04);
        }
        .table-billing thead th {
            background: #f8fafc;
            color: #64748b;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .table-billing tbody td { padding: 1.2rem 1.5rem; vertical-align: middle; border-bottom: 1px solid #f1f5f9; }

        /* Status Pills */
        .badge-paid { background: #ecfdf5; color: #10b981; border: 1px solid #a7f3d0; padding: 6px 12px; border-radius: 10px; font-weight: 700; font-size: 0.75rem; }
        .badge-pending { background: #fffbeb; color: #f59e0b; border: 1px solid #fde68a; padding: 6px 12px; border-radius: 10px; font-weight: 700; font-size: 0.75rem; }

        .student-name { font-weight: 700; color: #0f172a; }
        .course-label { font-size: 0.85rem; color: #64748b; }
        .amount-highlight { font-weight: 800; color: var(--instructor-primary); }
    </style>
</head>
<body>

<div class="main-container">

    <header class="mb-5 d-flex justify-content-between align-items-end">
        <div>
            <h1 class="page-title">Earnings Report 💰</h1>
            <p class="text-muted mb-0">Track student payments and revenue for your courses.</p>
        </div>
        <div class="text-end">
            <a href="manage_courses.jsp" class="btn btn-outline-secondary rounded-pill px-4 fw-bold small">
                <i class="fa-solid fa-arrow-left me-2"></i> Dashboard
            </a>
        </div>
    </header>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                    <i class="fa-solid fa-wallet"></i>
                </div>
                <div>
                    <div class="small text-muted fw-bold">Total Collected</div>
                    <div class="fs-4 fw-800">$<%= String.format("%.2f", totalEarnings) %></div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon bg-success bg-opacity-10 text-success">
                    <i class="fa-solid fa-users"></i>
                </div>
                <div>
                    <div class="small text-muted fw-bold">Paying Students</div>
                    <div class="fs-4 fw-800"><%= (payments != null) ? payments.size() : 0 %></div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card border-primary bg-primary bg-opacity-10">
                <div class="stat-icon bg-white text-primary shadow-sm">
                    <i class="fa-solid fa-chart-line"></i>
                </div>
                <div>
                    <div class="small text-primary fw-bold">Revenue Status</div>
                    <div class="fs-4 fw-800 text-primary">Active</div>
                </div>
            </div>
        </div>
    </div>

    <% if (payments == null || payments.isEmpty()) { %>
        <div class="text-center p-5 bg-white rounded-5 border border-dashed">
            <i class="fa-solid fa-magnifying-glass-dollar text-muted fs-1 mb-3"></i>
            <h5 class="fw-bold">No transactions yet</h5>
            <p class="text-muted">Once students start enrolling, their payment details will appear here.</p>
        </div>
    <% } else { %>

    <div class="billing-card">
        <div class="table-responsive">
            <table class="table table-billing align-middle mb-0">
                <thead>
                    <tr>
                        <th>Student Details</th>
                        <th>Course</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th class="text-end">Date</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> p : payments) { %>
                    <tr>
                        <td>
                            <div class="d-flex align-items-center gap-3">
                                <div class="avatar-sm bg-light rounded-circle p-2 text-center" style="width: 35px">
                                    <i class="fa-solid fa-user text-muted small"></i>
                                </div>
                                <span class="student-name"><%= p.get("student") %></span>
                            </div>
                        </td>
                        <td>
                            <span class="course-label"><%= p.get("course") %></span>
                        </td>
                        <td>
                            <span class="amount-highlight">$<%= p.get("amount") %></span>
                        </td>
                        <td>
                            <% if ("PAID".equals(p.get("status"))) { %>
                                <span class="badge-paid">Paid</span>
                            <% } else { %>
                                <span class="badge-pending">Pending</span>
                            <% } %>
                        </td>
                        <td class="text-end text-muted small fw-bold">
                            <%= p.get("date") %>
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
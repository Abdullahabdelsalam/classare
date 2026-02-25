<%@ page import="com.classare.model.User" %>
<%@ page import="com.classare.model.Person" %>
<%
    // Security Check: Verify Admin Access
    User user = (User) session.getAttribute("user");
    if(user == null || !user.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }
    Person person = user.getPerson();
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Control Center | Classare Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --admin-primary: #0f172a;
            --admin-accent: #6366f1;
            --sidebar-bg: #1e293b;
            --content-bg: #f1f5f9;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--content-bg);
            margin: 0;
        }

        /* Enhanced Sidebar */
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            color: #94a3b8;
            height: 100vh;
            position: fixed;
            transition: 0.3s;
            overflow-y: auto;
            border-right: 1px solid rgba(255,255,255,0.05);
        }

        .sidebar .brand-area {
            padding: 2rem 1.5rem;
            color: white;
            font-weight: 800;
            font-size: 1.4rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 1rem;
        }

        .sidebar .nav-label {
            font-size: 0.7rem;
            font-weight: 800;
            text-transform: uppercase;
            padding: 1.5rem 1.5rem 0.5rem;
            color: #64748b;
            letter-spacing: 1px;
        }

        .sidebar a {
            color: #cbd5e1;
            padding: 12px 20px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: 0.2s;
        }

        .sidebar a:hover {
            background: rgba(255,255,255,0.05);
            color: white;
        }

        .sidebar a.active {
            background: var(--admin-accent);
            color: white;
            border-radius: 0 50px 50px 0;
            margin-right: 15px;
        }

        /* Main Content Area */
        .content {
            margin-left: 260px;
            padding: 2rem 3rem;
        }

        /* Admin Info Bar */
        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            background: white;
            padding: 1rem 2rem;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }

        /* Control Cards */
        .summary-card {
            background: white;
            padding: 1.5rem;
            border-radius: 20px;
            border: none;
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }

        .summary-card:hover {
            transform: translateY(-5px);
        }

        .icon-circle {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

        .bg-soft-indigo { background: #eef2ff; color: #6366f1; }
        .bg-soft-green { background: #ecfdf5; color: #10b981; }
        .bg-soft-orange { background: #fff7ed; color: #f97316; }
        .bg-soft-blue { background: #f0f9ff; color: #0ea5e9; }

    </style>
</head>
<body>

<aside class="sidebar">
    <div class="brand-area">
        <i class="fa-solid fa-shield-halved me-2 text-primary"></i> Classare Admin
    </div>

    <div class="nav-label">Main Console</div>
    <a href="dashboard" class="active"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
    <a href="admin-register.jsp"><i class="fa-solid fa-user-plus"></i> Add New Admin</a>
    <a href="students"><i class="fa-solid fa-users-gear"></i> Manage Students</a>
    <a href="dashboard"><i class="fa-solid fa-user-shield"></i> Roles & Permissions</a>

    <div class="nav-label">System Lookups</div>
    <a href="stages"><i class="fa-solid fa-layer-group"></i> Academic Stages</a>
    <a href="levels"><i class="fa-solid fa-stairs"></i> Grade Levels</a>
    <a href="faculties"><i class="fa-solid fa-building-columns"></i> Faculties</a>
    <a href="subjects"><i class="fa-solid fa-book-bookmark"></i> Subjects</a>
    <a href="centers"><i class="fa-solid fa-location-dot"></i> Centers</a>

    <div class="mt-auto pt-5">
        <a href="../logout" class="text-danger"><i class="fa-solid fa-right-from-bracket"></i> Sign Out</a>
    </div>
</aside>

<main class="content">

    <header class="admin-header">
        <h5 class="fw-bold mb-0">System Control Overview</h5>
        <div class="d-flex align-items-center gap-3">
            <div class="text-end">
                <p class="mb-0 fw-bold small"><%= user.getPerson().getFirstName() %></p>
                <span class="badge bg-danger" style="font-size: 0.6rem;">Super Admin</span>
            </div>
            <div class="avatar bg-dark text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                <i class="fa-solid fa-user-tie"></i>
            </div>
        </div>
    </header>

    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="summary-card">
                <div class="icon-circle bg-soft-indigo"><i class="fa-solid fa-users"></i></div>
                <h6 class="text-muted fw-bold small mb-1">Total Centers</h6>
                <h3 class="fw-extrabold"><%= request.getAttribute("totalCenters") %></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="summary-card">
                <div class="icon-circle bg-soft-green"><i class="fa-solid fa-user-graduate"></i></div>
                <h6 class="text-muted fw-bold small mb-1">Total Students</h6>
                <h3 class="fw-extrabold"><%= request.getAttribute("totalStudents") %></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="summary-card">
                <div class="icon-circle bg-soft-orange"><i class="fa-solid fa-person-chalkboard"></i></div>
                <h6 class="text-muted fw-bold small mb-1">Total Instructors</h6>
                <h3 class="fw-extrabold"><%= request.getAttribute("totalInstructors") %></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="summary-card">
                <div class="icon-circle bg-soft-blue"><i class="fa-solid fa-scroll"></i></div>
                <h6 class="text-muted fw-bold small mb-1">Active Courses</h6>
                <h3 class="fw-extrabold"><%= request.getAttribute("activeCourses") %></h3>
            </div>
        </div>
    </div>

    <div class="bg-white p-5 rounded-4 shadow-sm text-center">
        <div class="mb-4 text-primary opacity-25">
            <i class="fa-solid fa-cubes-stacked fa-4x"></i>
        </div>
        <h4 class="fw-bold">Ready to manage Lookup Data?</h4>
        <p class="text-muted">Select a category from the sidebar to add, edit, or remove system configurations like Stages and Levels.</p>
        <div class="d-flex justify-content-center gap-2 mt-4">
            <a href="lookups" class="btn btn-primary px-4 rounded-pill">Manage Lookup</a>
            <a href="students" class="btn btn-outline-dark px-4 rounded-pill">Review Students Actives</a>
        </div>
    </div>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
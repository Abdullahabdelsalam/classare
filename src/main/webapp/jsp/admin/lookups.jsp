<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.classare.model.User" %>

<%

    User adminUser = (User) session.getAttribute("user");
    if(adminUser == null || !adminUser.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings | Classare Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #6366f1;
            --dark: #0f172a;
            --bg: #f8fafc;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            color: var(--dark);
        }

        .hub-header {
            padding: 3rem 0;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: white;
            border-radius: 0 0 40px 40px;
            margin-bottom: 3rem;
        }

        .lookup-card {
            background: white;
            border: none;
            border-radius: 24px;
            padding: 2rem;
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px -12px rgba(0,0,0,0.05);
        }

        .lookup-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px -12px rgba(99, 102, 241, 0.15);
        }

        .icon-box {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            transition: 0.3s;
        }

        .card-title { font-weight: 800; font-size: 1.25rem; margin-bottom: 0.5rem; }
        .card-text { color: #64748b; font-size: 0.9rem; line-height: 1.6; }

        .btn-open {
            background: #f1f5f9;
            color: var(--dark);
            border: none;
            border-radius: 12px;
            padding: 0.8rem;
            font-weight: 700;
            font-size: 0.9rem;
            margin-top: 1.5rem;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .lookup-card:hover .btn-open {
            background: var(--primary);
            color: white;
        }

        /* Colors for different sections */
        .bg-stages { background: #eef2ff; color: #6366f1; }
        .bg-levels { background: #f0fdf4; color: #22c55e; }
        .bg-faculties { background: #fff7ed; color: #f97316; }
        .bg-subjects { background: #f0f9ff; color: #0ea5e9; }
        .bg-centers { background: #fff1f2; color: #f43f5e; }

    </style>
</head>
<body>

<header class="hub-header shadow-lg">
    <div class="container text-center">
        <span class="badge bg-primary mb-3 px-3 py-2 rounded-pill">System Admin</span>
        <h1 class="fw-800">Classare Hub &#127919;</h1>
        <p class="opacity-75">Configure and manage all system lookup data in one place.</p>
    </div>
</header>

<div class="container">
    <div class="row g-4 justify-content-center">

        <div class="col-md-4">
            <div class="lookup-card shadow-sm">
                <div class="icon-box bg-stages"><i class="fa-solid fa-layer-group"></i></div>
                <h5 class="card-title">Academic Stages</h5>
                <p class="card-text">Define primary educational categories like School or University.</p>
                <a href="stages" class="btn-open">Manage Stages <i class="fa-solid fa-arrow-right small"></i></a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="lookup-card shadow-sm">
                <div class="icon-box bg-levels"><i class="fa-solid fa-stairs"></i></div>
                <h5 class="card-title">Grade Levels</h5>
                <p class="card-text">Configure specific grades (e.g., Year 1, Semester 2) under each stage.</p>
                <a href="levels" class="btn-open">Manage Levels <i class="fa-solid fa-arrow-right small"></i></a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="lookup-card shadow-sm">
                <div class="icon-box bg-faculties"><i class="fa-solid fa-building-columns"></i></div>
                <h5 class="card-title">Faculties</h5>
                <p class="card-text">Administer university departments and specialized colleges.</p>
                <a href="faculties" class="btn-open">Manage Faculties <i class="fa-solid fa-arrow-right small"></i></a>
            </div>
        </div>

        <div class="col-md-5">
            <div class="lookup-card shadow-sm">
                <div class="icon-box bg-subjects"><i class="fa-solid fa-book-open"></i></div>
                <h5 class="card-title">Curriculum Subjects</h5>
                <p class="card-text">Define the subjects and materials assigned to each grade level.</p>
                <a href="subjects" class="btn-open">Manage Subjects <i class="fa-solid fa-arrow-right small"></i></a>
            </div>
        </div>

        <div class="col-md-5">
            <div class="lookup-card shadow-sm">
                <div class="icon-box bg-centers"><i class="fa-solid fa-location-dot"></i></div>
                <h5 class="card-title">Physical Centers</h5>
                <p class="card-text">Add and edit training centers, branches, and their GPS locations.</p>
                <a href="centers" class="btn-open">Manage Centers <i class="fa-solid fa-arrow-right small"></i></a>
            </div>
        </div>

    </div>

    <div class="text-center mt-5 mb-5 pt-4">
        <a href="dashboard.jsp" class="text-muted text-decoration-none small">
            <i class="fa-solid fa-chevron-left me-1"></i> Return to Main Dashboard
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
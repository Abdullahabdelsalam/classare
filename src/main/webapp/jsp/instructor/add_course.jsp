<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.classare.model.*" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("INSTRUCTOR")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Course | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --instructor-primary: #4f46e5; --bg-light: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-light); color: #1e293b; }

        .form-container { max-width: 600px; margin: 4rem auto; }

        .back-link { color: #64748b; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: 0.3s; }
        .back-link:hover { color: var(--instructor-primary); }

        .form-card {
            background: white;
            border-radius: 30px;
            border: 1px solid #e2e8f0;
            padding: 2.5rem;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.03);
        }

        .header-icon {
            width: 60px;
            height: 60px;
            background: #eef2ff;
            color: var(--instructor-primary);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-label { font-weight: 700; color: #334155; font-size: 0.9rem; margin-bottom: 0.6rem; }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.75rem 1rem;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            transition: 0.3s;
        }

        .form-control:focus, .form-select:focus {
            background-color: white;
            border-color: var(--instructor-primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .input-group-text {
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 12px 0 0 12px;
            color: #64748b;
        }

        .btn-create {
            background: var(--instructor-primary);
            color: white;
            border: none;
            border-radius: 14px;
            padding: 1rem;
            font-weight: 700;
            width: 100%;
            margin-top: 1.5rem;
            transition: 0.3s;
        }
        .btn-create:hover { background: #4338ca; transform: translateY(-2px); box-shadow: 0 10px 15px rgba(79, 70, 229, 0.2); }

        .helper-text { font-size: 0.8rem; color: #94a3b8; margin-top: 0.4rem; }
    </style>
</head>
<body>

<div class="container form-container">
    <a href="manage_courses.jsp" class="back-link mb-4 d-inline-block">
        <i class="fa-solid fa-arrow-left me-2"></i> Cancel and go back
    </a>

    <div class="form-card">
        <div class="header-icon">
            <i class="fa-solid fa-plus"></i>
        </div>

        <h2 class="fw-800 mb-1">Add New Course</h2>
        <p class="text-muted small mb-4">Fill in the details below to launch your new curriculum.</p>

        <form action="../../add-course" method="post">

            <div class="mb-4">
                <label class="form-label">Subject Identification</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-hashtag"></i></span>
                    <input type="number" name="subject_id" class="form-control" placeholder="Enter Subject ID" required>
                </div>
                <p class="helper-text">This ID links the course to a specific academic subject.</p>
            </div>

            <div class="mb-4">
                <label class="form-label">Course Price (USD)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-dollar-sign"></i></span>
                    <input type="number" name="price" class="form-control" placeholder="0.00">
                </div>
                <p class="helper-text">Leave empty if the course is free.</p>
            </div>

            <div class="mb-4">
                <label class="form-label">Delivery Method</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-video"></i></span>
                    <select name="type" class="form-select">
                        <option value="ONLINE">Online (Virtual Sessions)</option>
                        <option value="OFFLINE">Offline (In-Person)</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-create">
                Publish Course <i class="fa-solid fa-rocket ms-2"></i>
            </button>
        </form>
    </div>

    <p class="text-center mt-4 text-muted small">
        Need help? Check the <a href="#" class="text-decoration-none">Instructor Guide</a>
    </p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
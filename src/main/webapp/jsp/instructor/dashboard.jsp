<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.classare.model.User" %>
<%@ page import="com.classare.model.Person" %>
<%
    // التحقق من الجلسة والصلاحيات
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("INSTRUCTOR")) { // تأكدي من ميثود hasRole أو استبدالها بـ user.getRoles().contains(...)
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
    <title>Instructor Dashboard | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --primary: #6366f1; --bg: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--bg); margin: 0; }

        .main-container { padding: 3rem; max-width: 1200px; margin: 0 auto; }

        /* Action Cards */
        .action-card {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            text-align: center;
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100%;
        }

        .action-card:hover {
            transform: translateY(-8px);
            border-color: var(--primary);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .icon-box {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            transition: 0.3s;
        }

        /* Specific Colors for Actions */
        .bg-blue { background: #eff6ff; color: #3b82f6; }
        .bg-purple { background: #f5f3ff; color: #8b5cf6; }
        .bg-orange { background: #fff7ed; color: #f97316; }
        .bg-green { background: #ecfdf5; color: #10b981; }

        .action-title { font-weight: 700; color: #1e293b; margin-bottom: 0.5rem; }
        .action-desc { font-size: 0.85rem; color: #64748b; line-height: 1.5; }

        .header-section { margin-bottom: 3rem; }
        .user-welcome { font-weight: 800; font-size: 2rem; color: #0f172a; }
    </style>
</head>
<body>

<div class="main-container">
    <header class="header-section d-flex justify-content-between align-items-center">
        <div>
            <h1 class="user-welcome">Hello, <%= person.getFirstName() %>! 👋</h1>
            <p class="text-muted">Manage your teaching activities and track progress.</p>
        </div>
        <a href="../logout" class="btn btn-outline-danger px-4 rounded-pill fw-bold">
            <i class="fa-solid fa-right-from-bracket me-2"></i> Logout
        </a>
    </header>

    <h4 class="fw-bold mb-4">Quick Actions</h4>
    <div class="row g-4">

        <div class="col-md-3">
            <a href="manage_courses.jsp" class="action-card">
                <div class="icon-box bg-blue"><i class="fa-solid fa-layer-group"></i></div>
                <h5 class="action-title">Courses</h5>
                <p class="action-desc">Create and edit your course materials.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="manage_lectures.jsp" class="action-card">
                <div class="icon-box bg-purple"><i class="fa-solid fa-chalkboard"></i></div>
                <h5 class="action-title">Lectures</h5>
                <p class="action-desc">Organize and schedule your live sessions.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="upload_exam.jsp" class="action-card">
                <div class="icon-box bg-orange"><i class="fa-solid fa-file-circle-plus"></i></div>
                <h5 class="action-title">Exams</h5>
                <p class="action-desc">Create quizzes and assessment forms.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="view_payments.jsp" class="action-card">
                <div class="icon-box bg-green"><i class="fa-solid fa-wallet"></i></div>
                <h5 class="action-title">Payments</h5>
                <p class="action-desc">Track earnings and student subscriptions.</p>
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

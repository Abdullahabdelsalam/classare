<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.classare.model.User" %>
<%@ page import="com.classare.model.Person" %>
<%

           User user = (User) session.getAttribute("user");
            if (user == null || !user.hasRole("STUDENT")) {
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
    <title>Student Dashboard | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --student-primary: #10b981; /* Emerald Green */
            --student-bg: #f8fafc;
        }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--student-bg); margin: 0; }

        .main-container { padding: 3rem; max-width: 1200px; margin: 0 auto; }

        /* Action Cards for Students */
        .student-card {
            background: white;
            border-radius: 24px;
            padding: 2.5rem 1.5rem;
            text-align: center;
            border: 1px solid #e2e8f0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100%;
        }

        .student-card:hover {
            transform: translateY(-10px);
            border-color: var(--student-primary);
            box-shadow: 0 20px 30px -10px rgba(16, 185, 129, 0.2);
        }

        .icon-box {
            width: 70px;
            height: 70px;
            border-radius: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            transition: 0.3s;
        }

        /* Student Dashboard Themes */
        .bg-emerald { background: #ecfdf5; color: #10b981; }
        .bg-sky { background: #f0f9ff; color: #0ea5e9; }
        .bg-amber { background: #fffbeb; color: #f59e0b; }
        .bg-rose { background: #fff1f2; color: #f43f5e; }

        .card-title { font-weight: 800; color: #0f172a; margin-bottom: 0.5rem; font-size: 1.2rem; }
        .card-desc { font-size: 0.9rem; color: #64748b; line-height: 1.5; }

        .header-section { margin-bottom: 3.5rem; }
        .greeting { font-weight: 800; font-size: 2.2rem; color: #0f172a; letter-spacing: -1px; }

        /* Logout Custom */
        .logout-pill {
            background: #fee2e2;
            color: #ef4444;
            border: none;
            padding: 10px 24px;
            border-radius: 14px;
            font-weight: 700;
            transition: 0.3s;
        }
        .logout-pill:hover { background: #ef4444; color: white; }
    </style>
</head>
<body>

<div class="main-container">
    <header class="header-section d-flex justify-content-between align-items-center">
        <div>
            <h1 class="greeting">Happy Learning, <%= person.getFirstName() %>! 🎓</h1>
            <p class="text-muted">You have 2 upcoming lectures today. Don't miss out!</p>
        </div>
        <a href="../logout" class="logout-pill text-decoration-none">
            <i class="fa-solid fa-power-off me-2"></i> Logout
        </a>
    </header>

    <div class="row g-4">

        <div class="col-md-3">
            <a href="my_courses.jsp" class="student-card">
                <div class="icon-box bg-emerald"><i class="fa-solid fa-book-bookmark"></i></div>
                <h5 class="card-title">My Courses</h5>
                <p class="card-desc">Continue where you left off in your lessons.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="attend_lectures.jsp" class="student-card">
                <div class="icon-box bg-sky"><i class="fa-solid fa-user-check"></i></div>
                <h5 class="card-title">Attendance</h5>
                <p class="card-desc">Mark your presence in today's live lectures.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="submit_exams.jsp" class="student-card">
                <div class="icon-box bg-amber"><i class="fa-solid fa-pen-clip"></i></div>
                <h5 class="card-title">Exams</h5>
                <p class="card-desc">View and submit your pending exams/quizzes.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="payments.jsp" class="student-card">
                <div class="icon-box bg-rose"><i class="fa-solid fa-credit-card"></i></div>
                <h5 class="card-title">Billing</h5>
                <p class="card-desc">Manage subscriptions and payment history.</p>
            </a>
        </div>

    </div>

    <div class="mt-5 p-4 rounded-4 bg-white border d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-3">
            <div class="fs-2 text-warning"><i class="fa-solid fa-lightbulb"></i></div>
            <div>
                <h6 class="fw-bold mb-0">Study Tip of the Day</h6>
                <p class="small text-muted mb-0">Taking short breaks every 45 minutes improves focus and retention.</p>
            </div>
        </div>
        <button class="btn btn-sm btn-light rounded-pill px-3">Dismiss</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
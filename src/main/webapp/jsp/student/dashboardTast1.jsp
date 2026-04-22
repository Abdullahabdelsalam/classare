<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.classare.model.User" %>
<%@ page import="com.classare.model.Person" %>
<%@ page import="com.classare.dao.StudentDAO" %>
<%@ page import="com.classare.model.Student" %>

<%
    // التحقق من الجلسة وصلاحيات الطالب
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("STUDENT")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Person person = user.getPerson();
    Student student = StudentDAO.findByPersonId(person.getId());
    StudentDAO dao = new StudentDAO();

    int upcomingLectures = 0;
    int myCourses = 0;
    int pendingExams = 0;

    if (student != null) {
        upcomingLectures = dao.countUpcomingLectures(student.getId());
        myCourses = dao.countMyCourses(student.getId());
        pendingExams = dao.countPendingExams(student.getId());
    }
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
            --student-primary: #10b981;
            --accent: #6366f1;
            --student-bg: #f8fafc;
        }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--student-bg); margin: 0; }

        .main-container { padding: 3rem; max-width: 1200px; margin: 0 auto; }

        /* Header & Greeting */
        .header-section { margin-bottom: 3rem; }
        .greeting { font-weight: 800; font-size: 2.2rem; color: #0f172a; letter-spacing: -1px; }

        /* Stats Cards */
        .stat-box {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
            text-align: center;
            transition: 0.3s;
        }
        .stat-box:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }

        /* Banner for New Courses */
        .explore-banner {
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            border-radius: 24px;
            padding: 2rem;
            color: white;
            margin-bottom: 3rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 15px 30px rgba(99, 102, 241, 0.2);
        }

        /* Action Cards */
        .student-card {
            background: white;
            border-radius: 24px;
            padding: 2rem 1.5rem;
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
            transform: translateY(-8px);
            border-color: var(--accent);
            box-shadow: 0 20px 30px -10px rgba(99, 102, 241, 0.1);
        }

        .icon-box {
            width: 60px;
            height: 60px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            margin-bottom: 1.2rem;
        }

        .bg-emerald { background: #ecfdf5; color: #10b981; }
        .bg-sky { background: #f0f9ff; color: #0ea5e9; }
        .bg-amber { background: #fffbeb; color: #f59e0b; }
        .bg-rose { background: #fff1f2; color: #f43f5e; }

        .card-title { font-weight: 800; color: #0f172a; margin-bottom: 0.5rem; font-size: 1.1rem; }
        .card-desc { font-size: 0.85rem; color: #64748b; line-height: 1.5; }

        .logout-pill {
            background: #fee2e2;
            color: #ef4444;
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
            <h1 class="greeting">Welcome back, <%= person.getFirstName() %>! 👋</h1>
            <p class="text-muted">It's a great day to learn something new today.</p>
        </div>
        <a href="../logout" class="logout-pill text-decoration-none shadow-sm">
            <i class="fa-solid fa-power-off me-2"></i> Logout
        </a>
    </header>

    <div class="row g-3 mb-5">
        <div class="col-md-4">
            <div class="stat-box">
                <h3 class="fw-bold text-success"><%= (student != null) ? upcomingLectures : 0 %></h3>
                <p class="mb-0 text-muted small fw-bold uppercase">Lectures Today</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-box">
                <h3 class="fw-bold text-primary"><%= (student != null) ? myCourses : 0 %></h3>
                <p class="mb-0 text-muted small fw-bold uppercase">Active Courses</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-box">
                <h3 class="fw-bold text-warning"><%= (student != null) ? pendingExams : 0 %></h3>
                <p class="mb-0 text-muted small fw-bold uppercase">Quizzes Pending</p>
            </div>
        </div>
    </div>

    <div class="explore-banner">
        <div class="d-flex align-items-center gap-4">
            <div class="bg-white bg-opacity-20 p-3 rounded-circle text-white">
                <i class="fa-solid fa-rocket fs-2"></i>
            </div>
            <div>
                <h4 class="fw-800 mb-1 text-white">Ready to expand your skills?</h4>
                <p class="mb-0 text-white opacity-75">Discover thousands of expert-led courses tailored for you.</p>
            </div>
        </div>
        <a href="courses.jsp" class="btn btn-light rounded-pill px-4 py-2 fw-800 shadow-sm">
            <i class="fa-solid fa-magnifying-glass me-2"></i> Find New Courses
        </a>
    </div>

    <div class="row g-4">
        <div class="col-md-3">
            <a href="my_courses.jsp" class="student-card">
                <div class="icon-box bg-emerald"><i class="fa-solid fa-book-bookmark"></i></div>
                <h5 class="card-title">My Learning</h5>
                <p class="card-desc">Continue your current academic progress.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="attend_lectures.jsp" class="student-card">
                <div class="icon-box bg-sky"><i class="fa-solid fa-user-check"></i></div>
                <h5 class="card-title">Attendance</h5>
                <p class="card-desc">Join your live sessions and track presence.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="submit_exams.jsp" class="student-card">
                <div class="icon-box bg-amber"><i class="fa-solid fa-pen-clip"></i></div>
                <h5 class="card-title">Assessments</h5>
                <p class="card-desc">Take your exams and see your results.</p>
            </a>
        </div>

        <div class="col-md-3">
            <a href="payments.jsp" class="student-card">
                <div class="icon-box bg-rose"><i class="fa-solid fa-credit-card"></i></div>
                <h5 class="card-title">Payments</h5>
                <p class="card-desc">Review your receipts and installments.</p>
            </a>
        </div>
    </div>

    <div class="mt-5 p-4 rounded-4 bg-white border d-flex align-items-center justify-content-between shadow-sm">
        <div class="d-flex align-items-center gap-3">
            <div class="fs-3 text-warning"><i class="fa-solid fa-lightbulb"></i></div>
            <div>
                <h6 class="fw-bold mb-0">Study Tip</h6>
                <p class="small text-muted mb-0">"The expert in anything was once a beginner." Keep going!</p>
            </div>
        </div>
        <button class="btn btn-sm btn-outline-secondary rounded-pill px-3">Dismiss</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
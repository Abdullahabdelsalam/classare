<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.classare.model.*" %>
<%@ page import="com.classare.dao.*" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("STUDENT")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Student student = (Student) session.getAttribute("student");
    ExamDAO dao = new ExamDAO();

    List<Map<String, Object>> exams = null;
    if (student != null) {
        exams = dao.getStudentExams(student.getId());
    }
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Exams | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --student-bg: #f8fafc; --danger: #ef4444; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--student-bg); color: #1e293b; }

        .main-container { padding: 3rem 1.5rem; max-width: 900px; margin: 0 auto; }

        /* Header & Navigation */
        .back-link { color: #64748b; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: 0.3s; }
        .back-link:hover { color: #0f172a; }
        .page-title { font-weight: 800; font-size: 2.2rem; color: #0f172a; letter-spacing: -1px; }

        /* Exam Card Styling */
        .exam-card {
            background: white;
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02);
        }
        .exam-card:hover { border-color: var(--accent); transform: scale(1.01); }

        .course-badge {
            font-size: 0.7rem;
            text-transform: uppercase;
            font-weight: 800;
            letter-spacing: 0.5px;
            color: var(--accent);
            background: #eef2ff;
            padding: 4px 12px;
            border-radius: 20px;
            margin-bottom: 0.8rem;
            display: inline-block;
        }

        .exam-title { font-weight: 800; font-size: 1.25rem; color: #1e293b; margin-bottom: 1.5rem; }

        /* Styled File Input */
        .custom-file-upload {
            border: 2px dashed #cbd5e1;
            border-radius: 15px;
            padding: 1.2rem;
            text-align: center;
            background: #f8fafc;
            cursor: pointer;
            transition: 0.3s;
            display: block;
            margin-bottom: 1rem;
        }
        .custom-file-upload:hover { background: #f1f5f9; border-color: var(--accent); }
        .custom-file-upload input[type="file"] { display: none; }
        .file-label { font-size: 0.85rem; color: #64748b; font-weight: 600; cursor: pointer; }
        .file-label i { font-size: 1.5rem; display: block; margin-bottom: 0.5rem; color: var(--accent); }

        .btn-submit-exam {
            background: #0f172a;
            color: white;
            border-radius: 12px;
            font-weight: 700;
            padding: 0.8rem 2rem;
            border: none;
            width: 100%;
            transition: 0.3s;
        }
        .btn-submit-exam:hover { background: var(--accent); box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3); }

        /* Success/Warning Boxes */
        .feedback-box { border-radius: 18px; padding: 1.2rem; display: flex; align-items: center; gap: 1rem; margin-bottom: 2rem; }
    </style>
</head>
<body>

<div class="main-container">

    <div class="mb-4">
        <a href="dashboard.jsp" class="back-link">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>

    <header class="mb-5">
        <h1 class="page-title">Submit Exams 📝</h1>
        <p class="text-muted">Upload your completed exams or assignments for review.</p>
    </header>

    <%
        String msg = request.getParameter("msg");
        if ("already".equals(msg)) {
    %>
        <div class="feedback-box bg-warning bg-opacity-10 border border-warning-subtle text-warning-emphasis">
            <i class="fa-solid fa-triangle-exclamation fs-3"></i>
            <div>
                <strong class="d-block">Submission Rejected</strong>
                <span class="small">It looks like you've already submitted this exam. Duplicate files are not allowed.</span>
            </div>
        </div>
    <%
        } else if ("done".equals(msg)) {
    %>
        <div class="feedback-box bg-success bg-opacity-10 border border-success-subtle text-success-emphasis">
            <i class="fa-solid fa-circle-check fs-3"></i>
            <div>
                <strong class="d-block">Upload Complete!</strong>
                <span class="small">Your exam file has been successfully received and sent for grading.</span>
            </div>
        </div>
    <%
        }
    %>

    <% if (exams == null || exams.isEmpty()) { %>
        <div class="text-center p-5 bg-white rounded-5 border border-dashed mt-4">
            <div class="text-muted mb-3"><i class="fa-solid fa-clipboard-check fs-1 opacity-20"></i></div>
            <h5 class="fw-bold">No Pending Exams</h5>
            <p class="text-muted small">You don't have any exams available for submission right now.</p>
        </div>
    <% } else { %>

        <div class="row">
            <% for (Map<String, Object> e : exams) { %>
            <div class="col-12">
                <div class="exam-card">
                    <span class="course-badge"><%= e.get("course_name") %></span>
                    <h5 class="exam-title"><%= e.get("title") %></h5>

                    <form action="../../submit-exam" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="exam_id" value="<%= e.get("id") %>">

                        <label class="custom-file-upload">
                            <input type="file" name="file" required onchange="updateFileName(this)">
                            <div class="file-label">
                                <i class="fa-solid fa-cloud-arrow-up"></i>
                                <span class="file-name-text">Click to browse or drag your file here</span>
                            </div>
                        </label>

                        <button type="submit" class="btn-submit-exam">
                            Confirm Submission <i class="fa-solid fa-paper-plane ms-2"></i>
                        </button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>

    <% } %>

</div>

<script>
    // وظيفة بسيطة لتغيير النص عند اختيار ملف
    function updateFileName(input) {
        const fileName = input.files[0].name;
        const textElement = input.parentElement.querySelector('.file-name-text');
        textElement.innerHTML = "Selected: <strong class='text-dark'>" + fileName + "</strong>";
        input.parentElement.style.borderColor = "#10b981"; // تغيير اللون للأخضر عند الاختيار
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.classare.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.hasRole("INSTRUCTOR")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Map<String, Object>> courses = (List<Map<String, Object>>) request.getAttribute("courses");
    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Exam | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --instructor-primary: #4f46e5; --bg-light: #f8fafc; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-light); color: #1e293b; }

        .form-container { max-width: 650px; margin: 4rem auto; }

        .back-link { color: #64748b; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: 0.3s; }
        .back-link:hover { color: var(--instructor-primary); }

        .form-card {
            background: white;
            border-radius: 30px;
            border: 1px solid #e2e8f0;
            padding: 3rem;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.03);
        }

        .header-icon {
            width: 64px;
            height: 64px;
            background: #f5f3ff;
            color: var(--instructor-primary);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
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

        /* Styled File Upload */
        .file-drop-area {
            position: relative;
            display: flex;
            align-items: center;
            width: 100%;
            padding: 2rem;
            border: 2px dashed #cbd5e1;
            border-radius: 15px;
            background-color: #f8fafc;
            transition: 0.3s;
            cursor: pointer;
            text-align: center;
            flex-direction: column;
        }
        .file-drop-area:hover { border-color: var(--instructor-primary); background-color: #f5f3ff; }
        .file-input { position: absolute; left: 0; top: 0; height: 100%; width: 100%; opacity: 0; cursor: pointer; }

        .btn-upload {
            background: var(--instructor-primary);
            color: white;
            border: none;
            border-radius: 14px;
            padding: 1rem;
            font-weight: 700;
            width: 100%;
            margin-top: 2rem;
            transition: 0.3s;
        }
        .btn-upload:hover { background: #4338ca; transform: translateY(-2px); box-shadow: 0 10px 15px rgba(79, 70, 229, 0.2); }
    </style>
</head>
<body>

<div class="container form-container">
    <a href="manage_courses.jsp" class="back-link mb-4 d-inline-block">
        <i class="fa-solid fa-arrow-left me-2"></i> Return to Courses
    </a>

    <div class="form-card">
        <div class="header-icon">
            <i class="fa-solid fa-file-arrow-up"></i>
        </div>

        <h2 class="fw-800 mb-1">Upload New Exam</h2>
        <p class="text-muted small mb-4">Select a course and upload the examination file for your students.</p>

        <% if ("done".equals(msg)) { %>
            <div class="alert alert-success border-0 rounded-4 shadow-sm d-flex align-items-center p-3 mb-4">
                <i class="fa-solid fa-circle-check fs-4 me-3"></i>
                <span class="small fw-bold">Exam material has been published successfully!</span>
            </div>
        <% } %>

        <form method="post" enctype="multipart/form-data" action="<%= request.getContextPath() %>/instructor/upload-exam">

            <div class="mb-4">
                <label class="form-label">Target Course</label>
                <select name="course_id" class="form-select" required>
                    <option value="" selected disabled>Choose a course...</option>
                    <% if (courses != null) {
                        for (Map<String, Object> c : courses) { %>
                            <option value="<%= c.get("id") %> text-capitalize">
                                <%= c.get("name") %>
                            </option>
                    <% } } %>
                </select>
            </div>

            <div class="mb-4">
                <label class="form-label">Examination Title</label>
                <input type="text" name="title" class="form-control" placeholder="e.g. Midterm Physics - 2026" required>
            </div>

            <div class="mb-2">
                <label class="form-label">Exam Document (PDF/Word)</label>
                <div class="file-drop-area" id="drop-area">
                    <i class="fa-solid fa-cloud-arrow-up fs-2 mb-2 text-muted"></i>
                    <span class="file-msg small text-muted fw-bold">Drag & drop your file here or click to browse</span>
                    <input type="file" name="file" class="file-input" required onchange="displayFileName(this)">
                </div>
            </div>

            <button type="submit" class="btn-upload">
                Publish Examination <i class="fa-solid fa-paper-plane ms-2"></i>
            </button>
        </form>
    </div>
</div>

<script>
    function displayFileName(input) {
        const fileMsg = document.querySelector('.file-msg');
        if (input.files && input.files.length > 0) {
            fileMsg.innerHTML = `<span class="text-primary">Selected:</span> ${input.files[0].name}`;
            document.getElementById('drop-area').style.borderColor = "#4f46e5";
            document.getElementById('drop-area').style.backgroundColor = "#f5f3ff";
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submissions Grading | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }

        .table-card {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .table thead th {
            background-color: #f8fafc;
            color: #64748b;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 700;
            padding: 1.25rem;
            border-bottom: 2px solid #f1f5f9;
        }

        .student-name {
            font-weight: 600;
            color: #0f172a;
        }

        .file-link {
            text-decoration: none;
            color: #6366f1;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            background: #eef2ff;
            border-radius: 8px;
            transition: 0.2s;
        }

        .file-link:hover {
            background: #6366f1;
            color: white;
        }

        .grade-input {
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            text-align: center;
            font-weight: 700;
            color: #1e293b;
            padding: 5px;
            width: 70px !important;
        }

        .grade-input:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .bg-soft-success { background-color: #dcfce7; color: #15803d; }
        .bg-soft-warning { background-color: #fef9c3; color: #a16207; }

        .btn-save {
            background-color: #0f172a;
            color: white;
            border-radius: 8px;
            padding: 6px 16px;
            font-weight: 600;
            border: none;
            transition: 0.2s;
        }

        .btn-save:hover {
            background-color: #334155;
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="py-5">

<div class="container">
    <div class="mb-4">
        <h3 class="fw-bold"><i class="fa-solid fa-pen-ruler me-2 text-primary"></i>Exam Grading Panel</h3>
        <p class="text-muted">Review student submissions and assign grades for <b>Classare</b> exams.</p>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead>
                    <tr>
                        <th class="ps-4">Student Name</th>
                        <th>Submission File</th>
                        <th>Grade / 100</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="sub" items="${submissions}">
                        <tr>
                            <td class="ps-4">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-light d-flex align-items-center justify-content-center me-3" style="width: 35px; height: 35px; font-size: 12px; font-weight: bold;">
                                        ${sub.studentName.substring(0,1)}
                                    </div>
                                    <span class="student-name">${sub.studentName}</span>
                                </div>
                            </td>
                            <td>
                                <a href="${sub.answerFile}" class="file-link" target="_blank">
                                    <i class="fa-regular fa-file-pdf me-2"></i> View Answer
                                </a>
                            </td>
                            <form action="grade-exam" method="POST">
                                <input type="hidden" name="submissionId" value="${sub.id}">
                                <td>
                                    <input type="number" name="grade" value="${sub.grade}" class="form-control grade-input shadow-sm" min="0" max="100">
                                </td>
                                <td>
                                    <span class="badge-status ${sub.corrected ? 'bg-soft-success' : 'bg-soft-warning'}">
                                        <i class="fa-solid ${sub.corrected ? 'fa-check-circle' : 'fa-clock'} me-1"></i>
                                        ${sub.corrected ? 'Graded' : 'Pending'}
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <button type="submit" class="btn btn-save">
                                        <i class="fa-solid fa-cloud-arrow-up me-1"></i> Save
                                    </button>
                                </td>
                            </form>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty submissions}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-folder-open fa-3x mb-3 d-block opacity-25"></i>
                                No submissions found for this exam yet.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
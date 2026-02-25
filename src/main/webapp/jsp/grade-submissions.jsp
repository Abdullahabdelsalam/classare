<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Results | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f4f7fe;
            color: #2b3674;
        }

        .results-card {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0px 20px 50px rgba(112, 144, 176, 0.08);
            overflow: hidden;
        }

        .table thead th {
            background-color: #f8fafc;
            color: #a3aed0;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 1.5rem 1rem;
            border-bottom: 1px solid #f1f5f9;
        }

        .table tbody td {
            padding: 1.2rem 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }

        .student-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar-placeholder {
            width: 38px;
            height: 38px;
            border-radius: 12px;
            background: #eef2ff;
            color: #4318FF;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }

        .grade-badge {
            font-size: 1rem;
            font-weight: 800;
            color: #1b2559;
        }

        .status-pill {
            padding: 6px 12px;
            border-radius: 10px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .status-graded { background: #dcfce7; color: #05cd99; }
        .status-pending { background: #fff4e5; color: #ffb800; }

        .download-link {
            color: #4318FF;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            transition: 0.2s;
        }

        .download-link:hover {
            color: #3311cc;
            text-decoration: underline;
        }
    </style>
</head>
<body class="py-5">

<div class="container">
    <div class="mb-5 d-flex align-items-center justify-content-between">
        <div>
            <h3 class="fw-bold text-dark mb-1">Submissions Overview</h3>
            <p class="text-muted small mb-0">Classare Academic Performance Tracking</p>
        </div>
        <button class="btn btn-outline-primary border-0 fw-bold">
            <i class="fa-solid fa-file-export me-2"></i>Export PDF
        </button>
    </div>

    <div class="results-card">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th class="ps-4">Student</th>
                        <th>File Submission</th>
                        <th>Score</th>
                        <th class="text-center">Review Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="sub" items="${submissions}">
                        <tr>
                            <td class="ps-4">
                                <div class="student-info">
                                    <div class="avatar-placeholder">
                                        ${sub.studentName.substring(0,1)}
                                    </div>
                                    <div>
                                        <span class="d-block fw-bold text-dark">${sub.studentName}</span>
                                        <span class="text-muted" style="font-size: 0.7rem;">ID: #STU-${sub.id}</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <a href="${sub.answerFile}" class="download-link" target="_blank">
                                    <i class="fa-solid fa-paperclip me-2"></i>View Solution
                                </a>
                            </td>
                            <td>
                                <span class="grade-badge">
                                    ${sub.grade != null ? sub.grade : '--'} <small class="text-muted fw-normal" style="font-size: 0.65rem;">/ 100</small>
                                </span>
                            </td>
                            <td class="text-center">
                                <span class="status-pill ${sub.corrected ? 'status-graded' : 'status-pending'}">
                                    <i class="fa-solid ${sub.corrected ? 'fa-check' : 'fa-spinner fa-spin'} me-1"></i>
                                    ${sub.corrected ? 'Graded' : 'Under Review'}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty submissions}">
                        <tr>
                            <td colspan="4" class="text-center py-5">
                                <p class="text-muted mb-0">No submissions found for this record.</p>
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
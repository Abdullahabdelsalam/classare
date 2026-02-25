<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Management | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
            padding-bottom: 50px;
        }
        .page-header {
            background: white;
            padding: 2rem 0;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 2rem;
        }
        .card-custom {
            border: none;
            border-radius: 16px;
            background: white;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .form-label {
            font-weight: 700;
            font-size: 0.75rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .form-control {
            border-radius: 10px;
            border: 1.5px solid #f1f5f9;
            background: #f8fafc;
            padding: 0.6rem 1rem;
        }
        .form-control:focus {
            background: white;
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }
        /* Table Styling */
        .table-container {
            border-radius: 16px;
            overflow: hidden;
            background: white;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .table thead {
            background: #f8fafc;
        }
        .table thead th {
            font-weight: 700;
            font-size: 0.75rem;
            text-transform: uppercase;
            color: #64748b;
            border-bottom: 1px solid #f1f5f9;
            padding: 1.25rem 1rem;
        }
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            color: #334155;
            border-bottom: 1px solid #f1f5f9;
        }
        .status-badge {
            padding: 0.5em 1em;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.75rem;
        }
        .btn-action {
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: 0.3s;
        }
        .btn-add {
            background: #6366f1;
            color: white;
            border: none;
            height: 45px;
        }
        .btn-add:hover { background: #4f46e5; color: white; }
    </style>
</head>
<body>

    <header class="page-header">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h3 fw-bold mb-1">Course Sessions</h1>
                <p class="text-muted small mb-0">Schedule and manage attendance for your classes</p>
            </div>
            <div class="d-flex gap-2">
                <span class="badge bg-soft-primary text-primary p-2">Course ID: #${courseId}</span>
            </div>
        </div>
    </header>

    <div class="container">

        <div class="card card-custom p-4 mb-5">
            <div class="d-flex align-items-center mb-4 text-primary">
                <i class="fa-solid fa-calendar-plus me-2 fa-lg"></i>
                <h5 class="fw-bold mb-0">Schedule New Session</h5>
            </div>

            <form action="sessions" method="POST" class="row g-4">
                <input type="hidden" name="courseId" value="${courseId}">
                <input type="hidden" name="centerId" value="1">

                <div class="col-md-4">
                    <label class="form-label">Session Date</label>
                    <input type="date" name="date" class="form-control" required>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Start Time</label>
                    <div class="input-group">
                        <span class="input-group-text bg-transparent border-end-0 text-muted small"><i class="fa-regular fa-clock"></i></span>
                        <input type="time" name="startTime" class="form-control border-start-0" required>
                    </div>
                </div>

                <div class="col-md-3">
                    <label class="form-label">End Time</label>
                    <div class="input-group">
                        <span class="input-group-text bg-transparent border-end-0 text-muted small"><i class="fa-solid fa-hourglass-end"></i></span>
                        <input type="time" name="endTime" class="form-control border-start-0" required>
                    </div>
                </div>

                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-add w-100 btn-action">
                        <i class="fa-solid fa-plus me-2"></i>Add
                    </button>
                </div>
            </form>
        </div>

        <div class="table-container">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Timing</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${sessions}">
                        <tr>
                            <td>
                                <div class="fw-bold text-dark">${s.sessionDate}</div>
                            </td>
                            <td>
                                <span class="text-muted small">
                                    <i class="fa-regular fa-clock me-1"></i> ${s.startTime} — ${s.endTime}
                                </span>
                            </td>
                            <td>
                                <span class="status-badge bg-info bg-opacity-10 text-info">
                                    <i class="fa-solid fa-circle-info me-1 small"></i> ${s.status}
                                </span>
                            </td>
                            <td class="text-center">
                                <a href="attendance?sessionId=${s.id}" class="btn btn-sm btn-outline-success btn-action px-3">
                                    <i class="fa-solid fa-clipboard-user me-2"></i>Attendance
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty sessions}">
                        <tr>
                            <td colspan="4" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-calendar-xmark fa-2x mb-3 d-block opacity-20"></i>
                                No sessions scheduled yet for this course.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
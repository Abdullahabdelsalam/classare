<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Tracking | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }
        .attendance-card {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        .card-header-custom {
            background: #ffffff;
            padding: 2rem;
            border-bottom: 2px solid #f1f5f9;
        }
        .student-row {
            transition: background 0.2s;
            border-bottom: 1px solid #f1f5f9;
        }
        .student-row:hover {
            background-color: #fcfdfe;
        }
        .student-avatar {
            width: 40px;
            height: 40px;
            background: #eef2ff;
            color: #6366f1;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            margin-right: 15px;
        }
        /* Custom Radio Buttons as Toggle Switches */
        .btn-check:checked + .btn-outline-success {
            background-color: #dcfce7 !important;
            color: #15803d !important;
            border-color: #15803d;
        }
        .btn-check:checked + .btn-outline-danger {
            background-color: #fee2e2 !important;
            color: #b91c1c !important;
            border-color: #b91c1c;
        }
        .btn-group-toggle .btn {
            padding: 8px 20px;
            font-weight: 600;
            font-size: 0.85rem;
            border-radius: 8px !important;
            margin: 0 5px;
            border: 1.5px solid #e2e8f0;
            color: #64748b;
        }
        .btn-save {
            background: #4f46e5;
            border: none;
            border-radius: 12px;
            padding: 1rem;
            font-weight: 700;
            transition: 0.3s;
        }
        .btn-save:hover {
            background: #4338ca;
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.3);
        }
    </style>
</head>
<body class="py-5">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="attendance-card">
                <div class="card-header-custom d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="fw-bold mb-1">Attendance Tracking</h4>
                        <p class="text-muted small mb-0">
                            <i class="fa-solid fa-hashtag me-1 text-primary"></i> Session ID: ${sessionId}
                        </p>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-soft-info text-primary p-2">
                            <i class="fa-regular fa-calendar-check me-1"></i> Today's Sheet
                        </span>
                    </div>
                </div>

                <div class="card-body p-0">
                    <form action="attendance" method="POST">
                        <input type="hidden" name="sessionId" value="${sessionId}">

                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="ps-4 py-3 text-uppercase small fw-bold text-muted" style="letter-spacing: 1px;">Student Information</th>
                                        <th class="text-center py-3 text-uppercase small fw-bold text-muted" style="letter-spacing: 1px;">Attendance Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="std" items="${students}">
                                        <tr class="student-row">
                                            <td class="ps-4 py-3">
                                                <div class="d-flex align-items-center">
                                                    <div class="student-avatar text-uppercase">
                                                        ${std.person.firstName.charAt(0)}${std.person.lastName.charAt(0)}
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold text-dark">${std.person.firstName} ${std.person.lastName}</div>
                                                        <div class="text-muted small">Student ID: #S-${std.id}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center py-3">
                                                <input type="hidden" name="studentIds" value="${std.id}">
                                                <div class="btn-group btn-group-toggle" role="group">
                                                    <input type="radio" class="btn-check" name="status_${std.id}" id="p_${std.id}" value="PRESENT" checked>
                                                    <label class="btn btn-outline-success" for="p_${std.id}">
                                                        <i class="fa-solid fa-check-circle me-1"></i> Present
                                                    </label>

                                                    <input type="radio" class="btn-check" name="status_${std.id}" id="a_${std.id}" value="ABSENT">
                                                    <label class="btn btn-outline-danger" for="a_${std.id}">
                                                        <i class="fa-solid fa-times-circle me-1"></i> Absent
                                                    </label>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="p-4 bg-light border-top">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <p class="text-muted small mb-md-0">
                                        <i class="fa-solid fa-circle-info me-1"></i>
                                        Please review the attendance status of all students before finalizing.
                                    </p>
                                </div>
                                <div class="col-md-4">
                                    <button type="submit" class="btn btn-save text-white w-100">
                                        <i class="fa-solid fa-cloud-arrow-up me-2"></i> Save Changes
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
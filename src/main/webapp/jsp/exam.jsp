<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Assessments | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
        }

        .exam-card {
            background: white;
            border: none;
            border-radius: 16px;
            padding: 1.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid #e2e8f0;
            position: relative;
            overflow: hidden;
        }

        .exam-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px -5px rgba(0, 0, 0, 0.05);
            border-color: #6366f1;
        }

        .exam-icon {
            width: 50px;
            height: 50px;
            background: #eef2ff;
            color: #6366f1;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .btn-download {
            background: #f1f5f9;
            color: #475569;
            border: none;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 10px 15px;
            border-radius: 10px;
            transition: 0.2s;
        }

        .btn-download:hover {
            background: #e2e8f0;
            color: #1e293b;
        }

        .btn-upload {
            background: #6366f1;
            color: white;
            border: none;
            font-weight: 700;
            font-size: 0.85rem;
            padding: 10px 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px -1px rgba(99, 102, 241, 0.2);
        }

        .btn-upload:hover {
            background: #4f46e5;
            color: white;
        }

        .status-dot {
            height: 8px;
            width: 8px;
            background-color: #10b981;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }
    </style>
</head>
<body class="py-5">

<div class="container">
    <div class="d-flex align-items-center justify-content-between mb-5">
        <div>
            <h3 class="fw-bold mb-1 text-dark">Assessments & Exams</h3>
            <p class="text-muted small mb-0">Download your tasks and upload your answers securely.</p>
        </div>
        <i class="fa-solid fa-file-signature fa-2x text-muted opacity-25"></i>
    </div>

    <div class="row g-4">
        <c:forEach var="exam" items="${exams}">
            <div class="col-lg-6">
                <div class="exam-card">
                    <div class="d-flex justify-content-between">
                        <div class="exam-icon">
                            <i class="fa-solid fa-file-pdf fa-xl"></i>
                        </div>
                        <div>
                            <span class="badge bg-soft-success text-success fw-600 rounded-pill px-3 py-2" style="background: #ecfdf5; font-size: 0.7rem;">
                                <span class="status-dot"></span> OPEN
                            </span>
                        </div>
                    </div>

                    <div class="mb-4">
                        <h5 class="fw-bold text-dark mb-1">${exam.title}</h5>
                        <p class="text-muted small">Please submit your final solution before the deadline.</p>
                    </div>

                    <div class="d-flex gap-2">
                        <a href="${exam.fileUrl}" class="btn btn-download flex-grow-1" download>
                            <i class="fa-solid fa-download me-2"></i> Download Questions
                        </a>
                        <button class="btn btn-upload px-4" data-bs-toggle="modal" data-bs-target="#uploadModal${exam.id}">
                            <i class="fa-solid fa-cloud-arrow-up me-2"></i> Submit Solution
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty exams}">
            <div class="col-12 text-center py-5">
                <div class="opacity-25 mb-3">
                    <i class="fa-solid fa-box-open fa-4x"></i>
                </div>
                <h5 class="text-muted">No exams available at the moment.</h5>
            </div>
        </c:if>
    </div>
</div>

<c:forEach var="exam" items="${exams}">
<div class="modal fade" id="uploadModal${exam.id}" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow" style="border-radius: 20px;">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold">Upload Solution</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <p class="text-muted small mb-4">Exam: <strong>${exam.title}</strong></p>
                <form action="upload-exam" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="examId" value="${exam.id}">
                    <div class="upload-area border-dashed border-2 p-4 text-center rounded-3 bg-light" style="border: 2px dashed #cbd5e1;">
                        <i class="fa-solid fa-file-arrow-up fa-2x text-primary mb-2"></i>
                        <input type="file" name="solutionFile" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-upload w-100 mt-4 py-3">Submit Final Work</button>
                </form>
            </div>
        </div>
    </div>
</div>
</c:forEach>

</body>
</html>
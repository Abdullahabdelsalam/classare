<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Course | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f1f5f9;
            padding: 40px 0;
        }
        .course-card {
            background: #ffffff;
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.03);
            border: 1px solid #e2e8f0;
        }
        .course-header {
            padding: 2rem;
            border-bottom: 1px solid #f1f5f9;
        }
        .form-label {
            font-weight: 700;
            font-size: 0.75rem;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 8px;
            display: block;
        }
        .form-control, .form-select {
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 10px 15px;
            font-size: 0.95rem;
            transition: 0.3s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }
        .input-group-text {
            background: #f8fafc;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px 0 0 10px;
            color: #64748b;
        }
        .has-icon .form-control, .has-icon .form-select {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
        .btn-create {
            background: #6366f1;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 700;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: 0.3s;
        }
        .btn-create:hover {
            background: #4f46e5;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.3);
            color: white;
        }
        .section-title {
            font-size: 1.25rem;
            font-weight: 800;
            color: #1e293b;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="course-card">
                <div class="course-header d-flex align-items-center justify-content-between">
                    <div>
                        <h3 class="section-title mb-1">Create New Course</h3>
                        <p class="text-muted small mb-0">Launch a new learning program on Classare</p>
                    </div>
                    <div class="icon-badge bg-light p-3 rounded-circle text-primary">
                        <i class="fa-solid fa-graduation-cap fa-2x"></i>
                    </div>
                </div>

                <div class="card-body p-4 p-lg-5">
                    <form action="manage-courses" method="POST">

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Course Subject</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-book-bookmark"></i></span>
                                    <select name="subjectId" class="form-select" required>
                                        <option value="" selected disabled>Choose Subject...</option>
                                        <c:forEach var="sub" items="${subjects}">
                                            <option value="${sub.id}">${sub.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label class="form-label">Assigned Teacher</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-user-tie"></i></span>
                                    <select name="teacherId" class="form-select" required>
                                        <option value="" selected disabled>Select Instructor...</option>
                                        <c:forEach var="teacher" items="${teachers}">
                                            <option value="${teacher.id}">${teacher.firstName} ${teacher.lastName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label class="form-label">Course Price (EGP)</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-tags"></i></span>
                                    <input type="number" name="price" class="form-control" placeholder="0.00" min="0" step="0.01">
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label class="form-label">Capacity (Max Students)</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-users-gear"></i></span>
                                    <input type="number" name="maxStudents" class="form-control" placeholder="Unlimited" min="1">
                                </div>
                            </div>
                        </div>

                        <hr class="my-4 opacity-25">

                        <div class="d-flex justify-content-end gap-3">
                            <button type="button" class="btn btn-light px-4 fw-bold">Cancel</button>
                            <button type="submit" class="btn btn-create px-5">
                                <i class="fa-solid fa-paper-plane me-2"></i> Publish Course
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
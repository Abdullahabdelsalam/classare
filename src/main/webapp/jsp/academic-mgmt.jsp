<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Structure | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4338ca 0%, #6366f1 100%);
            --glass-bg: rgba(255, 255, 255, 0.95);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: #f1f5f9; /* Soft Slate */
            color: #1e293b;
            min-height: 100vh;
        }

        /* Modern Navigation Header */
        .dashboard-nav {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(226, 232, 240, 0.8);
            padding: 1.25rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .badge-academic {
            background: #eef2ff;
            color: #4338ca;
            border: 1px solid #e0e7ff;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 50px;
        }

        /* Professional Cards */
        .feature-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 2rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 10px 10px -5px rgba(0, 0, 0, 0.02);
            border-color: #cbd5e1;
        }

        /* Custom Input Styling */
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #475569;
            margin-bottom: 0.6rem;
        }

        .form-control, .form-select {
            height: 48px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.95rem;
            transition: 0.2s;
        }

        .form-control:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            background-color: #fff;
        }

        /* Dynamic Buttons */
        .btn-modern {
            height: 48px;
            border-radius: 12px;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: 0.3s;
        }

        .btn-modern:active { transform: scale(0.98); }

        .btn-save-stage { background: #10b981; color: white; border: none; }
        .btn-save-level { background: #2563eb; color: white; border: none; }
        .btn-save-subject { background: #06b6d4; color: white; border: none; }

        .icon-container {
            width: 54px;
            height: 54px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

    <nav class="dashboard-nav mb-5">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h4 fw-bold mb-0">Classare <span style="color: #4338ca">Academic</span></h1>
                <p class="small text-muted mb-0">Smart Educational Infrastructure Management</p>
            </div>
            <div class="badge-academic">
                <i class="fa-regular fa-calendar-check me-2"></i>AY 2025/2026
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <div class="row g-4">

            <div class="col-lg-4">
                <div class="feature-card">
                    <div class="icon-container" style="background: #ecfdf5; color: #059669;">
                        <i class="fa-solid fa-layer-group fa-xl"></i>
                    </div>
                    <h5 class="fw-bold">Academic Stages</h5>
                    <p class="text-muted small mb-4">Define the foundation of your school system (e.g., K-12, Higher Ed).</p>

                    <form action="academic?action=addStage" method="post">
                        <div class="mb-4">
                            <label class="form-label">STAGE TITLE</label>
                            <input type="text" name="stageName" class="form-control" placeholder="Enter Stage Name..." required>
                        </div>
                        <button class="btn btn-modern btn-save-stage w-100">
                            <i class="fa-solid fa-plus-circle"></i> Create Stage
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="feature-card">
                    <div class="icon-container" style="background: #eff6ff; color: #2563eb;">
                        <i class="fa-solid fa-stairs fa-xl"></i>
                    </div>
                    <h5 class="fw-bold">Grade Levels</h5>
                    <p class="text-muted small mb-4">Organize classes and specific grades under each stage.</p>

                    <form action="academic?action=addLevel" method="post">
                        <div class="mb-3">
                            <label class="form-label">PARENT STAGE</label>
                            <select name="stageId" class="form-select">
                                <c:forEach var="stage" items="${stages}">
                                    <option value="${stage.id}">${stage.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">LEVEL NAME</label>
                            <input type="text" name="levelName" class="form-control" placeholder="e.g. Grade 11-A" required>
                        </div>
                        <button class="btn btn-modern btn-save-level w-100">
                            <i class="fa-solid fa-plus-circle"></i> Create Level
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="feature-card">
                    <div class="icon-container" style="background: #ecfeff; color: #0891b2;">
                        <i class="fa-solid fa-book-open-reader fa-xl"></i>
                    </div>
                    <h5 class="fw-bold">Curriculum</h5>
                    <p class="text-muted small mb-4">Map subjects and learning modules to specific stages.</p>

                    <form action="academic?action=addSubject" method="post">
                        <div class="mb-3">
                            <label class="form-label">ASSIGN TO STAGE</label>
                            <select name="stageId" class="form-select">
                                <c:forEach var="stage" items="${stages}">
                                    <option value="${stage.id}">${stage.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">SUBJECT NAME</label>
                            <input type="text" name="subjectName" class="form-control" placeholder="e.g. Computer Science" required>
                        </div>
                        <button class="btn btn-modern btn-save-subject w-100">
                            <i class="fa-solid fa-plus-circle"></i> Create Subject
                        </button>
                    </form>
                </div>
            </div>

        </div>
    </div>

    </body>
</html>
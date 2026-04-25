<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e9f2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 50px 0;
        }
        .student-card {
            background: #ffffff;
            border: none;
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .student-header {
            background: #10b981;
            padding: 2.5rem 1rem;
            text-align: center;
            color: white;
        }
        .form-label {
            font-weight: 600;
            font-size: 0.75rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select {
            border: 1.5px solid #f1f5f9;
            background-color: #f8fafc;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.2s;
        }
        .form-control:focus, .form-select:focus {
            background-color: #fff;
            border-color: #10b981;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.1);
        }
        .btn-student {
            background: #10b981;
            border: none;
            border-radius: 12px;
            padding: 0.9rem;
            font-weight: 700;
            font-size: 1rem;
            color: white;
            transition: all 0.3s;
            margin-top: 1.5rem;
        }
        .btn-student:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(16, 185, 129, 0.2);
        }
        .input-group-text {
            background: #f8fafc;
            border: 1.5px solid #f1f5f9;
            border-right: none;
            border-radius: 12px 0 0 12px;
            color: #94a3b8;
        }
        .has-icon .form-control, .has-icon .form-select {
            border-left: none;
            border-radius: 0 12px 12px 0;
        }
        .section-title {
            font-size: 0.9rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }
        .section-title i {
            color: #10b981;
            margin-right: 10px;
        }
        .gender-box {
            background: #f8fafc;
            border: 1.5px solid #f1f5f9;
            border-radius: 12px;
            padding: 10px 15px;
            display: flex;
            gap: 20px;
        }

        /* تنسيق معاينة الصورة */
        .profile-img-preview {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #10b981;
            margin-bottom: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="student-card">
                <div class="student-header">
                    <i class="fa-solid fa-graduation-cap fa-3x mb-3"></i>
                    <h2 class="fw-bold mb-0">Student Registration</h2>
                    <p class="opacity-75 small mt-2">Create your account on Classare</p>
                </div>

                <div class="card-body p-4 p-lg-5">
                    <form action="register-student" method="POST" enctype="multipart/form-data">

                        <div class="section-title">
                            <i class="fa-solid fa-circle-user"></i> Personal Information
                        </div>

                        <div class="text-center mb-4">
                            <img id="imgPreview" src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="profile-img-preview" alt="Preview">
                            <div class="col-md-8 mx-auto">
                                <label class="form-label">Profile Image</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-camera"></i></span>
                                    <input type="file" name="profileImage" class="form-control" accept="image/*" required onchange="previewFile()">
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">First Name</label>
                                <input type="text" name="firstName" class="form-control" placeholder="Enter first name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Last Name</label>
                                <input type="text" name="lastName" class="form-control" placeholder="Enter last name" required>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Date of Birth</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-calendar-days"></i></span>
                                    <input type="date" name="birthDate" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">National ID</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                                    <input type="text" name="nationalId" class="form-control" placeholder="14-digit ID" required>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Phone Number</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                                    <input type="tel" name="phone" class="form-control" placeholder="01xxxxxxxxx" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Address</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-map-marker-alt"></i></span>
                                    <input type="text" name="address" class="form-control" placeholder="City, Street address">
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Gender</label>
                            <div class="gender-box">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" id="male" value="MALE" checked>
                                    <label class="form-check-label" for="male">Male</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" id="female" value="FEMALE">
                                    <label class="form-check-label" for="female">Female</label>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4 opacity-25">

                        <div class="section-title">
                            <i class="fa-solid fa-book"></i> Academic Selection
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label">Education Stage</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-school"></i></span>
                                    <select id="stageSelect" name="stageId" class="form-select" onchange="filterLevels()" required>
                                        <option value="" selected disabled>Select Stage...</option>
                                        <c:forEach var="stage" items="${stages}">
                                            <option value="${stage.id}">${stage.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Faculty</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-building-columns"></i></span>
                                    <select id="facultySelect" name="facultyId" class="form-select" disabled>
                                        <option value="" selected disabled>Select Stage first...</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Level / Grade</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-stairs"></i></span>
                                    <select id="levelSelect" name="levelId" class="form-select" required disabled>
                                        <option value="" selected disabled>Select Stage first...</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4 opacity-25">

                        <div class="section-title">
                            <i class="fa-solid fa-shield-halved"></i> Security & Access
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label">Email Address</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                    <input type="email" name="email" class="form-control" placeholder="email@classare.com" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Password</label>
                                <div class="input-group has-icon">
                                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-student w-100">
                            <i class="fa-solid fa-paper-plane me-2"></i> Create My Student Account
                        </button>

                        <div class="text-center mt-4">
                            <span class="text-muted small">Already registered? <a href="login" class="text-success fw-bold text-decoration-none">Sign In</a></span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // وظيفة معاينة الصورة
    function previewFile() {
        const preview = document.getElementById('imgPreview');
        const file = document.querySelector('input[type=file]').files[0];
        const reader = new FileReader();

        reader.addEventListener("load", function () {
            preview.src = reader.result;
        }, false);

        if (file) {
            reader.readAsDataURL(file);
        }
    }

    const levelsData = [
        <c:forEach var="lvl" items="${levels}" varStatus="status">
        {
            id: "${lvl.id}",
            name: "${lvl.name}",
            stageId: "${lvl.stage != null ? lvl.stage.id : (lvl.stageId != null ? lvl.stageId : 0)}"
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];

    const facultiesData = [
        <c:forEach var="f" items="${faculties}" varStatus="status">
        {
            id: "${f.id}",
            name: "${f.name}",
            stageId: "${f.stageId}"
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];

    function filterLevels() {
        const stageId = document.getElementById('stageSelect').value;

        // تصفية المستويات
        const levelSelect = document.getElementById('levelSelect');
        levelSelect.innerHTML = '<option value="" selected disabled>Select Level...</option>';
        levelSelect.disabled = false;
        levelsData.filter(lvl => lvl.stageId == stageId).forEach(lvl => {
            levelSelect.add(new Option(lvl.name, lvl.id));
        });

        // تصفية الكليات
        const facultySelect = document.getElementById('facultySelect');
        const filteredFacs = facultiesData.filter(f => f.stageId == stageId);

        if (filteredFacs.length > 0) {
            facultySelect.disabled = false;
            facultySelect.innerHTML = '<option value="" selected disabled>Select Faculty...</option>';
            filteredFacs.forEach(f => {
                facultySelect.add(new Option(f.name, f.id));
            });
        } else {
            facultySelect.innerHTML = '<option value="">Not Applicable</option>';
            facultySelect.disabled = true;
        }
    }
</script>
</body>
</html>
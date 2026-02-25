<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Classare | Choose Your Role</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .selection-title {
            font-weight: 800;
            color: #1e293b;
            margin-bottom: 10px;
        }

        .selection-card {
            background: white;
            border: 2px solid transparent;
            border-radius: 24px;
            padding: 40px 30px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            height: 100%;
            position: relative;
            text-decoration: none;
            display: block;
        }

        .selection-card:hover {
            transform: translateY(-10px);
            border-color: #6366f1;
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1);
        }

        .icon-wrapper {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 25px;
            transition: 0.3s;
        }

        /* Teacher Theme */
        .teacher-card .icon-wrapper {
            background: rgba(99, 102, 241, 0.1);
            color: #6366f1;
        }
        .teacher-card:hover .icon-wrapper {
            background: #6366f1;
            color: white;
        }

        /* Student Theme */
        .student-card .icon-wrapper {
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }
        .student-card:hover .icon-wrapper {
            background: #10b981;
            color: white;
        }

        .role-name {
            font-weight: 700;
            font-size: 1.5rem;
            color: #1e293b;
            margin-bottom: 12px;
        }

        .role-desc {
            color: #64748b;
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .arrow-btn {
            margin-top: 20px;
            color: #6366f1;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            opacity: 0;
            transition: 0.3s;
        }

        .selection-card:hover .arrow-btn {
            opacity: 1;
            transform: translateX(5px);
        }

        .brand-logo {
            position: absolute;
            top: 40px;
            left: 50%;
            transform: translateX(-50%);
            font-weight: 800;
            font-size: 1.8rem;
            color: #6366f1;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <a href="index.jsp" class="brand-logo">Classare</a>

    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="selection-title">Join the Classare Family</h2>
            <p class="text-muted">Choose your role to get started with your personalized dashboard.</p>
        </div>

        <div class="row justify-content-center g-4">
          <div class="col-md-5 col-lg-4">
              <a href="register-instructor" class="selection-card instructor-card text-center text-decoration-none">
                  <div class="icon-wrapper">
                      <i class="fa-solid fa-chalkboard-user"></i>
                  </div>
                  <h3 class="role-name">I am an Instructor</h3>
                  <p class="role-desc">Manage your classes, track attendance, and create advanced assessments for your students.</p>
                  <div class="arrow-btn">
                      Create Instructor Account <i class="fa-solid fa-arrow-right"></i>
                  </div>
              </a>
          </div>

            <div class="col-md-5 col-lg-4">
                <a href="register-student" class="selection-card student-card text-center text-decoration-none">
                    <div class="icon-wrapper">
                        <i class="fa-solid fa-user-graduate"></i>
                    </div>
                    <h3 class="role-name">I am a Student</h3>
                    <p class="role-desc">Access your study materials, check your schedule, and track your academic progress.</p>
                    <div class="arrow-btn">
                        Create Student Account <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
            </div>
        </div>

        <div class="text-center mt-5">
            <p class="text-muted small">Already have an account? <a href="login.jsp" class="text-primary fw-bold text-decoration-none">Sign In</a></p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
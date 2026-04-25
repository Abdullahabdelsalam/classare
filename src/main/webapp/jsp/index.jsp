<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classare | Integrated Education Management Platform</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --accent: #10b981;
            --text-main: #1e293b;
            --bg-light: #f8fafc;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--text-main);
            background-color: white;
            scroll-behavior: smooth;
        }

        /* Navbar */
        .navbar {
            padding: 1rem 0;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        .navbar-brand {
            font-size: 1.75rem;
            font-weight: 800;
            letter-spacing: -1px;
            color: var(--primary) !important;
        }

        /* Hero Section */
        .hero-section {
            background: radial-gradient(circle at 90% 10%, rgba(99, 102, 241, 0.05) 0%, rgba(255, 255, 255, 1) 90.2%);
            padding: 120px 0 80px;
            text-align: center;
        }
        .hero-title {
            font-weight: 800;
            font-size: 3.5rem;
            line-height: 1.2;
            background: linear-gradient(135deg, #1e293b 0%, #4f46e5 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1.5rem;
        }
        .hero-subtitle {
            font-size: 1.25rem;
            color: #64748b;
            max-width: 700px;
            margin: 0 auto 2.5rem;
        }

        /* Feature Cards */
        .feature-card {
            border: 1px solid #f1f5f9;
            border-radius: 24px;
            padding: 40px 30px;
            transition: all 0.4s ease;
            background: white;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.05);
            border-color: var(--primary);
        }
        .icon-circle {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 1.5rem;
        }

        /* Buttons */
        .btn-custom {
            padding: 12px 32px;
            border-radius: 12px;
            font-weight: 700;
            transition: 0.3s;
        }
        .btn-primary-custom {
            background-color: var(--primary);
            color: white;
            border: none;
        }
        .btn-primary-custom:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            color: white;
        }

        /* Footer */
        footer {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 60px 0 30px;
        }
        .footer-logo {
            color: white;
            font-weight: 800;
            font-size: 1.5rem;
            margin-bottom: 1rem;
            display: block;
        }
        .social-links a:hover {
            transform: scale(1.2);
            color: #6366f1 !important;
            transition: 0.3s;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#">Classare</a>
            <div class="ms-auto d-flex gap-2">
                <a href="<%=request.getContextPath()%>/login.jsp" class="btn btn-custom btn-outline-primary border-2">Login</a>
                <a href="register-choice.jsp" class="btn btn-custom btn-primary-custom d-none d-md-inline-block">Join Now</a>
            </div>
        </div>
    </nav>

    <header class="hero-section">
        <div class="container">
            <span class="badge bg-soft-primary text-primary px-3 py-2 rounded-pill mb-3" style="background: rgba(99,102,241,0.1)">
                The Future of Education 2.0 🚀
            </span>
            <h1 class="hero-title">Elevate Education<br>With Classare</h1>
            <p class="hero-subtitle">The smartest platform designed to connect teachers, students, and parents in a seamless, high-tech learning environment.</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="<%=request.getContextPath()%>/register-choice.jsp" class="btn btn-custom btn-primary-custom btn-lg px-5">Get Started Free</a>
                <a href="#features" class="btn btn-custom btn-light btn-lg px-5 border">Learn More</a>
            </div>
        </div>
    </header>

    <section id="features" class="container py-5 mt-5">
        <div class="text-center mb-5">
            <h6 class="text-primary fw-bold text-uppercase mb-2">Our Key Features</h6>
            <h2 class="fw-bold display-6">All-in-One Educational Ecosystem</h2>
        </div>

        <div class="row g-4">
            <div class="col-md-4 text-center">
                <div class="feature-card">
                    <div class="icon-circle" style="background: rgba(99, 102, 241, 0.1); color: var(--primary);">
                        <i class="fa-solid fa-chalkboard-user"></i>
                    </div>
                    <h4 class="fw-bold mb-3">For Teachers</h4>
                    <p class="text-muted lh-lg">Manage sessions, track attendance smartly, create advanced exams, and monitor student performance effortlessly.</p>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="feature-card">
                    <div class="icon-circle" style="background: rgba(16, 185, 129, 0.1); color: var(--accent);">
                        <i class="fa-solid fa-user-graduate"></i>
                    </div>
                    <h4 class="fw-bold mb-3">For Students</h4>
                    <p class="text-muted lh-lg">Organized schedules, instant resource access, online exams, and real-time tracking of grades and progress.</p>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="feature-card">
                    <div class="icon-circle" style="background: rgba(245, 158, 11, 0.1); color: #f59e0b;">
                        <i class="fa-solid fa-chart-line"></i>
                    </div>
                    <h4 class="fw-bold mb-3">For Parents</h4>
                    <p class="text-muted lh-lg">Stay updated with instant notifications, performance analytics, and direct oversight of your children's attendance.</p>
                </div>
            </div>
        </div>
    </section>

    <footer class="text-center mt-5">
        <div class="container">
            <span class="footer-logo">Classare</span>
            <p class="mb-4">Building bridges of knowledge with cutting-edge technology.</p>
           <div class="social-links mb-4 d-flex justify-content-center gap-3">
               <a href="https://www.facebook.com/abdo.shams.393" target="_blank" rel="noopener noreferrer" class="text-white fs-5">
                   <i class="fab fa-facebook"></i>
               </a>
               <a href="https://www.instagram.com/abdullah_shams705" target="_blank" rel="noopener noreferrer" class="text-white fs-5">
                   <i class="fab fa-instagram"></i>
               </a>
               <a href="https://www.linkedin.com/in/abdallah-shams-1b27b024a/" target="_blank" rel="noopener noreferrer" class="text-white fs-5">
                   <i class="fab fa-linkedin"></i>
               </a>
               <a href="https://mail.google.com/mail/?view=cm&fs=1&to=abdullahabdalslam705@gmail.com" target="_blank" rel="noopener noreferrer" class="text-white fs-5">
                  <i class="fa-solid fa-envelope"></i>
               </a>
               <a href="https://wa.me/+201060225247" target="_blank" class="text-white fs-5">
                   <i class="fa-brands fa-whatsapp"></i>
               </a>
           </div>
            <hr class="border-secondary opacity-25">
            <p class="small text-muted">© 2026 Classare Project. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
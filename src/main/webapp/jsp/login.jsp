<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Classare</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        :root {
            --primary-color: #4f46e5;
            --primary-hover: #4338ca;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* Gradient Background */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            padding: 15px;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .brand-logo {
            width: 60px;
            height: 60px;
            background: var(--primary-color);
            color: white;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 1.5rem;
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.4);
        }

        .login-header h2 {
            font-weight: 800;
            color: #1e293b;
            letter-spacing: -0.5px;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #475569;
            margin-bottom: 8px;
        }

        .input-group-custom {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-group-custom i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            transition: 0.3s;
            z-index: 10;
        }

        .form-control {
            height: 52px;
            padding-left: 45px;
            border-radius: 12px;
            border: 1.5px solid #e2e8f0;
            background: #f8fafc;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: #fff;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .form-control:focus + i {
            color: var(--primary-color);
        }

        .btn-login {
            height: 52px;
            background: var(--primary-color);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-login:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
        }

        .forgot-password {
            font-size: 0.85rem;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .register-link {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.9rem;
            color: #64748b;
        }

        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 700;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="brand-logo">
            <i class="fa-solid fa-shield-halved"></i>
        </div>

        <div class="login-header text-center mb-4">
            <h2>Welcome Back</h2>
            <p class="text-muted small">Enter your credentials to access <b>Classare</b></p>
        </div>

        <%
                        String error = request.getParameter("error");
                        if (error != null) {
                    %>
                        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert" style="border-radius: 12px;">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>
                            <%
                                if (error.equals("invalid")) {
                                    out.print("Invalid email or password.");
                                } else if (error.equals("inactive")) {
                                    out.print("This account is currently inactive.");
                                } else {
                                    out.print("An unexpected error occurred. Please try again.");
                                }
                            %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <%
                    }
        %>

        <form action="login" method="POST">
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group-custom">
                    <i class="fa-regular fa-envelope"></i>
                    <input type="email" name="email" class="form-control" placeholder="name@company.com" required>
                </div>
            </div>

            <div class="mb-2">
                <div class="d-flex justify-content-between">
                    <label class="form-label">Password</label>
                    <a href="#" class="forgot-password">Forgot?</a>
                </div>
                <div class="input-group-custom">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" class="form-control" placeholder="password" required>
                </div>
            </div>

            <div class="mb-4 form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe">
                <label class="form-check-label small text-muted" for="rememberMe">Remember this device</label>
            </div>

            <button type="submit" class="btn btn-login w-100">
                Sign In <i class="fa-solid fa-arrow-right-to-bracket"></i>
            </button>
        </form>

        <div class="register-link">
            Don't have an account? <br>
            <a href="register-student">Join as Student</a> or <a href="register-instructor">Instructor</a>
        </div>
    </div>
</div>
</body>
</html>
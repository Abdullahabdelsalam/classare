<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.classare.model.User" %>
<%@ page import="com.classare.model.Person" %>
<%
    // Security Check: Verify Admin Access
    User user = (User) session.getAttribute("user");
    if(user == null || !user.hasRole("ADMIN")) {
        response.sendRedirect("../login.jsp");
        return;
    }
    Person person = user.getPerson();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Provisioning | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --admin-dark: #0f172a;
            --admin-primary: #4f46e5;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }

        .admin-card {
            background: white;
            border-radius: 28px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 550px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }

        .card-header-custom {
            background: var(--admin-dark);
            padding: 2.5rem;
            text-align: center;
            color: white;
        }

        .card-header-custom i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #818cf8;
        }

        .form-container {
            padding: 2.5rem 3rem;
        }

        .form-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #64748b;
            letter-spacing: 0.5px;
        }

        .form-control {
            border-radius: 12px;
            padding: 0.8rem 1rem;
            border: 1.5px solid #e2e8f0;
            background-color: #f8fafc;
            transition: 0.3s;
        }

        .form-control:focus {
            background-color: white;
            border-color: var(--admin-primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .btn-admin {
            background: var(--admin-dark);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 1rem;
            font-weight: 700;
            width: 100%;
            transition: 0.3s;
            margin-top: 1rem;
        }

        .btn-admin:hover {
            background: #1e293b;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .security-note {
            background: #fff7ed;
            border: 1px solid #fed7aa;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 2rem;
            display: flex;
            gap: 12px;
            align-items: center;
        }
    </style>
</head>
<body>

<div class="admin-card">
    <div class="card-header-custom">
        <i class="fa-solid fa-user-shield"></i>
        <h3 class="fw-bold mb-0">System Provisioning</h3>
        <p class="small opacity-75 mt-2">Create a new Administrator account for Classare</p>
    </div>

    <div class="form-container">
        <div class="security-note">
            <i class="fa-solid fa-shield-halved text-warning fs-4"></i>
            <p class="small text-warning-emphasis mb-0">
                <strong>Important:</strong> Administrators have full access to system settings and user data.
            </p>
        </div>

        <form action="register-admin" method="post">
            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label">First Name</label>
                    <input type="text" name="first_name" class="form-control" placeholder="Admin First Name" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Last Name</label>
                    <input type="text" name="last_name" class="form-control" placeholder="Admin Last Name" required>
                </div>

                <div class="col-12">
                    <label class="form-label">Official Email</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-envelope text-muted"></i></span>
                        <input type="email" name="email" class="form-control border-start-0 ps-0" placeholder="admin@classare.com" required>
                    </div>
                </div>

                <div class="col-12">
                    <label class="form-label">Security Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-key text-muted"></i></span>
                        <input type="password" name="password" class="form-control border-start-0 ps-0" placeholder="••••••••" required>
                    </div>
                </div>

                <div class="col-12 mt-5">
                    <button type="submit" class="btn btn-admin">
                        <i class="fa-solid fa-plus-circle me-2"></i> Register Admin Account
                    </button>
                    <div class="text-center mt-3">
                        <a href="dashboard.jsp" class="text-muted small text-decoration-none">
                            <i class="fa-solid fa-arrow-left me-1"></i> Back to Control Panel
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
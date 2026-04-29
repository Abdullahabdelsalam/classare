<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --success-color: #10b981;
            --primary-color: #6366f1;
        }

        body {
            background: radial-gradient(circle at center, #ffffff 0%, #f1f5f9 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Plus Jakarta Sans', sans-serif;
            margin: 0;
        }

        .success-card {
            background: white;
            padding: 4rem 3rem;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.08);
            text-align: center;
            max-width: 480px;
            width: 90%;
            border: 1px solid #f1f5f9;
        }

        /* Success Animation */
        .icon-container {
            width: 100px;
            height: 100px;
            background: #ecfdf5;
            color: var(--success-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            margin: 0 auto 2rem;
            position: relative;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4); }
            70% { box-shadow: 0 0 0 20px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        .title {
            color: #1e293b;
            font-weight: 800;
            font-size: 1.75rem;
            margin-bottom: 1rem;
        }

        .description {
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 2.5rem;
        }

        .btn-login {
            background: var(--primary-color);
            color: white;
            border-radius: 16px;
            padding: 1rem 2.5rem;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            border: none;
            width: 100%;
        }

        .btn-login:hover {
            background: var(--primary-dark);
            color: #2563eb;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
        }

        .brand-text {
            position: absolute;
            top: 40px;
            font-weight: 800;
            color: var(--primary-color);
            text-decoration: none;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>

    <a href="index.jsp" class="brand-text text-decoration-none">Classare</a>

    <div class="success-card">
        <div class="icon-container">
            <i class="fa-solid fa-check"></i>
        </div>

        <h2 class="title">You're all set!</h2>

        <p class="description">
            Your <strong>Classare</strong> account has been created successfully.
            We're excited to have you on board! You can now log in and start your journey.
        </p>

        <a href="<%=request.getContextPath()%>/login.jsp" class="btn btn-login">
            Continue to Login
            <i class="fa-solid fa-arrow-right"></i>
        </a>

        <div class="mt-4">
            <small class="text-muted">Need help? <a href="<%=request.getContextPath()%>/index.jsp" class="text-decoration-none fw-bold">Contact Support</a></small>
        </div>
    </div>

</body>
</html>
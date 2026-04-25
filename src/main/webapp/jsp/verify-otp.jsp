<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    String email = (String) session.getAttribute("email");

    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify Identity | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --accent: #6366f1; --bg: #f8fafc; }
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .verify-card {
            background: white;
            padding: 3rem;
            border-radius: 30px;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.05);
            max-width: 450px;
            width: 100%;
            text-align: center;
            border: 1px solid #e2e8f0;
        }

        .icon-box {
            width: 70px;
            height: 70px;
            background: #eef2ff;
            color: var(--accent);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
        }

        .email-display {
            background: #f1f5f9;
            padding: 0.5rem 1rem;
            border-radius: 10px;
            color: #475569;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-block;
            margin-bottom: 2rem;
        }

        .otp-input {
            letter-spacing: 0.5rem;
            font-size: 1.5rem;
            font-weight: 800;
            text-align: center;
            border-radius: 15px;
            padding: 1rem;
            border: 2px solid #e2e8f0;
            background: #f8fafc;
            transition: 0.3s;
        }

        .otp-input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            background: white;
        }

        .btn-verify {
            background: var(--accent);
            color: white;
            border: none;
            border-radius: 15px;
            padding: 1rem;
            font-weight: 700;
            width: 100%;
            margin-top: 1.5rem;
            transition: 0.3s;
        }

        .btn-verify:hover {
            background: #4f46e5;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px rgba(99, 102, 241, 0.2);
        }

        .resend-link {
            text-decoration: none;
            color: var(--accent);
            font-weight: 700;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="verify-card">
    <div class="icon-box">
        <i class="fa-solid fa-shield-halved"></i>
    </div>

    <h2 class="fw-800 mb-2">Two-Step Verification</h2>
    <p class="text-muted small mb-3">We've sent a verification code to your email address.</p>

    <div class="email-display">
        <i class="fa-regular fa-envelope me-2"></i> <%= email %>
    </div>

    <form action="verify-otp" method="post">
        <input type="hidden" name="email" value="<%= email %>">

        <div class="mb-4 text-start">
            <label class="form-label fw-bold small ms-1 text-muted">Enter 6-Digit Code</label>
            <input type="text"
                   name="otp"
                   class="form-control otp-input"
                   placeholder="000000"
                   maxlength="6"
                   required
                   autocomplete="one-time-code">
        </div>

        <button type="submit" class="btn-verify">
            Verify & Activate <i class="fa-solid fa-arrow-right ms-2"></i>
        </button>
    </form>

    <div class="mt-4">
        <p class="small text-muted mb-0">Didn't receive the code?</p>
        <a href="resend-otp" class="resend-link">Resend New OTP</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
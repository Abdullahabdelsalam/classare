<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Registration | Classare</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #6366f1;
            --dark-navy: #0f172a;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            background-image: radial-gradient(#e2e8f0 0.5px, transparent 0.5px);
            background-size: 24px 24px;
            color: var(--dark-navy);
        }

        .registration-card {
            background: #ffffff;
            border: none;
            border-radius: 32px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .header-accent {
            background: var(--dark-navy);
            color: #fff;
            padding: 3.5rem 2rem;
            text-align: center;
            position: relative;
        }

        .header-accent::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 10px;
            background: linear-gradient(to right, var(--primary-color), #818cf8);
        }

        .form-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748b;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .input-group-text {
            background: #f8fafc;
            border-right: none;
            color: #94a3b8;
            border-radius: 12px 0 0 12px;
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.75rem 1rem;
            border: 1.5px solid #e2e8f0;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        .btn-register {
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 14px;
            font-weight: 800;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3);
        }

        .btn-register:hover {
            background: #4f46e5;
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgba(99, 102, 241, 0.4);
        }

        .section-title {
            font-size: 0.9rem;
            font-weight: 800;
            color: var(--primary-color);
            border-bottom: 2px solid #eef2ff;
            padding-bottom: 10px;
            margin-bottom: 20px;
            margin-top: 10px;
        }
    </style>
</head>

<body class="py-5">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-xl-8 col-lg-10">
            <div class="registration-card">

                <div class="header-accent">
                    <h2 class="fw-extrabold mb-2">Create Instructor Account</h2>
                    <p class="opacity-75 mb-0">Join <span class="fw-bold">Classare</span> ecosystem and start teaching</p>
                </div>

                <div class="p-4 p-md-5">

                    <% String error = (String) request.getAttribute("error");
                       if (error != null) { %>
                        <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> <%= error %>
                        </div>
                    <% } %>

                    <form action="register-instructor" method="POST">

                        <div class="row g-4">
                        <div class="col-12"><div class="section-title">PERSONAL INFORMATION</div></div>

                        <div class="col-md-6">
                            <label class="form-label"><i class="fa-solid fa-user small"></i> First Name</label>
                            <input type="text" name="firstName" class="form-control" placeholder="First Name" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastName" class="form-control" placeholder="Last Name" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label"><i class="fa-solid fa-calendar-days small"></i> Date of Birth</label>
                            <input type="date" name="birthDate" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label"><i class="fa-solid fa-id-card small"></i> National ID</label>
                            <input type="text" name="nationalId" class="form-control" placeholder="123-456-789" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label"><i class="fa-solid fa-venus-mars small"></i> Gender</label>
                            <select name="gender" class="form-select" required>
                                <option value="" selected disabled>Choose...</option>
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                            </select>
                        </div>

                            <div class="col-12"><div class="section-title">ACCOUNT SECURITY</div></div>

                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-envelope small"></i> Email Address</label>
                                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-lock small"></i> Password</label>
                                <input type="password" name="password" class="form-control" placeholder="Min. 8 characters" required minlength="8">
                            </div>

                            <div class="col-12"><div class="section-title">PROFESSIONAL DETAILS</div></div>

                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-phone small"></i> Phone Number</label>
                                <input type="text" name="phone" class="form-control" placeholder="+20 123 456 7890">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label"><i class="fa-solid fa-location-dot small"></i> Office Address</label>
                                <input type="text" name="address" class="form-control" placeholder="City, Street, Building">
                            </div>

                            <div class="col-12">
                                <label class="form-label"><i class="fa-solid fa-book-open small"></i> Specialization / Subject</label>
                                <input type="text" name="specialization" class="form-control"
                                       placeholder="e.g. Advanced Mathematics, Quantum Physics">
                            </div>

                            <div class="col-12 mt-5">
                                <button type="submit" class="btn btn-register w-100">
                                    <i class="fa-solid fa-check-double me-2"></i>
                                    Complete Registration
                                </button>

                                <p class="text-center mt-4 mb-0">
                                    <small class="text-muted">
                                        Already a member of Classare?
                                        <a href="login.jsp" class="fw-bold text-primary text-decoration-none ms-1">Sign In</a>
                                    </small>
                                </p>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
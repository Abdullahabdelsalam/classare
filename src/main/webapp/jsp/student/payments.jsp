    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.*" %>
    <%@ page import="com.classare.model.*" %>
    <%@ page import="com.classare.dao.*" %>

    <%
        User user = (User) session.getAttribute("user");
        if (user == null || !user.hasRole("STUDENT")) {
            response.sendRedirect("../login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        PaymentDAO dao = new PaymentDAO();

        List<Map<String, Object>> payments = null;
        if (student != null) {
            payments = dao.getStudentPayments(student.getId());
        }

        String msg = request.getParameter("msg");
    %>

    <!DOCTYPE html>
    <html lang="en" dir="ltr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Billing & Payments | Classare</title>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root { --accent: #6366f1; --student-bg: #f8fafc; --success: #10b981; }
            body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--student-bg); color: #1e293b; }

            .main-container { padding: 3rem 1.5rem; max-width: 900px; margin: 0 auto; }

            /* Header & Navigation */
            .back-link { color: #64748b; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: 0.3s; }
            .back-link:hover { color: #0f172a; }
            .page-title { font-weight: 800; font-size: 2.2rem; color: #0f172a; letter-spacing: -1px; }

            /* Transaction Card Styling */
            .billing-card {
                background: white;
                border-radius: 24px;
                border: 1px solid #e2e8f0;
                box-shadow: 0 4px 15px rgba(0,0,0,0.02);
                overflow: hidden;
            }

            .table-billing { margin-bottom: 0; }
            .table-billing thead th {
                background: #f8fafc;
                color: #64748b;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 1.2rem 1.5rem;
                border-bottom: 1px solid #e2e8f0;
            }
            .table-billing tbody td {
                padding: 1.2rem 1.5rem;
                vertical-align: middle;
                border-bottom: 1px solid #f1f5f9;
            }

            /* Status Badges */
            .status-paid {
                background: #ecfdf5;
                color: #10b981;
                padding: 5px 14px;
                border-radius: 10px;
                font-weight: 700;
                font-size: 0.75rem;
                border: 1px solid #a7f3d0;
            }
            .status-pending {
                background: #fffbeb;
                color: #f59e0b;
                padding: 5px 14px;
                border-radius: 10px;
                font-weight: 700;
                font-size: 0.75rem;
                border: 1px solid #fde68a;
            }

            .amount-text { font-weight: 800; color: #0f172a; }
            .date-text { font-size: 0.85rem; color: #64748b; }
            .course-text { font-weight: 700; color: #334155; }

            /* Summary Header Card */
            .summary-header {
                background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
                border-radius: 24px;
                padding: 2rem;
                color: white;
                margin-bottom: 2.5rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
        </style>
    </head>
    <body>

    <div class="main-container">

        <div class="mb-4">
            <a href="dashboard.jsp" class="back-link">
                <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
            </a>
        </div>

        <header class="mb-5">
            <h1 class="page-title">Billing & Payments 💳</h1>
            <p class="text-muted">Review your transaction history and payment status for enrolled courses.</p>
        </header>

        <% if ("success".equals(msg)) { %>
            <div class="alert alert-success alert-dismissible fade show rounded-4 border-0 shadow-sm d-flex align-items-center mb-4" role="alert">
                <i class="fa-solid fa-circle-check fs-4 me-3"></i>
                <div>
                    <strong class="d-block">Payment Successful</strong>
                    <span class="small">Your transaction has been processed and your account is updated.</span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="summary-header shadow-sm">
            <div class="d-flex align-items-center gap-3">
                <div class="bg-white bg-opacity-10 p-3 rounded-4">
                    <i class="fa-solid fa-receipt fs-2"></i>
                </div>
                <div>
                    <p class="mb-0 opacity-75 small fw-bold">Billing History</p>
                    <h4 class="mb-0 fw-800">Financial Records</h4>
                </div>
            </div>
            <div class="text-end">
                <i class="fa-brands fa-cc-visa fs-1 opacity-25"></i>
            </div>
        </div>

        <% if (payments == null || payments.isEmpty()) { %>
            <div class="text-center p-5 bg-white rounded-5 border border-dashed">
                <div class="text-muted mb-3"><i class="fa-solid fa-credit-card fs-1 opacity-20"></i></div>
                <h5 class="fw-bold">No Payments Yet</h5>
                <p class="text-muted small mb-0">Your payment history will appear here once you enroll in paid courses.</p>
            </div>
        <% } else { %>

        <div class="billing-card">
            <div class="table-responsive">
                <table class="table table-billing">
                    <thead>
                        <tr>
                            <th>Course Description</th>
                            <th>Date</th>
                            <th>Amount</th>
                            <th class="text-end">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, Object> p : payments) { %>
                        <tr>
                            <td>
                                <div class="course-text"><%= p.get("course") %></div>
                                <div class="small text-muted">Academic Program</div>
                            </td>
                            <td>
                                <span class="date-text">
                                    <i class="fa-regular fa-calendar-check me-1"></i> <%= p.get("date") %>
                                </span>
                            </td>
                            <td>
                                <span class="amount-text">$<%= p.get("amount") %></span>
                            </td>
                            <td class="text-end">
                                <% if ("PAID".equals(p.get("status"))) { %>
                                    <span class="status-paid"><i class="fa-solid fa-check me-1"></i> Paid</span>
                                <% } else { %>
                                    <span class="status-pending"><i class="fa-solid fa-clock me-1"></i> Pending</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="mt-4 p-3 bg-light rounded-4 d-flex align-items-center gap-3">
            <i class="fa-solid fa-shield-halved text-muted fs-4"></i>
            <p class="small text-muted mb-0">All transactions in <strong>Classare</strong> are encrypted and secured using industry standards.</p>
        </div>

        <% } %>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
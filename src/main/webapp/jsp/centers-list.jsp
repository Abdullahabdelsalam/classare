<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>Center Management</title>
    <style>
        body { font-family: sans-serif; margin: 20px; line-height: 1.6; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: right; }
        th { background-color: #f4f4f4; }
        form { margin-bottom: 30px; background: #fafafa; padding: 15px; border-radius: 5px; }
        input, select, button { padding: 8px; margin: 5px; }
    </style>
</head>
<body>

    <h2>Add New Center</h2>
    <form action="centers" method="post">
        <input type="text" name="name" placeholder="Center Name" required>
        <input type="text" name="address" placeholder="Address">
        <input type="text" name="phone" placeholder="Phone Number">
        <select name="type">
            <option value="SCHOOL">School</option>
            <option value="UNIVERSITY">University</option>
        </select>
        <button type="submit" style="background-color: #28a745; color: white; border: none; cursor: pointer;">Save Center</button>
    </form>

    <hr>

    <h2>Registered Centers List</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Type</th>
                <th>Phone</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty centersList}">
                    <c:forEach var="center" items="${centersList}">
                        <tr>
                            <td>${center.id}</td>
                            <td><c:out value="${center.name}" /></td>
                            <td><c:out value="${center.type}" /></td>
                            <td><c:out value="${center.phone}" /></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="4" style="text-align:center;">No centers found.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

</body>
</html>
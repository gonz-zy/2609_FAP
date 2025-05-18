<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("username") == null || !"A".equals(session.getAttribute("role"))) {
        response.sendRedirect("error.jsp?msg=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Course</title>
</head>
<body>
    <h2>Add New Course</h2>

    <form action="/FAP/AddCourseServlet" method="post">
        <label>Course ID:</label><br>
        <input type="text" name="courseId" required><br><br>

        <label>Admin Username:</label><br>
        <input type="text" name="username" value="<%= session.getAttribute("username") %>" readonly><br><br>

        <label>Course Description:</label><br>
        <textarea name="description" required></textarea><br><br>

        <label>Hours:</label><br>
        <input type="number" name="hours" min="1" value="1" required><br><br>

        <label>Price:</label><br>
        <input type="number" name="price" min="1" max="99999999.99" step="0.01" value="1" required><br><br>

        <input type="submit" value="Add Course">
    </form>
</body>
</html>
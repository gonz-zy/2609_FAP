<%-- 
    Document   : adminEdit
    Created on : 05 17, 25, 1:06:08 PM
    Author     : franc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Course Details</title>
    </head>
    <body>
        <h1>Please enter the details to be edited for <%= request.getParameter("courseId") %>.</h1>
        <form method="post" action="/FAP/EditCourseServlet">
            <input type="hidden" id="courseId" name="courseId" value=<%= request.getParameter("courseId") %>
                   
            <label for="professor">Professor:</label>
            <input type="text" id="professor" name="professor" maxlength="20" required>
            
            <label for="description">Description of Course:</label>
            <textarea id="description" name="description" rows='4' cols='50' required>
                The official course site for <%= request.getParameter("courseId") %>.
            </textarea>
            
            <label for="hours">Number of Hours:</label>
            <input type="number" id="hours" name="hours" min="1" value="1" required>
            
            <label for="price">Price of Enrollment:</label>
            <input type="number" id="price" name="price" min="1" max="99999999" value="1" step="0.01" required>
            
            <button type="submit">Update Details</button>
        </form>
    </body>
</html>
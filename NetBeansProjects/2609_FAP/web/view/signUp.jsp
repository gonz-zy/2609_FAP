<%-- 
    Document   : signUp.jsp
    Created on : 05 17, 25, 8:48:24 PM
    Author     : franc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create an Account</title>
    </head>
    <body>
        <h1>Please enter the necessary details:</h1>
        <form method="post" action="/FAP/SignUpServlet">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" maxlength="20" required>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="password" maxlength="20" required>
            
            <label for="firstname">First Name</label>
            <input type="text" id="firstname" name="firstname" maxlength="10" required>
            
            <label for="lastname">Last Name</label>
            <input type="text" id="lastname" name="lastname" maxlength="10" required>
            
            <fieldset>
                <legend>Role</legend>
                <label for="admin">Admin</label>
                <input type="radio" id="admin" name="role" value="admin">
                <label for="student">Student</label>
                <input type="radio" id="student" name="role" value="student" checked="checked">
            </fieldset>
            
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
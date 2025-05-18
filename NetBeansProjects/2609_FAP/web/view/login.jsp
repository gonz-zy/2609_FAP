<%-- 
    Document   : index
    Created on : 05 15, 25, 2:47:34 PM
    Author     : franc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <form action="/FAP/LoginServlet" method="post">
    <label for="username">Username:</label>
    <input type="text" name="username" id="username" required>

    <label for="password">Password:</label>
    <input type="password" name="password" id="password" required>

    <div class="g-recaptcha"
         data-sitekey="6LcF3fsqAAAAAD8SdWJzzJlpIOitZI8OV9wD5r8_"
         data-callback="enableSubmitBtn"></div>

    <input type="submit" id="submitBtn" value="Login" disabled>
</form>
        <p>Don't have an account? <a href="/FAP/view/signUp.jsp">Create one</a>.</p>

<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script>
    function enableSubmitBtn() {
        document.getElementById("submitBtn").disabled = false;
    }
</script>

    </body>
</html>
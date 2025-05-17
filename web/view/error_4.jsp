<%-- 
    Document   : error_4
    Created on : 05 15, 25, 2:56:22 PM
    Author     : iange
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page not Found</title>
        <style>
            body {
                background-color: #fff4ee;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                text-align: center;
                margin: 0;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
            }
            
            #image1 {
                max-width:100%;
                width:20%;
                height: auto;
                margin-bottom:  0px;
            }
            
            .error {
                color: #d9534f;
                margin-bottom: 10px;
            }
            
            .btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #ff8a4b;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin-top: 20px;
                transition: background-color 0.3s;
            }
            
            .btn:hover {
                background-color: #ff6e21;
            }
        </style>
    </head>
    <body>
        <img src="../images/404.png" id="image1" />
         <h2 class="error">Error 404: Page Not Found.</h2>
        <p>The page you're looking for does not exist.</p>
        <a href="<%= request.getContextPath() %>/view/index.jsp" class="btn">Back to Login</a>
    </body>
</html>
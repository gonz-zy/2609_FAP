<%-- 
    Document   : success
    Created on : May 17, 2025, 5:24:56 PM
    Author     : mirai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Success Page</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            body {
                background-color: #fff4ee;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                text-align: center;
            }
            
            .success-icon {
                width: 670px;
                height: 450px;
                margin-bottom: 10px;
                object-fit: contain;
            }
            
            .success-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                padding: 40px;
                max-width: 500px;
                width: 90%;
            }
            
            .success-message {
                color: #333;
                font-size: 24px;
                margin-bottom: 30px;
                font-weight: 600;
            }
            
            .back-button {
                display: inline-block;
                padding: 12px 30px;
                background-color: #ff8a4b;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 500;
                transition: background-color 0.3s;
            }
            
            .back-button:hover {
                background-color: #ff6e21;
            }
        </style>
    </head>
    <body>
        <!-- Success Icon placed outside the container -->
        <img src="../images/sucr.png" alt="Success Icon" class="success-icon">
            <a href="" class="button">Back to </a>
            <div class="success-message"><h1><%=(request.getAttribute("successMessage")).toString() %></h1></div>
            <a href="<%=(request.getAttribute("jspPath")).toString() %>" class="back-button">Back to <%=(request.getAttribute("pageName")).toString() %></a>
        
    </body>
</html>
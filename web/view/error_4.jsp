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
                font-family: Arial, sans-serif;
                text-align: center;
                margin: 0;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
            }
            
            #iamge1 {
                max-width: 100%;
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
                background-color: #5bc0de;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin-top: 20px;
                transition: background-color 0.3s;
            }
            
            .btn:hover {
                background-color: #31b0d5;
            }
        </style>
    </head>
    <body>
        <img src=https://media.discordapp.net/attachments/734345741090160701/1372477827965779988/cropped_404.png?ex=6826eb15&is=68259995&hm=16bea891f9ccdfcc0c52bf3ffc5a483c5bc9b05187a1645ab85f6e9e3d758883&=&format=webp&quality=lossless&width=348&height=428x id=image1/>
        <h2 class="error">Error 404: Page Not Found.</h2>
        <p>The page you're looking for does not exist.</p>
        <a href="<%= request.getContextPath() %>/view/index.jsp" class="btn">Back to Login</a>
    </body>
</html>
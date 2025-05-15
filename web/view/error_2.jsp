<%-- 
    Document   : error_2
    Created on : 05 15, 25, 2:56:02 PM
    Author     : iange
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error2</title>
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
        <img src=https://media.discordapp.net/attachments/734345741090160701/1372481348689989662/error2.png?ex=6826ee5c&is=68259cdc&hm=b3afc2160c77cf254b3c380bd24492ee5c492bd85c442e7366f0b92b90124891&=&format=webp&quality=lossless&width=473&height=521 id=image1 />
         <h2 class="error">Error: Incorrect password for this username.</h2>
        <p>Please enter the correct password.</p>
        <a href="index.jsp" class="btn">Back to Login</a>
    </body>
</html>

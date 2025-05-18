<%-- 
    Document   : adminEdit
    Created on : May 17, 2025, 3:21:21 PM
    Author     : mirai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Course Details</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                background-color: #fff4ee;
            }

            .header {
                text-align: left;
                width: 100%;
                max-width: 800px;
                margin-bottom: 20px;
            }

            h1 {
                font-size: 40px;
                font-weight: bold;
                margin: 0;
            }

            .container {
                width: 90%;
                max-width: 800px;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .form-section {
                flex: 1 1 300px;
                min-width: 300px;
            }

            .image-section {
                flex: 1 1 300px;
                min-width: 300px;
                background-color: white;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
                font-size: 14px;
                border-radius: 8px;
                height: auto;
                aspect-ratio: 16 / 9;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                margin-bottom: 15px;
            }

            label {
                font-weight: bold;
                margin-bottom: 5px;
            }

            input[type="text"], input[type="number"], textarea {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }

            textarea {
                resize: none;
            }

            button {
                padding: 10px 15px;
                font-size: 14px;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                background-color: #ff8a4b;
                width:100%;
            }
            button:hover{
                background-color: #ff6e21;
            }
            #image1{
                width:100%;
                height:auto;
            }
            
            .main-container {
                max-width: 1536px;
                margin-left: auto;
                margin-right: auto;
                padding-left: 0.5rem;
                padding-right: 0.5rem;
                width:100%;
                display: flex;
                justify-content: center;
                align-items: center;
              }
            
             /* 2xl */
            @media (max-width: 1536px) {
              .main-container {
                  max-width: 1280px;
              }
            }

            /* xl */
            @media (max-width: 1280px) {
              .main-container  {
                max-width: 1024px;
              }
            }

            @media (max-width: 1024px) {
              .main-container {
                max-width: 820px;
              }
              .header{
                  margin-left:25px;
              }
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Edit Course Details</h1>
        </div>
        <section class="main-container">
        <div class="container">
            <div class="form-section">
                <form method="post" action="/FAP/EditCourseServlet">
                    <input type="hidden" id="courseId" name="courseId" value="<%= request.getAttribute("courseId") %>">

                    <div class="form-group">
                        <label for="professor">Professor:</label>
                        <input type="text" id="professor" name="professor" maxlength="20" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description of Course:</label>
                        <textarea id="description" name="description" rows="4" cols="50" required>
The official course site for <%= request.getAttribute("courseId") %>.
                        </textarea>
                    </div>

                    <div class="form-group">
                        <label for="hours">Number of Hours:</label>
                        <input type="number" id="hours" name="hours" min="1" value="1" required>
                    </div>

                    <div class="form-group">
                        <label for="price">Price of Enrollment:</label>
                        <input type="number" id="price" name="price" min="1" max="99999999" value="1" step="0.01" required>
                    </div>

                    <button type="submit">Update Details</button>
                </form>
            </div>
            <div class="image-section">
                <img src="../images/edit.jpg" id="image1"/>
            </div>
        </div>
        </section>
    </body>
</html>

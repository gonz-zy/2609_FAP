<%-- 
    Document   : adminAdd
    Created on : May 17, 2025, 3:06:12 PM
    Author     : mirai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Course</title>
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
                max-width: 900px;
                margin-bottom: 20px;
            }

            h1 {
                font-size: 40px;
                font-weight: bold;
                margin: 0;
            }

            .container {
                width: 100%;
                max-width: 900px;
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
                width: 100%;
            }

            textarea {
                resize: none;
                height: 120px;
            }

            button {
                padding: 10px 15px;
                font-size: 14px;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                background-color: #ff8a4b;
                width: 104%;
            }
            
            button:hover {
                background-color: #ff6e21;
            }
            
            #image1 {
                width: 105%;
                height: 80%;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Add New Course</h1>
        </div>
        <div class="container">
            <div class="form-section">
                <form method="post" action="/FAP/AddCourseServlet">
                    <div class="form-group">
                        <label for="courseId">Course ID:</label>
                        <input type="text" id="courseId" name="courseId" required>
                    </div>

                    <div class="form-group">
                        <label for="username">Admin Username:</label>
                        <input type="text" id="username" name="username" value="usernamex" readonly>
                    </div>

                    <div class="form-group">
                        <label for="description">Course Description:</label>
                        <textarea id="description" name="description" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="hours">Hours:</label>
                        <input type="number" id="hours" name="hours" min="1" value="1" required>
                    </div>

                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="number" id="price" name="price" min="1" max="99999999.99" step="0.01" value="1" required>
                    </div>

                    <button type="submit">Add Course</button>
                </form>
            </div>
            <div class="image-section">
                <img src="../images/clipart22.png" id="image1"/>
            </div>
        </div>
    </body>
</html>
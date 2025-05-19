<%-- 
    Document   : adminAdd
    Created on : May 17, 2025, 3:06:12 PM
    Author     : mirai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        return;
    }
    String username = (String) session.getAttribute("username");
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add New Course</title>
    <style>
        /* Reset and base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #fff4ee;
            min-height: 100vh;
        }

        .img {
            max-width: 100px;
            height: auto;
        }

        /* Navigation Container */
        .hero-container {
            max-width: 1536px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 0.5rem;
            padding-right: 0.5rem;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1rem 0rem 1rem 0rem;
        }

        .left {
            width: 60%;
        }

        .right {
            display: flex;
            flex-direction: row;
            width: 40%;
            height: auto;
            justify-content: flex-end;
            align-items: center;
            gap: 5rem;
        }

        /* Header (nav bar) */
        .start {
            background-color: rgb(40,36,36);
            height: 100px;
            margin-bottom: 2rem;
            top: 0;
        }

        .start h1 {
            color: white;
        }

        .header {
            display: flex;
            flex-direction: row;
            width: 95%;
            height: auto;
            justify-content: space-between;
            align-items: center;
        }

        .logout-button {
            background-color: rgba(235,90,2,255);
            border: none;
            color: white;
            padding: 10px 30px;
            font-size: 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: bold;
        }

        .logout-button:hover {
            background-color: #d24d00;
        }

        /* Main container */
        .main-container {
            max-width: 1536px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 0.5rem;
            padding-right: 0.5rem;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Course add container */
        .container {
            width: 90%;
            max-width: 900px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
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

        /* Form elements */
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
            border-radius: 6px;
            cursor: pointer;
            background-color: rgba(235,90,2,255);
            width: 104%;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #d24d00;
        }

        #image1 {
            width: 105%;
            height: 80%;
        }

        h1.add-course-title {
            font-size: 40px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .image-section {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .submit-button {
            width: 100%;
            padding: 10px 0;
            font-size: 14px;
            font-weight: 600;
            color: white;
            background-color: #007bff; /* Blue */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-button:hover {
            background-color: #0056b3;
        }

        .back-button {
            width: 100%;
            padding: 10px 0;
            font-size: 14px;
            font-weight: 600;
            color: white;
            background-color: rgba(235,90,2,255); /* Orange */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 0.5rem;
        }

        .back-button:hover {
            background-color: #d24d00;
        }

        .image-section {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            flex: 1 1 300px;
            min-width: 300px;
        }


        /* Responsive adjustments */
        @media (max-width: 1536px) {
            .main-container {
                max-width: 1280px;
            }
            .hero-container {
                max-width: 1280px;
            }
        }

        @media (max-width: 1280px) {
            .main-container {
                max-width: 1024px;
            }
            .hero-container {
                max-width: 1024px;
            }
        }

        @media (max-width: 1024px) {
            .main-container {
                max-width: 820px;
            }
            .hero-container {
                max-width: 820px;
            }
            .header {
                margin-left: 0;
            }
            .right {
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="start">
        <section class="hero-container">
            <nav class="header">
                <div class="left">
                    <img src="https://activelearning.ph/wp-content/uploads/2021/03/logo-white.png" alt="Logo" class="img" />
                </div>
                <div class="right">
                    <div>
                        <h1>Welcome <%= firstName %> <%= lastName %></h1>
                    </div>
                    <form action="/2609_FAP/LogoutServlet" method="post">
                        <button class="logout-button" type="submit">Logout</button>
                    </form>
                </div>
            </nav>
        </section>
    </div>                    

    <section class="main-container">
        <div class="container">
            <!-- Left Side -->
            <div class="form-section">
                <form method="post" action="/2609_FAP/AddCourseServlet">
                    <div class="form-group">
                        <label for="courseId">Course ID:</label>
                        <input type="text" id="course_id" name="course_id" maxlength="7" required />
                    </div>
                    <div class="form-group">
                        <label for="courseName">Course Name:</label>
                        <input type="text" id="courseName" name="courseName" maxlength="30" required />
                    </div>
                    <div class="form-group">
                        <label for="username">Admin Username:</label>
                        <input type="text" id="username" name="username" value="<%=username%>" readonly />
                    </div>
                    <div class="form-group">
                        <label for="description">Course Description:</label>
                        <textarea id="description" name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="hours">Hours:</label>
                        <input type="number" id="hours" name="hours" min="1" value="1" required />
                    </div>
                    <div class="form-group">
                        <label for="price">Price (₱):</label>
                        <input type="number" id="price" name="price" min="1" max="99999999.99" step="0.01" value="1" required />
                    </div>
                    <div class="form-group">
                        <button type="submit" class="submit-button">Add Course</button>
                    </div>
                </form>
            </div>

            <!-- Right Side -->
            <div class="image-section">
                <img src="../images/clipart22.png" id="image1" alt="Course Illustration" />
                <a href="<%= request.getContextPath() %>/view/home.jsp" style="width: 100%;">
                    <button type="button" class="back-button">Back to Home</button>
                </a>
            </div>
        </div>


    </section>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Your Account</title>
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
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .container {
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
          .container {
              max-width: 1280px;
          }
        }

        /* xl */
        @media (max-width: 1280px) {
          .container {
            max-width: 1024px;
          }
          .break-after {
            display: block;
          }
        }
        
        @media (max-width: 1024px) {
          .container {
            max-width: 820px;
          }
          .main-container{
               max-width: 820px;
          }
        }
        
        .main-container {
            display: flex;
            width: 90%;
            height: 90vh;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            flex-wrap: wrap;
        }
        
        .left-section {
            flex: 1;
            background-color: #fff4ee;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
            text-align: center;
        }
        
        .welcome-text {
            color: #333;
            font-size: 28px;
            font-weight: 600;
        }
        
        .left-section img {
            max-width: 90%;
            height: auto;
            max-height: 90%;
            border-radius: 8px;
            object-fit: cover;
        }
        
        .right-section {
            flex: 1 1 0;
            padding: 4vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100%;
            min-height: 0;
            overflow: hidden;
        }
        
        .greeting-image {
            width: 100%;
            height: auto;
            max-width:250px;
            border-radius: 50%;
            object-fit: cover;
            align-self: center;
            margin-bottom: 20px;
        }
        
        .signup-title {
            color: #333;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 10px;
            text-align: center;
        }
        
        .signup-subtitle {
            text-align: center;
            color: #666;
            font-size: 16px;
            margin-bottom: 10px;
        }
        
        form {
            width: 100%;
        }
        
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #555;
            font-weight: 500;
            font-size: 16px;
        }
        
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus {
            border-color: #4CAF50;
            outline: none;
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }
        
        .radio-option {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 16px;
            color: #555;
            cursor: pointer;
        }
        
        .radio-option input {
            cursor: pointer;
            width: 18px;
            height: 18px;
        }
        
        button[type="submit"] {
            width: 100%;
            padding: 15px;
            background-color: #ff8a4b;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        button[type="submit"]:hover {
            background-color: #ff6e21;
        }
        
        .create-account {
            color: #666;
            font-size: 16px;
            text-align: center;
            margin-top: 30px;
        }
        
        .create-account a {
            color: #ff8a4b;
            text-decoration: none;
            font-weight: 500;
        }
        
        .create-account a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <section class="container">
        <div class="main-container">
            <!-- Left Section with Image and Welcome Message -->
            <div class="left-section">
               <img src="${pageContext.request.contextPath}/images/clipart1.png" alt="Welcome Image">
               <div class="welcome-text">Dive in. Explore.<span class="break-after"> Learn Actively</span></div>
            </div>

            <!-- Right Section with Sign Up Form -->
            <div class="right-section">
                

                <div class="signup-title">Sign Up</div>
                <div class="signup-subtitle">Create your account to get started</div>

                <form method="post" action="/FAP/SignUpServlet">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" maxlength="20" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" maxlength="20" required>
                    </div>

                    <div class="form-group">
                        <label for="firstname">First Name</label>
                        <input type="text" id="firstname" name="firstname" maxlength="10" required>
                    </div>

                    <div class="form-group">
                        <label for="lastname">Last Name</label>
                        <input type="text" id="lastname" name="lastname" maxlength="10" required>
                    </div>

                    <div class="form-group">
                        <label>Role</label>
                        <div class="radio-group">
                            <label class="radio-option" for="admin">
                                <input type="radio" id="admin" name="role" value="A"> Admin
                            </label>
                            <label class="radio-option" for="student">
                                <input type="radio" id="student" name="role" value="S" checked> Student
                            </label>
                        </div>
                    </div>

                    <button type="submit">Sign Up</button>
                </form>

                <div class="create-account">
                    Already have an account? <a href="login.jsp">Login here</a>
                </div>
            </div>
        </div>
    </section>
</body>
</html>

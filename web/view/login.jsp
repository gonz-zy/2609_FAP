<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Your Account</title>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script>
        function enableSubmitBtn() {
            document.getElementById("submitBtn").disabled = false;
        }
    </script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            background-color: #fff4ee;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .main-container {
            display: flex;
            width: 100%;
            max-width: 1200px;
            min-height: 700px; /* Increased container height */
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .left-section {
            flex: 1;
            background-color: #fff4ee;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px; /* Increased padding */
            text-align: center;
        }
        
        .welcome-text {
            color: #333;
            font-size: 28px; /* Slightly larger font */
            margin-bottom: 40px; /* More spacing */
            font-weight: 600;
        }
        
        .left-section img {
            max-width: 100%;
            height: auto;
            max-height: 400px; /* Larger image */
            border-radius: 8px;
            object-fit: cover;
        }
        
        .right-section {
            flex: 1;
            padding: 60px; /* Increased padding */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .greeting-image {
            width: 150px; /* Larger greeting icon */
            height: 120px;
            margin-bottom: 30px;
            border-radius: 50%;
            object-fit: cover;
            align-self: center;
        }
        
        .login-title {
            color: #333;
            font-size: 24px; /* Slightly larger */
            margin-bottom: 40px; /* More spacing */
            font-weight: 600;
        }
        
        .form-group {
            margin-bottom: 25px; /* More spacing */
            text-align: left;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px; /* More spacing */
            color: #555;
            font-weight: 500;
            font-size: 16px; /* Slightly larger */
        }
        
        .form-group input {
            width: 100%;
            padding: 15px; /* More padding */
            border: 1px solid #ddd;
            border-radius: 8px; /* Slightly rounder */
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            border-color: #4CAF50;
            outline: none;
        }
        
        .forgot-password {
            text-align: right;
            margin-bottom: 30px; /* More spacing */
        }
        
        .forgot-password a {
            color: #666;
            font-size: 15px; /* Slightly larger */
            text-decoration: none;
        }
        
        .forgot-password a:hover {
            text-decoration: underline;
            color: #4CAF50;
        }
        
        .captcha-container {
            display: flex;
            justify-content: center;
            margin: 30px 0; /* More spacing */
        }
        
        .login-button {
            width: 100%;
            padding: 15px; /* More padding */
            background-color: #ff8a4b;
            color: white;
            border: none;
            border-radius: 8px; /* Slightly rounder */
            font-size: 18px; /* Slightly larger */
            font-weight: 500;
            cursor: pointer;
            margin-bottom: 30px; /* More spacing */
            transition: background-color 0.3s;
        }
        
        .login-button:hover {
            background-color: #ff6e21;
        }
        
        .create-account {
            color: #666;
            font-size: 16px; /* Slightly larger */
            text-align: center;
        }
        
        .create-account a {
            color: #ff8a4b;
            text-decoration: none;
            font-weight: 500;
        }
        
        .create-account a:hover {
            text-decoration: underline;
        }
          .login-button:disabled {
            background-color: grey;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Left Section with Image and Welcome Message -->
        <div class="left-section">
           
            <img src="images/clipart1.png" alt="Welcome Image">
             <div class="welcome-text">Dive in.Explore. Learn Actively</div>
        </div>
        
        <!-- Right Section with Login Form -->
        <div class="right-section">
            <!-- Greeting image -->
            <img src="images/activelearning.jpg" alt="Greeting Icon" class="greeting-image">
            
            <h2 class="login-title">Login your account</h2>
            
            <form action="loginProcess.jsp" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username">
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password">
                </div>
                
                
                <div class="captcha-container">
                    <div class="g-recaptcha" data-sitekey="6LcF3fsqAAAAAD8SdWJzzJlpIOitZI8OV9wD5r8_" data-callback="enableSubmitBtn"></div>
                </div>
                
                <button type="submit" class="login-button" id="submitBtn" disabled>Login</button>
            </form>
            
            <div class="create-account">
                Don't have an account? <a href="#">Create Account</a>
            </div>
        </div>
    </div>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign up</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff4ee;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .signup-card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
        }

        .signup-card h2 {
            margin: 0 0 10px;
            font-size: 28px;
            font-weight: 600;
            text-align: center;
        }

        .signup-card p {
            font-size: 14px;
            text-align: center;
            margin-bottom: 30px;
            color: #666;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            margin-bottom: 6px;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .form-check input {
            margin-right: 10px;
        }

        .radio-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .radio-option {
            display: flex;
            align-items: center;
        }

        .radio-option input {
            margin-right: 5px;
        }

        button[type="submit"] {
            width: 100%;
            background-color: #ff8a4b;
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #ff6e21;
        }

        .footer-text {
            text-align: center;
            font-size: 14px;
            margin-top: 20px;
        }

    
    </style>
</head>
<body>
    <div class="signup-card">
        <h2>Sign up</h2>
        <p>Sign up to continue</p>
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
                    <div class="radio-option">
                        <input type="radio" id="admin" name="role" value="admin">
                        <label for="admin">Admin</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="student" name="role" value="student" checked>
                        <label for="student">Student</label>
                    </div>
                </div>
            </div>

            <button type="submit">Sign up</button>
        </form>

     
    </div>
</body>
</html>

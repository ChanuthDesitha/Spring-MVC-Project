<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Roboto', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 100 100'%3E%3Cg fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Cpath opacity='.5' d='M96 95h4v1h-4v4h-1v-4h-9v4h-1v-4h-9v4h-1v-4h-9v4h-1v-4h-9v4h-1v-4h-9v4h-1v-4h-9v4h-1v-4h-9v4h-1v-4h-9v4h-1v-4H0v-1h15v-9H0v-1h15v-9H0v-1h15v-9H0v-1h15v-9H0v-1h15v-9H0v-1h15v-9H0v-1h15v-9H0v-1h15v-9H0v-1h15V0h1v15h9V0h1v15h9V0h1v15h9V0h1v15h9V0h1v15h9V0h1v15h9V0h1v15h9V0h1v15h9V0h1v15h4v1h-4v9h4v1h-4v9h4v1h-4v9h4v1h-4v9h4v1h-4v9h4v1h-4v9h4v1h-4v9h4v1h-4v9zm-1 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-9-10h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm9-10v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-9-10h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm9-10v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-9-10h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm9-10v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-10 0v-9h-9v9h9zm-9-10h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9zm10 0h9v-9h-9v9z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            z-index: -1;
        }

        .login-container {
            background-color: white;
            width: 380px;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            overflow: hidden;
            position: relative;
            animation: fadeIn 1s ease;
            transform: translateZ(0);
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #36d1dc, #5b86e5);
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
            font-weight: 600;
            position: relative;
            display: inline-block;
        }

        h2:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -8px;
            width: 100%;
            height: 3px;
            background: linear-gradient(to right, #36d1dc, #5b86e5);
            border-radius: 2px;
        }

        form {
            margin-top: 25px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 15px;
            margin-bottom: 20px;
            border: none;
            background-color: #f5f7fa;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            background-color: #fff;
            box-shadow: 0 0 0 2px rgba(91, 134, 229, 0.3);
        }

        button[type="submit"] {
            width: 100%;
            padding: 15px;
            border: none;
            background: linear-gradient(to right, #36d1dc, #5b86e5);
            color: white;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(91, 134, 229, 0.3);
        }

        button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 15px rgba(91, 134, 229, 0.4);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        .register-link {
            margin-top: 25px;
            color: #777;
            font-size: 14px;
        }

        .register-link a {
            color: #5b86e5;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .register-link a:hover {
            color: #36d1dc;
            text-decoration: underline;
        }

        .error-message {
            background-color: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            padding: 12px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            border-left: 3px solid #e74c3c;
            animation: shake 0.5s ease;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .login-container {
                width: 90%;
                padding: 30px 20px;
            }

            input[type="text"],
            input[type="password"],
            button[type="submit"] {
                padding: 12px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>

    <form action="login" method="post">
        <input type="text" name="email" placeholder="Enter Email" required/><br/>
        <input type="password" name="password" placeholder="Enter Password" required/><br/>
        <button type="submit">Login</button>
    </form>

    <p class="register-link">Don't have an account? <a href="register">Register here</a></p>

    <c:if test="${not empty error}">
        <p class="error-message">${error}</p>
    </c:if>
</div>
</body>
</html>
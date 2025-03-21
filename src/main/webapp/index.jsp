<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #3A86FF, #8338EC, #FFBE0B, #06D6A0);
            background-size: 300% 300%;
            animation: gradientBG 8s ease infinite;
        }

        @keyframes gradientBG {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .container {
            background-color: rgb(209, 225, 241);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 420px;
            width: 90%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 26px;
            font-weight: bold;
            color: #000000;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        button {
            background: linear-gradient(135deg, #FF6B35, #0EAD69);
            border: none;
            color: #fff;
            padding: 12px 30px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 25px;
            transition: all 0.3s ease;
            outline: none;
        }

        button:hover {
            background: linear-gradient(135deg, #0EAD69, #FF6B35);
            transform: scale(1.08);
        }

        form {
            margin-top: 15px;
        }

    </style>
</head>
<body>
<div class="container">

    <h2>Welcome to User Management System</h2>
    <form action="login" method="GET">
        <button type="submit">Login</button>
    </form>

</div>
</body>
</html>
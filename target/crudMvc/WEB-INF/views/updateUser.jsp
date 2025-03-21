<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.crudMvc.Model.User" %>
<%@ page isELIgnored="false" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Redirect to login if session is null (force logout)
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update User</title>

    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f8fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }

        /* Form Container */
        #updateUserForm {
            max-width: 550px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        #updateUserForm:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.1);
        }

        /* Heading */
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }

        /* Form Fields */
        input[type="text"],
        input[type="password"],
        input[type="file"] {
            width: 100%;
            padding: 12px 15px;
            margin: 8px 0 20px 0;
            display: inline-block;
            border: 1px solid #ddd;
            border-radius: 6px;
            background-color: #f9f9f9;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            background-color: #fff;
        }

        /* File Input Styling */
        input[type="file"] {
            padding: 10px;
            background: #fff;
            border: 1px dashed #ccc;
        }

        input[type="file"]::-webkit-file-upload-button {
            background: #3498db;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-right: 10px;
        }

        input[type="file"]::-webkit-file-upload-button:hover {
            background: #2980b9;
        }

        /* Labels */
        #updateUserForm label {
            font-weight: 500;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        /* Error Messages */
        span {
            display: block;
            color: #e74c3c;
            font-size: 14px;
            margin-top: -15px;
            margin-bottom: 15px;
            min-height: 20px;
        }

        /* Button Styling */
        button[type="submit"] {
            background-color: #2ecc71;
            color: white;
            padding: 14px 20px;
            margin: 20px 0 15px 0;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(46, 204, 113, 0.25);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        /* Back Button */
        .btn.edit {
            display: inline-block;
            text-decoration: none;
            background: #3498db;
            color: white;
            padding: 12px 20px;
            border-radius: 6px;
            text-align: center;
            margin-top: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
            width: 100%;
            box-sizing: border-box;
        }

        .btn.edit:hover {
            background-color: #2980b9;
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.25);
        }

        /* Responsive Design */
        @media screen and (max-width: 600px) {
            #updateUserForm {
                padding: 20px;
                margin: 0 10px;
            }

            input[type="text"],
            input[type="password"],
            input[type="file"] {
                padding: 10px;
                font-size: 14px;
            }

            button[type="submit"],
            .btn.edit {
                padding: 12px 16px;
            }
        }

        /* Animation for form appearance */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        #updateUserForm {
            animation: fadeIn 0.5s ease forwards;
        }
    </style>

    <script>

        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll("input").forEach(input => {
                input.addEventListener("keydown", function (event) {
                    if (event.key === " ") {
                        event.preventDefault();
                    }
                });
            });
        });


        mobile.addEventListener("keydown", function (event) {
            if (!/[\dBackspaceArrowLeftArrowRightDelete]/.test(event.key)) {
                event.preventDefault();
            }
        });

        mobile.addEventListener("input", function () {
            this.value = this.value.replace(/\D/g, "");
        });


        function validateForm(event) {
            event.preventDefault();
            let isValid = true;

            const name = document.getElementById("name");
            const email = document.getElementById("email");
            const mobile = document.getElementById("mobile");
            const password = document.getElementById("password");
            const confirmPassword = document.getElementById("confirmPassword");
            const photo = document.getElementById("photo");


            const nameRegex = /^[^\s]{1,15}$/;
            if (!name.value) {
                showError(name, "Enter Name");
                isValid = false;
            } else if (!nameRegex.test(name.value)) {
                showError(name, "Name must be only 15 characters.");
                isValid = false;
            } else {
                clearError(name);
            }

            // Email
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!email.value) {
                showError(email, "Enter Email");
                isValid = false;
            } else if (email.value.length > 25 || email.value.includes(" ")) {
                showError(email, "Invalid email format");
                isValid = false;
            } else if (!emailRegex.test(email.value)) {
                showError(email, "Invalid email format");
                isValid = false;
            } else {
                clearError(email);
            }

            // Mobile
            const mobileRegex = /^[0-9]{10,15}$/;
            if (!mobile.value) {
                showError(mobile, "Enter Mobile Number");
                isValid = false;
            } else if (!mobileRegex.test(mobile.value)) {
                showError(mobile, "Mobile number must be 10-15 digits");
                isValid = false;
            } else {
                clearError(mobile);
            }

            // Password
            if (!password.value) {
                showError(password, "Enter Password");
                isValid = false;
            } else if (password.value.length < 3 || password.value.length > 8) {
                showError(password, "Password must be 3-8 characters.");
                isValid = false;
            } else {
                clearError(password);
            }

            // Confirm password
            if (!confirmPassword.value) {
                showError(confirmPassword, "Enter Confirm Password");
                isValid = false;
            } else if (confirmPassword.value !== password.value) {
                showError(confirmPassword, "Passwords do not match");
                isValid = false;
            } else {
                clearError(confirmPassword);
            }

            // Photo
            if (photo.files.length > 0) {
                const file = photo.files[0];
                const allowedTypes = ["image/jpeg", "image/png"];
                if (!allowedTypes.includes(file.type)) {
                    showError(photo, "Only JPG or PNG files are allowed");
                    isValid = false;
                } else {
                    clearError(photo);
                }
            } else {
                clearError(photo);
            }

            if (isValid) {
                document.getElementById("updateUserForm").submit();
            }
        }

        function showError(input, message) {
            let errorSpan = input.nextElementSibling;
            errorSpan.innerText = message;
            errorSpan.style.color = "red";
        }

        function clearError(input) {
            let errorSpan = input.nextElementSibling;
            errorSpan.innerText = "";
        }
    </script>
</head>
<body>
<h2>Update User</h2>
<form id="updateUserForm" action="${pageContext.request.contextPath}/updateUser" method="post" onsubmit="validateForm(event)">

    <input type="hidden" name="id" value="${user.id}"/>

    Name: <input type="text" id="name" name="name" value="${user.name}">
    <span></span>

    Email: <input type="text" id="email" name="email" value="${user.email}">
    <span></span>
    Mobile: <input type="text" id="mobile" name="mobile" value="${user.mobile}">
    <span></span>

    Password: <input type="password" id="password" name="password">
    <span></span>

    Confirm Password: <input type="password" id="confirmPassword" name="confirmPassword">
    <span></span>

    Photo: <input type="file" id="photo" name="photo" accept=".jpg, .jpeg, .png">
    <span></span>

    <button type="submit">Update User</button>
    </br>
    <a href="userlist" class="btn edit">Back To User List</a>
</form>
</body>
</html>
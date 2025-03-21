<%--
  Created by IntelliJ IDEA.
  User: chanuth_w
  Date: 3/11/2025
  Time: 11:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page isELIgnored="false" %>


<html>
<head>
  <title>Register User</title>
  <style>
    /* Base styles */
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f7f9fc;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      color: #333;
    }

    /* Form container */
    form {
      background-color: white;
      padding: 35px;
      border-radius: 8px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      width: 100%;
      max-width: 450px;
      position: relative;
      border-top: 4px solid #3498db;
    }

    /* Form inputs and labels */
    input[type="text"],
    input[type="password"],
    input[type="file"] {
      width: 100%;
      padding: 12px 15px;
      margin: 8px 0 5px 0;
      border: 1px solid #e0e0e0;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 14px;
      transition: all 0.3s ease;
    }

    /* Label styling with animation preparation */
    form label {
      font-weight: 500;
      display: block;
      margin-top: 18px;
      font-size: 14px;
      color: #555;
    }

    /* Focus effects */
    input[type="text"]:focus,
    input[type="password"]:focus {
      border-color: #3498db;
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
      outline: none;
    }

    /* File input styling */
    input[type="file"] {
      padding: 10px;
      background-color: #f9f9f9;
      border: 1px dashed #ccc;
    }

    input[type="file"]::-webkit-file-upload-button {
      background-color: #3498db;
      color: white;
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      margin-right: 10px;
      transition: background-color 0.3s;
    }

    input[type="file"]::-webkit-file-upload-button:hover {
      background-color: #2980b9;
    }

    /* Error messages */
    .error {
      color: #e74c3c;
      font-size: 12px;
      margin-top: 5px;
      display: block;
      transition: all 0.3s ease;
      min-height: 18px;
    }

    /* Submit button */
    button[type="submit"] {
      background-color: #3498db;
      color: white;
      border: none;
      padding: 12px 0;
      width: 100%;
      font-size: 16px;
      border-radius: 4px;
      cursor: pointer;
      margin-top: 25px;
      transition: all 0.3s ease;
      font-weight: 600;
      letter-spacing: 0.5px;
      box-shadow: 0 2px 5px rgba(52, 152, 219, 0.3);
    }

    button[type="submit"]:hover {
      background-color: #2980b9;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(52, 152, 219, 0.4);
    }

    button[type="submit"]:active {
      transform: translateY(0);
    }

    /* Back link styling */
    a {
      display: block;
      text-align: center;
      margin-top: 20px;
      color: #3498db;
      text-decoration: none;
      font-size: 14px;
      transition: color 0.3s;
    }

    a:hover {
      color: #2980b9;
      text-decoration: underline;
    }

    /* Valid and invalid states */
    input:valid:not(:placeholder-shown) {
      border-color: #27ae60;
    }

    input:invalid:not(:placeholder-shown) {
      border-color: #e74c3c;
    }

    /* Remove the arrows from number inputs */
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
      -webkit-appearance: none;
      margin: 0;
    }

    /* Firefox */
    input[type=number] {
      -moz-appearance: textfield;
    }

    /* Responsive adjustments */
    @media (max-width: 500px) {
      form {
        padding: 25px 20px;
        max-width: 100%;
      }

      input[type="text"],
      input[type="password"] {
        padding: 10px;
      }
    }

    /* Form header styling */
    form::before {
      content: "Registration Form";
      display: block;
      font-size: 24px;
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 25px;
      text-align: center;
      padding-bottom: 15px;
      border-bottom: 1px solid #eee;
    }

    /* Add subtle animation to input fields */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    input {
      animation: fadeIn 0.5s ease-out forwards;
    }

    /* Make each input field animation slightly delayed */
    input:nth-child(2) { animation-delay: 0.1s; }
    input:nth-child(4) { animation-delay: 0.2s; }
    input:nth-child(6) { animation-delay: 0.3s; }
    input:nth-child(8) { animation-delay: 0.4s; }
    input:nth-child(10) { animation-delay: 0.5s; }
    input:nth-child(12) { animation-delay: 0.6s; }

    /* Photo preview if needed */
    #photoPreview {
      display: none;
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 50%;
      margin: 10px auto;
      border: 3px solid #3498db;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>

<form action="${pageContext.request.contextPath}/registerUser" method="POST"  onsubmit="return validateForm()">

  Name: <input type="text" name="name" id="name" placeholder="Name" oninput="validateName()">
  <span id="nameError" class="error"></span>

  Email: <input type="text" name="email" id="email" placeholder="Email" oninput="validateEmail()">
  <span id="emailError" class="error"></span>

  Password: <input type="password" name="password" id="password" placeholder="Password" oninput="validatePassword()">
  <span id="passwordError" class="error"></span>

  Confirm Password: <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" oninput="validateConfirmPassword()">
  <span id="confirmPasswordError" class="error"></span>

  Mobile: <input type="text" name="mobile" id="mobile" placeholder="Mobile Number" oninput="validateMobile()">
  <span id="mobileError" class="error"></span>

  Photo: <input type="file" name="photo" id="photo" accept="image/png, image/jpeg" onchange="validatePhoto()">
  <span id="photoError" class="error"></span>

  <button type="submit">Register</button>


  <c:choose>
    <c:when test="${not empty sessionScope.user}">
      <a href="userlist">Back to User List</a>
    </c:when>
    <c:otherwise>
      <a href="login">Back to Login</a>
    </c:otherwise>
  </c:choose>


</form>
<script>
  function validateName() {
    let nameInput = document.getElementById("name");
    let name = nameInput.value.trim();
    let nameError = document.getElementById("nameError");

    nameInput.value = name.replace(/\s/g, "");

    if (name.length === 0) {
      nameError.innerText = "Enter Name";
      return false;
    } else if (name.length > 15) {
      nameError.innerText = "Name must be only 15 characters.";
      return false;
    } else {
      nameError.innerText = "";
      return true;
    }
  }

  function validateEmail() {
    let emailInput = document.getElementById("email");
    let email = emailInput.value.trim();
    let emailError = document.getElementById("emailError");
    let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    emailInput.value = email.replace(/\s/g, "");

    if (email.length === 0) {
      emailError.innerText = "Enter Email";
      return false;
    } else if (!emailRegex.test(email)) {
      emailError.innerText = "Invalid email format.";
      return false;
    } else if (email.length > 25) {
      emailError.innerText = "Email must not exceed 25 characters.";
      return false;
    } else {
      emailError.innerText = "";
      return true;
    }
  }

  function validatePassword() {
    let passwordInput = document.getElementById("password");
    let password = passwordInput.value.trim();
    let passwordError = document.getElementById("passwordError");

    passwordInput.value = password.replace(/\s/g, "");

    if (password.length === 0) {
      passwordError.innerText = "Enter Password";
      passwordError.style.color = "red";
      return false;
    } else if (password.length < 3 || password.length > 8) {
      passwordError.innerText = "Password must be between 3 and 8 characters.";
      passwordError.style.color = "red";
      return false;
    } else {
      passwordError.innerText = "";
      return true;
    }
  }

  function validateConfirmPassword() {
    let confirmPasswordInput = document.getElementById("confirmPassword");
    let confirmPassword = confirmPasswordInput.value.trim();
    let passwordInput = document.getElementById("password");
    let password = passwordInput.value;
    let confirmPasswordError = document.getElementById("confirmPasswordError");

    confirmPasswordInput.value = confirmPassword.replace(/\s/g, "");

    if (confirmPassword.length === 0) {
      confirmPasswordError.innerText = "Enter confirm Password";
      confirmPasswordError.style.color = "red";
      return false;
    } else if (password !== confirmPassword) {
      confirmPasswordError.innerText = "Passwords do not match.";
      confirmPasswordError.style.color = "red";
      return false;
    } else {
      confirmPasswordError.innerText = "";
      return true;
    }
  }

  function validateMobile() {
    let mobileInput = document.getElementById("mobile");
    let mobile = mobileInput.value;
    let mobileError = document.getElementById("mobileError");
    let mobileRegex = /^\d{10,12}$/;

    mobileInput.value = mobile.replace(/\s/g, "");

    if (!mobileRegex.test(mobile)) {
      mobileError.innerText = "Mobile number must be 10-15 digits.";
      return false;
    } else {
      mobileError.innerText = "";
      return true;
    }
  }

  function validatePhoto() {
    let photoInput = document.getElementById("photo");
    let photoError = document.getElementById("photoError");

    if (photoInput.files.length === 0) {
      photoError.innerText = "";
      return true;
    }

    let photo = photoInput.files[0];
    let allowedExtensions = ["image/png", "image/jpeg"];

    if (!allowedExtensions.includes(photo.type)) {
      photoError.innerText = "Only JPG or PNG images are allowed.";
      return false;
    } else {
      photoError.innerText = "";
      return true;
    }
  }

  function validateForm() {
    return validateName() && validateEmail() && validatePassword() && validateConfirmPassword() && validateMobile() && validatePhoto();
  }
</script>

</body>
</html>
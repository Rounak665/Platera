<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>
<!DOCTYPE html>
<html>
<head>
    <title>PLatera - Forgot Password</title>
    <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="./ForgotPassword.css">
</head>
<body>
    <!-- Error Popup -->
    <div class="error-popup" id="errorPopup">
        <div class="error-content">
            <h2>Error</h2>
            <p id="errorMessage">An error has occurred. Please try again later.</p>
            <button id="closeErrorPopup">Go Back</button>
        </div>
    </div>

    <div class="container">
        <div class="logo">
            <img src="<%= request.getContextPath()%>/Public/images/PlateraLogo-red.png" alt="Logo" width="50" height="50">
        </div>
        <h2>Forgot Password</h2>
        <p>Please enter your email address. We will send a otp to your inbox.</p>
        <form method="post" action="http://localhost:8080/Platera-Main/ForgotPassword">
            <input type="email" id="email" name="email" placeholder="Enter your email"/>
            <button type="submit">Send OTP</button>
        </form>
        <a href="login.jsp" class="back-link">Back to login</a>
    </div>
    <script src="../../../error.js"></script>
</body>
</html>

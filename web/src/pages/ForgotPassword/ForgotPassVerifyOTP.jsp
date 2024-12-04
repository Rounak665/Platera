<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP</title>
    <link rel="stylesheet" href="ForgotPassword.css">
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="<%= request.getContextPath()%>/Public/images/PlateraLogo-red.png" alt="Logo" width="50" height="50">
        </div>
        <h2>Check your email</h2>
        <p>We've sent an otp. Please check your inbox at your registered email address.</p>
        <form action="http://localhost:8080/Platera-Main/ForgotPassVerifyOTP" method="POST">
            <input type="text" id="code" name="code" placeholder="Enter code here" required />
            <button type="submit" class="btn-verify">Continue with login code</button>
        </form>
        <a href="login.jsp" class="back-link">Back to login</a>       
    </div>

  
</body>
</html>

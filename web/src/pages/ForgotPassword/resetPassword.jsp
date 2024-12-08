<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <link rel="stylesheet" type="text/css" href="./ForgotPassword.css">
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="<%= request.getContextPath()%>/Public/images/PlateraLogo-red.png" alt="Logo" width="50" height="50">
        </div>
        <h2>Reset Password</h2>
        <p>Please enter your new password below to reset it.</p>
        <form method="post" action="http://localhost:8080/Platera-Main/ResetPassword">
            <input type="password" id="newPassword" name="newPassword" placeholder="Enter New Password" required />
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm New Password" required />
    
            <button type="submit">Change Password</button>
        </form>
        <a href="login.jsp" class="back-link">Back to login</a>
    </div>
</body>
</html>

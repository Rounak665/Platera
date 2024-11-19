<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <link rel="stylesheet" type="text/css" href="ForgotPassword.css">
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="Assets/favicon.png" alt="Logo" width="50" height="50">
        </div>
        <h2>Forgot Password</h2>
        <p>Please enter your email address. We will send a otp to your inbox.</p>
        <%
            String email = request.getParameter("email");
            if (email != null && !email.isEmpty()) {
                Random rand = new Random();
                int otp = 100000 + rand.nextInt(900000);
                session.setAttribute("otp", otp);
                session.setAttribute("userEmail", email);
                System.out.println("Sending OTP " + otp + " to " + email);
                response.sendRedirect("verifyOtp.jsp");
            }
        %>
        <form method="post">
            <input type="email" id="email" name="email" placeholder="Enter your email" />
            <button type="submit">Send OTP</button>
        </form>
        <a href="login.jsp" class="back-link">Back to login</a>
    </div>
</body>
</html>

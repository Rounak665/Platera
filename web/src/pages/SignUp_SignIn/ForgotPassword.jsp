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
        <h2>Forgot Password</h2>
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
            <label for="email">Enter your email address:</label>
            <input type="email" id="email" name="email" required />
            <button type="submit">Send OTP</button>
        </form>
    </div>
</body>
</html>

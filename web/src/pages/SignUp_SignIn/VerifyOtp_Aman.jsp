<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
    <link rel="stylesheet" type="text/css" href="ForgotPassword.css">
</head>
<body>
    <div class="container">
        <h2>Verify OTP</h2>
        <%
            String enteredOtp = request.getParameter("otp");
            Integer sessionOtp = (Integer) session.getAttribute("otp");
            if (enteredOtp != null) {
                if (sessionOtp != null && enteredOtp.equals(sessionOtp.toString())) {
                    response.sendRedirect("resetPassword.jsp");
                } else {
                    out.println("<p class='error-message'>Invalid OTP. Please try again.</p>");
                }
            }
        %>
        <form method="post">
            <label for="otp">Enter OTP:</label>
            <input type="text" id="otp" name="otp" required />
            <button type="submit">Verify OTP</button>
        </form>
    </div>
</body>
</html>

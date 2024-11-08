<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Retrieve OTP from session (simulated OTP for testing)
    String sessionOtp = (String) session.getAttribute("otp");

    // Prepare message variable
    String message = "";

    // Handle form submission (POST request)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Combine all input fields into a single OTP value
        String otpInput = request.getParameter("otpDigit1") +
                          request.getParameter("otpDigit2") +
                          request.getParameter("otpDigit3") +
                          request.getParameter("otpDigit4");

        // Validate OTP
        if (otpInput.equals(sessionOtp)) {
            // OTP matches, redirect to reset password page
            response.sendRedirect("resetPassword.jsp");
            return;
        } else {
            message = "Invalid OTP. Please try again.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP</title>
    <link rel="stylesheet" href="ForgotPassword.css">
</head>
<body>
    <div class="otp-content">
        <div class="otp-body">
            <ion-icon name="notifications" class="otp-icon"></ion-icon>
            <h2>Verify OTP</h2>
            <p>We have sent you a one-time password. Please enter it below:</p>
            <div class="otp-timer" id="otp-timer">2:00</div>
            <form action="verifyOtp.jsp" method="POST">
                <div class="otp-input">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                </div>
                <p>Didn't receive the OTP? <a href="#">RESEND</a></p>
                <button type="submit" class="btn-verify">Verify</button>
            </form>
        </div>
    </div>

    <script>
        // JavaScript for the countdown timer
        var timerElement = document.getElementById("otp-timer");
        var timeRemaining = 120; // 2 minutes in seconds

        function updateTimer() {
            var minutes = Math.floor(timeRemaining / 60);
            var seconds = timeRemaining % 60;

            // Format time as MM:SS
            var timeFormatted = minutes.toString().padStart(2, "0") + ":" + seconds.toString().padStart(2, "0");

            // Update the display
            timerElement.textContent = timeFormatted;

            if (timeRemaining > 0) {
                timeRemaining--;
            } else {
                clearInterval(timerInterval); // Stop the timer once it reaches 0
            }
        }

        // Update the timer every second
        var timerInterval = setInterval(updateTimer, 1000);
    </script>
</body>
</html>

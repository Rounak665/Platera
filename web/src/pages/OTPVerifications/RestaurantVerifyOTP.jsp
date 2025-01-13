<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Platera - Restaurant OTP Verification</title>
    <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="./OTPVerification.css">
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
        <h2>Check your email</h2>
        <p>An OTP has been sent to your email address: <strong>${email}</strong></p>
         <!-- Message Section -->
    <p style="color: #F12630; font-size: 0.95rem; margin-bottom: 20px;">
        Enter the OTP within <strong>1 minute</strong>.
    </p>
        <form action="http://localhost:8080/Platera-Main/RestaurantVerifyOTP" method="POST">
            <input type="text" name="otp" placeholder="Enter OTP" required>
            <input type="hidden" name="email" value="${email}" /> 
            <input type="submit" value="Verify OTP">
        </form>
    </div>
    <script src="../../../error.js"></script>
</body>
</html>

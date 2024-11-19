<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="ForgotPassword.css">
</head>
<body>

    <div class="container">
        <h2>Verify OTP</h2>
        <p>An OTP has been sent to your email address: <strong>${email}</strong></p>
        <form action="verifyOTP" method="POST">
            <input type="text" name="otp" placeholder="Enter OTP" required>
            <input type="hidden" name="email" value="${email}" /> <!-- Email passed as hidden input -->
            <input type="submit" value="Verify OTP">
        </form>
    </div>

</body>
</html>

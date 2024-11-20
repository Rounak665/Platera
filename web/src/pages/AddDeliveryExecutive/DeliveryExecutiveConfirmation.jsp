<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Retrieve session attributes
    HttpSession session = request.getSession(false);

    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String phone = session.getAttribute("phone").toString();
    String address = (String) session.getAttribute("address");
    String age = session.getAttribute("age").toString();
    String gender = (String) session.getAttribute("gender");
    String aadharNumber = session.getAttribute("aadharNumber").toString();
    String bankAccountName = (String) session.getAttribute("bankAccountName");
    String bankAccountNumber = (String) session.getAttribute("bankAccountNumber");
    String panNumber = (String) session.getAttribute("panNumber");
    String drivingLicenseNumber = (String) session.getAttribute("drivingLicenseNumber");
    String vehicleNumber = (String) session.getAttribute("vehicleNumber");
    String vehicleType = (String) session.getAttribute("vehicleType");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Confirmation</title>
    <link rel="stylesheet" href="Confirmation.css">
    <script>
        function showPopup() {
            const popup = document.getElementById("detailsPopup");
            popup.style.display = "flex";
        }

        function closePopup() {
            const popup = document.getElementById("detailsPopup");
            popup.style.display = "none";
        }

        function proceedToLogin() {
            window.location.href = "AddDeliveryExecutive#Signin-popup";
        }
    </script>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-message">
            <h1>Registration Successful!</h1>
            <p>Thank you for registering! Your details have been successfully submitted. Our team will send you an email regarding the approval of your restaurant on Platera. Please stay tuned as we review your application.</p>
            <button onclick="showPopup()">View Your Details</button>
            <!-- New Proceed to Login Button -->
            <button onclick="proceedToLogin()">Proceed to Login</button>
        </div>
    </div>

    <!-- Popup Section -->
    <div id="detailsPopup" class="popup" style="display:none;">
        <div class="popup-content">
            <h2>Your Registration Details</h2>
            <div class="details-list">
                <div class="column">
                    <p><strong>Name:</strong> <%= name %></p>
                    <p><strong>Email:</strong> <%= email %></p>
                    <p><strong>Phone:</strong> <%= phone %></p>
                    <p><strong>Address:</strong> <%= address %></p>
                    <p><strong>Age:</strong> <%= age %></p>
                    <p><strong>Gender:</strong> <%= gender %></p>
                </div>
                <div class="column">
                    <p><strong>Aadhar Number:</strong> <%= aadharNumber %></p>
                    <p><strong>Bank Account Name:</strong> <%= bankAccountName %></p>
                    <p><strong>Bank Account Number:</strong> <%= bankAccountNumber %></p>
                    <p><strong>PAN Number:</strong> <%= panNumber %></p>
                    <p><strong>Driving License Number:</strong> <%= drivingLicenseNumber %></p>
                    <p><strong>Vehicle Number:</strong> <%= vehicleNumber %></p>
                    <p><strong>Vehicle Type:</strong> <%= vehicleType %></p>
                </div>
            </div>
            <button onclick="closePopup()">Close</button>
        </div>
    </div>
</body>
</html>

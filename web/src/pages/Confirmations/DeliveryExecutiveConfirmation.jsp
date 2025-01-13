<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Retrieve session attributes
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


    // Static values for debugging
//    String name = "John Doe";
//    String email = "john.doe@example.com";
//    String phone = "1234567890";
//    String address = "123 Main Street, Springfield";
//    String age = "30";
//    String gender = "Male";
//    String aadharNumber = "1234-5678-9101";
//    String bankAccountName = "John's Account";
//    String bankAccountNumber = "9876543210";
//    String panNumber = "ABCDE1234F";
//    String drivingLicenseNumber = "DL123456789";
//    String vehicleNumber = "MH01AB1234";
//    String vehicleType = "Car";

%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Confirmation</title>
    <link rel="stylesheet" href="./Confirmation.css">
   
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

    <div class="confirmation-container">
        <div class="confirmation-message">
                <!-- Add the logo below and dont change the src value-->
       <div class="logo">
        <img src="<%= request.getContextPath()%>/Public/images/PlateraLogo-red.png" alt="Logo" width="50" height="50">
    </div> 
            <h1>Registration Successful!</h1>
            <p>🚀 Welcome to Platera's Delivery Team! <br>

                Your registration has been successfully completed. ✅ <br>
                
                👋 We’re thrilled to have you join our team of skilled delivery executives! Our team is reviewing your application to ensure all details are accurate. <br>
                
                📧 Once approved, you’ll receive a confirmation email with the next steps and everything you need to get started. <br>
                
                🛵 Gear up to be the vital connection in delivering delicious meals to satisfied customers. Stay tuned—your exciting journey with Platera begins soon!</p>
            <button onclick="showPopup()">View Your Details</button>
            <!-- New Proceed to Login Button -->
            <button onclick="proceedToLogin()">Back to </button>
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
            window.location.href = "../AddDeliveryExecutive/AddDeliveryExecutive.jsp#Signin-popup";
        }
    </script>
</html>


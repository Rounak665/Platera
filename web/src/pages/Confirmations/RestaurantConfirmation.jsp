<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Retrieve session attributes
    String restaurantName = (String) session.getAttribute("restaurant_name");
    String ownerName = (String) session.getAttribute("owner_name");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("owner_phone");
    String address = (String) session.getAttribute("owner_address");
    String bankAccountName = (String) session.getAttribute("bank_account_name");
    String bankAccountNumber = (String) session.getAttribute("bank_account_number");
    String fssaiLicense = (String) session.getAttribute("fssai_license");
    String panCard = (String) session.getAttribute("pan_card");
    String gstin = (String) session.getAttribute("gstin");
    String restaurantPhone = (String) session.getAttribute("restaurant_phone");
    String restaurantAddress = (String) session.getAttribute("restaurant_address");
    String category1 = (String) session.getAttribute("category1");
    String category2 = (String) session.getAttribute("category2");
    String category3 = (String) session.getAttribute("category3");
    String minPrice = session.getAttribute("min_price").toString();
    String maxPrice = session.getAttribute("max_price").toString();

//    String restaurantName = "The Gourmet Spot";
//    String ownerName = "John Doe";
//    String email = "john.doe@example.com";
//    String phone = "9876543210";
//    String address = "123 Main Street, Springfield";
//    String bankAccountName = "John's Account";
//    String bankAccountNumber = "1234567890";
//    String fssaiLicense = "FSSAI123456";
//    String panCard = "ABCDE1234F";
//    String gstin = "GSTIN987654321";
//    String restaurantPhone = "1234567890";
//    String restaurantAddress = "456 Foodie Lane, Foodtown";
//    String category1 = "Indian";
//    String category2 = "Chinese";
//    String category3 = "Mexican";
//    String minPrice = "200";
//    String maxPrice = "2000";

%> -->
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
                <p>Thank You for Registering with Platera!<br>
                    Your restaurant's details have been successfully submitted.✅<br> 

                    Our team is thrilled to have you on board! We're currently reviewing your application to ensure it meets our quality standards. Once approved, you will receive an email confirmation with all the details you need to get started. <br>

                    In the meantime, feel free to explore our platform and get ready to bring delicious meals to food lovers everywhere.</p>
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
                <p><strong>Restaurant Name:</strong> <%= restaurantName %></p>
                <p><strong>Owner Name:</strong> <%= ownerName %></p>
                <p><strong>Email:</strong> <%= email %></p>
                <p><strong>Owner Phone:</strong> <%= phone %></p>
                <p><strong>Owner Address:</strong> <%= address %></p>
                <p><strong>Restaurant Phone:</strong> <%= restaurantPhone %></p>
                <p><strong>Restaurant Address:</strong> <%= restaurantAddress %></p>
            </div>
            <div class="column">
                <p><strong>Min Price:</strong> ₹<%= minPrice %></p>
                <p><strong>Max Price:</strong> ₹<%= maxPrice %></p>
                <p><strong>Bank Account Name:</strong> <%= bankAccountName %></p>
                <p><strong>Bank Account Number:</strong> <%= bankAccountNumber %></p>
                <p><strong>PAN Card Number:</strong> <%= panCard %></p>
                <p><strong>FSSAI License:</strong> <%= fssaiLicense %></p>
                <p><strong>GSTIN:</strong> <%= gstin %></p>
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
            window.location.href = "../AddRestaurant/AddRestaurant.html#Signin-popup";
        }
    </script>
</html>


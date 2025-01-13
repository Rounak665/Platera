<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Confirm your Details</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="./OrderDetails.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
    </head>
    <body>
        <%
            // Retrieve user_id from the session

              int user_id = (Integer) session.getAttribute("user_id");
//            int user_id = 201;

            // Initialize necessary variables
            String name = "";
            String email = "";
            int customer_id = 0;
            int location_id = 0;
            String location = "";
            String address = "";
            String phone = "";

            Customer customer = CustomerDAO.getCustomerByUserId(user_id);
            if (customer != null) {
                customer_id = customer.getCustomerId();
                name = customer.getFullName();
                email = customer.getEmail();
                location_id = customer.getLocationId();
                location = customer.getLocation();
                address = customer.getAddress();
                phone = customer.getPhone();
            }
        %>

        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>
        <nav class="navbar">
            <div class="logo"><a href=""><img src="./Assets/PlateraLogo-red.png" alt="" width="150px"></a></div>
            <button class="back-button" onclick="window.location = '<%=request.getContextPath()%>/src/pages/Customer/Home.jsp#cartSection';">Back</button>
        </nav>
        <div class="container">
            <h2>Order Details</h2>
            <form id="userDetailsForm" action="http://localhost:8080/Platera-Main/OrderDetails" method="post">
                <input type="hidden" name="customerId" value="<%=customer_id%>">
                <input type="hidden" name="locationId" value="<%=location_id%>">
                <div class="input-group">
                    <label for="full-name">Payment Method</label>
                    <input type="text" id="payment-method" name="payment-method" 
                           value="<%= request.getParameter("payment") != null ? request.getParameter("payment") : "No payment method selected"%>" 
                           readonly class="grayed-out">

                    <p class="grayed-text">If you want to change the payment method then go to the previous page</p>
                </div>

                <div class="input-group">
                    <label for="full-name">Full Name</label>
                    <input type="text" id="full-name" name="full-name" value="<%=name%>" required>
                </div>
                <div class="input-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" value="<%=phone%>" required>
                </div>
                <h3>Select Address</h3>
                <!-- Saved Address -->
                <div class="address-group">
                    <input type="radio" id="saved-address-radio" name="addressRadio" value="saved-address"  checked>
                    <label for="saved-address-radio" class="address-label">Saved Address</label>
                </div>
                <input type="text" id="saved-address" name="saved-address" class="address-input" value="<%= address != null ? address : "No saved address"%>" readonly>
                <p class="grayed-text" id="saved-address-caution" style="margin-bottom: 25px;">If you have no saved address then select  new address</p>


                <!-- New Address -->
                <div class="address-group">
                    <input type="radio" id="new-address-radio" name="addressRadio" value="new-address">
                    <label for="new-address-radio" class="address-label">New Address</label>
                </div>
                <input type="text" id="new-address" name="new-address" class="address-input" placeholder="Enter new address" style="display: none; margin-bottom: 5px;">
                <p class="grayed-text" id="new-address-caution" style="display: none; margin-bottom: 25px;">If you have no saved address then this address will be new saved address</p>

                <!-- Confirmation Email -->
                <div class="input-group checkbox-group">
                    <input type="checkbox" id="email-confirmation" name="email-confirmation">
                    <label for="email-confirmation">Receive order confirmation in your registered email</label>
                </div>
                <input type="text" name="email" value="<%=email%>" hidden>
                <button type="submit">Submit</button>
            </form>
        </div>
        <script src="../../../error.js"></script>
        <script src="./OrderDetails.js"></script>
    </body>
</html>
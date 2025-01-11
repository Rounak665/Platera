
<%@page import="Utilities.Location"%>
<%@page import="Utilities.Location"%>
<%@page import="Utilities.LocationDAO"%>
<%@page import="Utilities.DeliveryExecutiveDAO"%>
<%@page import="Utilities.DeliveryExecutive"%>
<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.Orders"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.OrdersDAO"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delivery Executive Dashboard Overview</title>
        <link rel="stylesheet" href="Delivery.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <body>

        <!--Java Scriplets-->
        <%
            // Simulate session attributes for debugging
//    int user_id = (Integer) session.getAttribute("user_id");
            int user_id = 282;

            DeliveryExecutive deliveryExecutive = null;

            deliveryExecutive = DeliveryExecutiveDAO.getDeliveryExecutiveByUserId(user_id);

            int executiveId = deliveryExecutive.getExecutiveId();
            String name = deliveryExecutive.getFullName();
            String phone = deliveryExecutive.getPhone();
            String address = deliveryExecutive.getAddress();
            String vehicleType = deliveryExecutive.getVehicleType();
            String vehicleNumber = deliveryExecutive.getVehicleNumber();
            int locationId = deliveryExecutive.getLocationId();
            String locationName = deliveryExecutive.getLocation();
            String imagePath = request.getContextPath() + '/' + deliveryExecutive.getImage();
            String executiveStatus = deliveryExecutive.getStatus();
            boolean twoFA = deliveryExecutive.isTwoStepVerification();


        %>



        <!-- Welcome Popup -->


        <!-- loader -->
        <div class="loader">
            <div id="pl">
                <div>
                    <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
                </div>
            </div>
        </div>     

        <!-- Otp popup -->
        <div class="popupOTP" id="popupOTPContainer">
            <div class="container1">
            <div class="logoOTP">
                <img src="<%= request.getContextPath()%>/Public/images/PlateraLogo-red.png" alt="Logo" width="50" height="50">
            </div>
            <h2>Verify Delivery Handover</h2>
            <p>An OTP has been sent to customer's email: <strong>${email}</strong></p>
             <!-- Message Section -->
        <p style="color: #F12630; font-size: 0.95rem; margin-bottom: 20px;">
            Enter the OTP within <strong>1 minute</strong>.
        </p>
        <!-- ------------------------------Change the form action of the handover otp here----------------------- -->
            <form action="http://localhost:8080/Platera-Main/DeliveryExecutiveVerifyOTP" method="POST" class="otp-form">
                <input type="text" name="otp" placeholder="Enter OTP" required>
                <input type="hidden" name="email" value="${email}" /> 
                <input type="submit" value="Verify OTP">
            </form>
            <form action="http://localhost:8080/Platera-Main/DeliveryExecutiveVerifyOTP" method="POST" class="otp-form">
                <input type="submit" value="Generate OTP">
            </form>
            </div>
        </div>

        <!-- Two step Verification -->

        <div id="security-section" class="security-container" style="display: none;">
            <div class="security-card">
                <span class="sec-close-btn" id="closeSecuritySection">&times;</span>
                <div class="security-header">
                    <i class="fas fa-lock lock-icon"></i>
                    <h2>Two-factor Authentication</h2>
                </div>
                <p class="security-description">
                    Enhance your security by setting up two-factor authentication (2FA) on your registered email.
                </p>
                <form id="twoFAForm" method="post" action="http://localhost:8080/Platera-Main/UpdateTwoFAStatus">
                    <input type="hidden" value="<%=user_id%>" name="userId">
                    <div class="security-option">
                        <div class="security-description">
                            <label class="option-title">
                                <span>Text Message</span> <span class="option-subtitle">EMAIL</span>
                            </label>
                            <p class="option-description">
                                Get a one-time passcode through email.
                            </p>
                        </div>
                        <label class="switch">
                            <!-- Dynamically set the 'checked' attribute based on the 'twoFA' variable -->
                            <input type="checkbox" id="email-toggle" name="twoFA" <%= twoFA ? "checked" : ""%> />
                            <span class="slider round"></span>
                        </label>
                    </div>
                    <div class="security-footer">
                        <button type="button" id="cancel-btn" class="btn cancel-btn">Cancel</button>
                        <button type="submit" id="save-btn" class="btn save-btn">Save changes</button>
                    </div>
                </form>
            </div>
        </div>


        <div>

            <div class="sidebar">
                <div class="sidebar-toggle menu" id="menu">
                    <ion-icon name="menu"></ion-icon>
                </div>
                <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="ico"></ion-icon></div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="">
                    </div>
                </div>

                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="./DeliveryOrders.jsp">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>


            <!-- sliding profile settings -->

            <section class="setting-section" id="setSection">
                <div class="setting-container" id="settingContainer">
                    <span class="close-btn" id="closeSetSection">&times;</span>
                    <div class="setting-header">
                        Profile Setttings
                    </div>
                    <ul class="setting-options">
                        <li id="editProfile"><i class="fas fa-user-edit"></i> Edit your profile</li>
                        <li><i class="fas fa-key"></i> Change Password</li>
                        <li id="setSecure"><i class="fas fa-shield-alt"></i> Security</li>
                        <li><i class="fas fa-file-alt"></i> <a href="privacy-policy.html">Privacy Policy</a></li>
                        <li><i class="fas fa-file-contract"></i> <a href="terms-conditions.html">Terms and Conditions</a></li>
                        <li id="delete-acc">
                            <i class="fas fa-trash-alt"></i>
                            <form action="http://localhost:8080/Platera-Main/DeleteUser" method="POST" onsubmit="return confirmDelete()">
                                <input type="hidden" name="userId" value="<%=user_id%>">
                                <button type="submit" class="delete-btn">
                                    <span>Delete Account</span>
                                </button>
                            </form>
                        </li>
                    </ul>
                </div>

                <!-- edit section -->
                <div class="modal-content" id="modalContent" style="display: none;">
                    <span class="back-btn" id="backToCheckout"><b>&#8592;</b></span>
                    <span class="close-btn" id="closeEditSection">&times;</span>

                    <div class="modal-header">
                        Edit Profile
                    </div>
                    <div class="modal-body">
                            <form action="http://localhost:8080/Platera-Main/UpdateExecutiveProfile" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="user_id" value="<%=user_id%>">
                                <input type="hidden" name="executive_id" value="<%=executiveId%>">
                                <div class="row">
                                    <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="profileImage" class="form-label">Profile Image</label>
                                        <input type="file" class="form-control file-input" id="photo-input" name="profileImage" accept="image/*">
                                        <small class="form-text text-muted">Choose a clear, professional image.</small>
                                    </div>
                                    </div>
                                    <div class="col-md-6 d-flex align-items-center">
                                    <div class="preview-container">
                                        <img id="profile-photo-preview" src="<%= imagePath%>" alt="Profile Preview" class="img-thumbnail">
                                        <small class="form-text text-muted">Preview your profile image here.</small>
                                    </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" value="<%=name%>" placeholder="Enter your full name">
                                    </div>
                                    </div>
                                    <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="number" class="form-label">Phone No.</label>
                                        <input type="text" class="form-control" id="number" name="phone" value="<%=phone%>" placeholder="Enter your phone number">
                                    </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="address" name="address" value="<%=address%>" placeholder="Enter your address">
                                    </div>
                                    </div>
                                <!-- Vehicle Type Dropdown -->
                                    <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="vehicleType" class="form-label">Vehicle Type</label>
                                        <select class="form-control" id="vehicleType" name="vehicleType">
                                            <option value="" disabled selected>
                                                <%= vehicleType != null && !vehicleType.isEmpty() ? vehicleType : "Select your vehicle type"%>
                                            </option>
                                            <option value="Bike">Bike</option>
                                            <option value="Scooter">Scooter</option>
                                            <option value="Cycle">Cycle</option>
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                <div class="row">
                                <!-- Location Dropdown -->
                                    <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="location" class="form-label">Location</label>
                                        <select id="location" name="location" class="form-control styled-dropdown" required>
                                            <option value="<%= locationId%>" selected>
                                                <%= locationName != null ? locationName : "Select a location"%>
                                            </option>
                                            <%
                                                LocationDAO locationDAO = new LocationDAO();
                                                List<Location> locations = locationDAO.getLocations();
                                                for (Location location : locations) {
                                            %>
                                            <option value="<%= location.getId()%>" <%= (location.getId() == locationId) ? "selected" : ""%>>
                                                <%= location.getName()%>
                                            </option>
                                            <%
                                                }
                                            %>
                                        </select>

                                    </div>
                                    </div>
                                    <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="vehicleNumber" class="form-label">Vehicle No.</label>
                                        <input type="text" class="form-control" id="emergencyContact" name="vehicleNumber" value="<%=vehicleNumber%>" placeholder="Enter vehicle number">
                                    </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" id="cancelModal" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </div>
                            </form>

                    </div>
                </div>
        </div>
    </section>

    <!-- main content -->
    <div class="main-content">
        <header>
            <div class="headerLogo">
                <div class="logo">
                    <img src="../../../Public/images/logo.png" alt="">
                </div>
            </div>
            <div class="search-wrapper">
                <span class="icon"><ion-icon name="search"></ion-icon></span>
                <input type="search" placeholder="Search">
            </div>
            <div class="social-icons">
                <div class="logout_btn">
                    <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center logout">
                        <button type="submit" class="btn d-flex align-items-center">
                            <span class="ml-2">Logout</span>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                            <path d="M7.5 1v7h1V1z"></path>
                            <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
        </header>

        <main>
            <h2 class="dash-title">Hello, <%=name%></h2>

            <div class="container">

                <div class="profile">
                    <div class="personal-details">
                        <div class="personal-image">
                            <img src="<%=imagePath%>" alt="Your-image">
                        </div>
                        <div class="personal-description">
                            <h5><%=name%></h5>
                            <h6><span>&#9733; 5.0</span><span>|<%=locationName%></span></h6>
                            <p>Joined June 2024</p>
                            <button type="button" class="btn btn-primary" id="setIcon" style="display: flex;justify-content: center;gap: 10px;padding: 5px !important;"><i class="fas fa-cog settings-icon" style="margin-top: 9px;"></i><p style="font-size: 20px;color: white;">Settings</p></button>
                        </div>
                    </div>
                    <div class="order-details">
                        <div class="order-card">
                            <span class="icon" style="color: rgb(0, 200, 0);">
                                <ion-icon name="checkmark-done-outline"></ion-icon>
                            </span>
                            <h5>932</h5>
                            <p>Finished Orders</p>
                        </div>
                        <div class="order-card">
                            <span class="icon" style="color: rgb(255, 140, 0);">
                                <ion-icon name="checkmark-circle"></ion-icon>
                            </span>
                            <h5>1032</h5>
                            <p>Delivered Orders</p>
                        </div>
                        <div class="order-card">
                            <span class="icon" style="color: rgb(255, 0, 0);">
                                <ion-icon name="close-circle"></ion-icon>
                            </span>
                            <h5>103</h5>
                            <p>Cancelled Orders</p>
                        </div>
                    </div>
                    <div class="earning">
                        <div class="earning-details">
                            <div class="details-left">
                                <span class="icon"><ion-icon name="wallet-outline"></ion-icon></span>
                                <div>
                                    <p>Today's Earnings</p>
                                    <h5>₹2,530</h5>
                                </div>
                            </div>
                            <div class="details-right">
                                <%
                                    if ("Y".equals(executiveStatus)) {
                                %>
                                <form action="http://localhost:8080/Platera-Main/UpdateExecutiveStatus" method="post">
                                    <input type="hidden" name="executive_id" value="<%= executiveId%>">
                                    <input type="hidden" name="executive_status" value="N">
                                    <button class="end-delivery" type="submit">Call it a Day</button>
                                </form>
                                <%
                                } else if ("N".equals(executiveStatus)) {
                                %>
                                <form action="http://localhost:8080/Platera-Main/UpdateExecutiveStatus" method="post">
                                    <input type="hidden" name="executive_id" value="<%= executiveId%>">
                                    <input type="hidden" name="executive_status" value="Y">
                                    <button class="start-delivery" type="submit">Ready to Deliver</button>
                                </form>
                                <%
                                    }
                                %>
                            </div>


                        </div>
                        <hr />
                        <div class="distance-details">
                            <div class="distance-head">
                                <span>Total Trip</span>
                                <span>Total Distance</span>
                                <span>Total Time</span>
                            </div>
                            <div class="distance-values">
                                <span>15</span>
                                <span>15 Km</span>
                                <span>90 Min</span>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="dash-performance">
                    <!-- Current Order Section -->
                    <div class="current-order">
                        <%
                            OrdersDAO ordersDAO = new OrdersDAO();
                            List<Orders> ordersList = null;

                            try {
                                // Fetch orders using OrdersDAO
                                ordersList = ordersDAO.getAcceptedOrdersByDeliveryExecutiveId(executiveId);

                                if ("N".equals(executiveStatus)) {
                                    out.println("Press Ready to Deliver to see current orders.");
                                } else {
                                    // Check if there are no orders in the list
                                    if (ordersList.isEmpty() && "Y".equals(executiveStatus)) {
                                        out.println("No current order found.");
                                    }

                                    Orders currentOrder = ordersList.get(0); // Assuming we are displaying the first order for simplicity

                                    int restaurantId = currentOrder.getRestaurantId();

                                    RestaurantDAO restaurantDAO = new RestaurantDAO();
                                    Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId); // Fetch restaurant details by ID

                                    // Initialize the review count variable
                                    int reviewCount = 0;

                                    // Database connection setup
                                    String query = "SELECT COUNT(*) AS review_count FROM reviews WHERE restaurant_id = ?";

                                    // Establish the database connection and execute the query
                                    Connection con = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;

                                    try {
                                        // Get the connection
                                        con = Database.getConnection();

                                        // Prepare the query
                                        ps = con.prepareStatement(query);
                                        ps.setInt(1, restaurantId);

                                        // Execute the query
                                        rs = ps.executeQuery();

                                        // Retrieve the review count
                                        if (rs.next()) {
                                            reviewCount = rs.getInt("review_count");
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        // Close the ResultSet, PreparedStatement, and Connection
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
                                            if (ps != null) {
                                                ps.close();
                                            }
                                            if (con != null) {
                                                con.close();
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }
                        %>

                        <!-- Displaying the current order details -->
                        <div class="current-order">
                            <h2><ion-icon name="receipt-outline"></ion-icon> Current Order</h2>
                            <div class="order-details" onclick="toggleCurrentOrderDetails(this)">
                                <div class="order-row">
                                    <span class="icon"><ion-icon name="document-outline"></ion-icon></span>
                                    <strong>Order #<%= currentOrder.getOrderId()%></strong>
                                    <span class="arrow"><i class="fas fa-chevron-down dropdown-current"></i></span>
                                </div>
                                <div class="order-row">
                                    <span class="icon"><ion-icon name="restaurant-outline"></ion-icon></span>
                                            <%= currentOrder.getRestaurantName()%>
                                </div>
                                <div class="order-row">
                                    <span class="icon"><ion-icon name="pricetag-outline"></ion-icon></span>
                                            <%= currentOrder.getTotalAmount()%>
                                </div>
                                <div class="order-row">
                                    <span class="icon"><ion-icon name="location-outline"></ion-icon></span>
                                            <%= currentOrder.getCustomerAddress()%>
                                </div>
                                <div class="order-row">
                                    <span class="icon"><ion-icon name="checkmark-circle-outline"></ion-icon></span>
                                    Status: <strong class="status"><%=currentOrder.getOrderStatus()%></strong>
                                </div>
                            </div>

                            <div class="details-row">
                                <div class="details-container">
                                    <div class="order-menu">
                                        <h4>Items</h4>
                                        <%
                                            // You can loop through the order items list from the current order object
                                            for (OrderItem item : currentOrder.getOrderItems()) {
                                        %>
                                        <p><img src="<%=request.getContextPath()%>/<%=item.getImage()%>" alt="<%= item.getItemName()%> image"> <%= item.getItemName()%> (x<%=item.getQuantity()%>)</p>
                                            <%
                                                }
                                            %>
                                    </div>

                                    <div class="restaurant-info">
                                        <h4><%= currentOrder.getRestaurantName()%></h4>

                                        <!-- Display restaurant rating dynamically -->
                                        <p><i class="fas fa-star"></i> <%= restaurant.getRating()%> | <%= reviewCount%> Reviews</p>

                                        <p>Delivery Time: <strong>30 Min</strong></p>
                                        <p>
                                            <span class="icon"><ion-icon name="location-outline"></ion-icon></span>
                                            Address: <strong><%= currentOrder.getRestaurantAddress()%></strong>
                                        </p>
                                        <p>
                                            <span class="icon"><ion-icon name="call-outline"></ion-icon></span>
                                            Phone: <strong><%= currentOrder.getRestaurantPhone()%></strong>
                                        </p>
                                    </div>

                                    <div class="order-summary">
                                        <div class="order-summary-details">
                                            <span>
                                                <h4>Status</h4>
                                                <p><%= currentOrder.getPaymentStatus()%></p>
                                            </span>
                                            <span>
                                                <h4>Date Paid</h4>
                                                <p><%= currentOrder.getPaymentDate()%></p>
                                            </span>
                                            <span>
                                                <h4>Customer Phone</h4>
                                                <p>
                                                    <span class="icon"><ion-icon name="call-outline"></ion-icon></span>
                                                            <%= currentOrder.getCustomerPhone()%>
                                                </p>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="order-amt">
                                        <h4>Total</h4>
                                        <p class="total-amount" style="margin-bottom: 50px;">₹<%= currentOrder.getTotalAmount()%></p>
                                        <div class="details-right">
                                            <%
                                                // Directly using the getter in the equals method
                                                if ("Cooked".equals(currentOrder.getOrderStatus()) || "Accepted".equals(currentOrder.getOrderStatus())) {
                                            %>
                                            <form action="http://localhost:8080/Platera-Main/UpdateOrderStatus" method="post" onsubmit="return confirmPickup()">
                                                <input type="hidden" name="order_id" value="<%= currentOrder.getOrderId()%>">
                                                <input type="hidden" name="order_status" value="Picked Up">                                                     
                                                <button class="pickedup-button" type="submit">Picked up</button>

                                            </form>
                                            <%
                                            } else if ("Picked Up".equals(currentOrder.getOrderStatus())) {
                                            %>
                                            <form action="http://localhost:8080/Platera-Main/UpdateOrderStatus" method="post" onsubmit="return confirmHandover()">
                                                <input type="hidden" name="order_id" value="<%= currentOrder.getOrderId()%>">                                                       
                                                <input type="hidden" name="executive_status" value="Delivered">
                                                <button class="delivered-button" id="HandOver" type="submit">Handover</button>
                                            </form>
                                            <%
                                                }
                                            %>



                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <%}
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>





                    <!-- Statistics Section -->
                    <div class="statistics">
                        <h2><ion-icon name="list-outline"></ion-icon> Delivered Orders</h2>
                        <div class="yourOrders">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Order</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Address</th>
                                        <th>Total</th>
                                        <th>Payment Method</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        ordersDAO = new OrdersDAO();
                                        List<Orders> completedOrdersList = null;

                                        try {
                                            // Fetch completed orders using OrdersDAO
                                            completedOrdersList = ordersDAO.getCompletedOrdersByDeliveryExecutiveId(executiveId);

                                            if (completedOrdersList.isEmpty()) {
                                                out.println("<tr><td colspan='7'>No completed orders found.</td></tr>");
                                            } else {
                                                for (Orders order : completedOrdersList) {
                                                    int restaurantId = order.getRestaurantId();

                                                    // Use RestaurantDAO to get restaurant details including reviews and rating
                                                    RestaurantDAO restaurantDAO = new RestaurantDAO();
                                                    Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId); // Fetch restaurant details by ID

                                                    // Initialize the review count variable
                                                    int reviewCount = 0;

                                                    // Database connection setup
                                                    String query = "SELECT COUNT(*) AS review_count FROM reviews WHERE restaurant_id = ?";

                                                    // Establish the database connection and execute the query
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs = null;

                                                    try {
                                                        // Get the connection
                                                        con = Database.getConnection();

                                                        // Prepare the query
                                                        ps = con.prepareStatement(query);
                                                        ps.setInt(1, restaurantId);

                                                        // Execute the query
                                                        rs = ps.executeQuery();

                                                        // Retrieve the review count
                                                        if (rs.next()) {
                                                            reviewCount = rs.getInt("review_count");
                                                        }
                                                    } catch (Exception e) {
                                                        e.printStackTrace();
                                                    } finally {
                                                        // Close the ResultSet, PreparedStatement, and Connection
                                                        try {
                                                            if (rs != null) {
                                                                rs.close();
                                                            }
                                                            if (ps != null) {
                                                                ps.close();
                                                            }
                                                            if (con != null) {
                                                                con.close();
                                                            }
                                                        } catch (Exception e) {
                                                            e.printStackTrace();
                                                        }
                                                    }
                                    %>
                                    <!-- Dynamic Order Row -->
                                    <tr class="order-row" onclick="toggleDetailsGeneral(this)">
                                        <td class="menu">Order #<%= order.getOrderId()%></td>
                                        <td><span class="status completed">Completed</span></td>
                                        <td class="date"><%= order.getOrderDate()%></td>
                                        <td class="address">
                                            <i class="fas fa-map-marker-alt"></i> 
                                            <%= order.getCustomerAddress()%>
                                        </td>
                                        <td class="total"><span>₹<%= order.getTotalAmount()%></span></td>
                                        <td class="payment-method"><%= order.getPaymentMethod()%></td>
                                        <td class="arrow"><i class="fas fa-chevron-down dropdown"></i></td>
                                    </tr>
                                    <tr class="details-row">
                                        <td colspan="7">
                                            <div class="details-container">
                                                <div class="order-menu">
                                                    <h4>Order Menu</h4>
                                                    <%
                                                        for (OrderItem item : order.getOrderItems()) {
                                                    %>
                                                    <p><img src="<%=request.getContextPath()%>/<%= item.getImage()%>" alt="<%= item.getItemName()%> image"> <%= item.getItemName()%> (x<%= item.getQuantity()%>) </p>
                                                        <%
                                                            }
                                                        %>
                                                </div>
                                                <div class="restaurant-info">
                                                    <h4><%= order.getRestaurantName()%></h4>
                                                    <p><i class="fas fa-star"></i> <%=restaurant.getRating()%> | <%=reviewCount%> Reviews</p>
                                                    <p>Delivery Time: <strong>30 Min</strong></p>
                                                </div>
                                                <div class="order-summary">
                                                    <div class="order-summary-details">
                                                        <span>
                                                            <h4>Status</h4>
                                                            <p>Completed</p>
                                                        </span>
                                                        <span>
                                                            <h4>Date</h4>
                                                            <p><%=order.getOrderDate()%></p>
                                                        </span>
                                                    </div>
                                                    <div class="order-summary-details">

                                                        <span>
                                                            <h4>Date Paid</h4>
                                                            <p><%= order.getPaymentDate()%></p>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="order-amt">
                                                    <h4>Total</h4>
                                                    <p class="total-amount">₹<%= order.getTotalAmount()%></p>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <%
                                                }
                                            }
                                        } catch (Exception e) {
                                            out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                                            e.printStackTrace();
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>

        </main>
    </div>
</div>


<!-- Scripts  -->
<script>
    function confirmHandover() {
        return confirm("Are you sure you want to hand over the order?");
    }

    function confirmPickup() {
        return confirm("Are you sure you want to mark the order as picked up?");
    }
</script>
<script>
    // Confirmation for deleting account
    function confirmDelete() {
        return confirm("Are you sure you want to delete your account? This action cannot be undone.");
    }
</script>
<script>
    // JavaScript to handle the photo preview
    document.getElementById('photo-input').addEventListener('change', function (event) {
        const file = event.target.files[0]; // Get the selected file
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                // Update the img src in the preview div
                document.getElementById('profile-photo-preview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<!-- Icon Scripts -->

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="script.js"></script>
</body>
</html>

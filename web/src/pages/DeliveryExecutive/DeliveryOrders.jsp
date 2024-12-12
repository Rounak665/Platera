<%@page import="java.sql.SQLException"%>
<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delivery Orders</title>
        <link rel="stylesheet" href="Delivery.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>/* Popup container */
            .popup {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
                display: none; /* Initially hidden */
                justify-content: center;
                align-items: center;
            }

            /* Popup content */
            .popup .content {
                background: white;
                max-height: 80vh; /* Limit the height to 80% of the viewport height */
                width: 80%; /* Or set a fixed width */
                overflow-y: auto; /* Enable scrolling inside the content if it exceeds max-height */
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Optional: Styling the close button */
            .popup .close-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 24px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>


        <%

            // Integer user_id = (Integer) session.getAttribute("user_id");
            //            String name = (String) session.getAttribute("name");
            //            String email = (String) session.getAttribute("email");
            //            Integer delivery_executive_id = (Integer) session.getAttribute("delivery_executive_id");
            //            String image = (String) session.getAttribute("image");
            //            String imagepath = request.getContextPath() + '/' + image;
            //            int location_id = 0;
            //            String location = "";
            //For debugging
            int user_id = 257;
            String name = "Arthur Morgan";
            String email = "ArthurMorgan1863@gmail.com";
            int delivery_executive_id = 35;
            String image = "DatabaseImages/Delivery_Executives/Arthur_Morgan.jpeg";
            String imagepath = request.getContextPath() + '/' + image;
            int location_id = 0;
            String location = "";

            Connection conn = null;
            PreparedStatement selectSqlPstmt = null;
            PreparedStatement selectLocationPstmt = null;
            ResultSet selectSqlRs = null;
            ResultSet selectLocationSqlRs = null;

            try {
                // Get connection
                conn = Database.getConnection(); // Assuming getConnection method works with Java 1.5

                // First Query: Get location_id for the user
                try {
                    String selectSql = "SELECT location FROM delivery_executives WHERE user_id=?";
                    selectSqlPstmt = conn.prepareStatement(selectSql);
                    selectSqlPstmt.setInt(1, user_id); // Set parameter before executing the query

                    selectSqlRs = selectSqlPstmt.executeQuery(); // Execute the query

                    if (selectSqlRs.next()) {
                        location_id = selectSqlRs.getInt("location"); // Retrieve the location_id
                    } else {
                        out.println("Unexpected Error: No location found for user.");
                        return;
                    }
                } catch (SQLException e) {
                    out.println("Error executing the first query: " + e.getMessage());
                    e.printStackTrace();
                    return; // Return after logging the error
                }

                // Second Query: Get location name based on location_id
                try {
                    String selectLocationSql = "SELECT location_name FROM locations WHERE location_id=?";
                    selectLocationPstmt = conn.prepareStatement(selectLocationSql);
                    selectLocationPstmt.setInt(1, location_id); // Set parameter before executing the query

                    selectLocationSqlRs = selectLocationPstmt.executeQuery(); // Execute the query

                    if (selectLocationSqlRs.next()) {
                        location = selectLocationSqlRs.getString("location_name"); // Retrieve the location name
                    } else {
                        out.println("Unexpected Error: No location found for location_id.");
                        return;
                    }
                } catch (SQLException e) {
                    out.println("Error executing the second query: " + e.getMessage());
                    e.printStackTrace();
                    return; // Return after logging the error
                }

            } catch (SQLException e) {
                out.println("Error connecting to the database: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources manually to avoid resource leak
                try {
                    if (selectSqlRs != null) {
                        selectSqlRs.close();
                    }
                    if (selectLocationSqlRs != null) {
                        selectLocationSqlRs.close();
                    }
                    if (selectSqlPstmt != null) {
                        selectSqlPstmt.close();
                    }
                    if (selectLocationPstmt != null) {
                        selectLocationPstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException ex) {
                    out.println("Error closing resources: " + ex.getMessage());
                }
            }


        %>
        <%            //Fetching the orders
//            PreparedStatement ordersPstmt = null;
//            ResultSet ordersRs = null;
//
//            int order_id = 0;
//            int customer_id = 0;
//            String order_date = null;
//            double total_amount = 0;
//            String order_status = null;
//            String Address = null;
//
//            try {
//                conn = Database.getConnection();
//                String ordersSql = "SELECT * FROM orders WHERE location=? AND order_status='Pending'";
//                ordersPstmt = conn.prepareStatement(ordersSql);
//
//                ordersPstmt.setInt(1, location_id);
//
//                ordersRs = ordersPstmt.executeQuery();
//                if (ordersRs.next()) {
//                    order_id = ordersRs.getInt("order_id");
//                    customer_id = ordersRs.getInt("customer_id");
//                    order_date = ordersRs.getString("order_date");
//                    total_amount = ordersRs.getDouble("total_amount");
//                    Address = ordersRs.getString("address");
//                } else {
//                    out.println("Unexpected Error: No orders found");
//                    return;
//                }
//
//            } catch (SQLException e) {
//                out.println("Error connecting to the database: " + e.getMessage());
//                e.printStackTrace();
//            }

        %>

        <!-- loader -->
        <div class="loader">
            <div id="pl">
                <div>
                    <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
                </div>
            </div>
        </div>

        <!-- otp popup -->

        <section class="popup">
            <div class="otp-popup">
                <div class="otp-content">
                    <div class="otp-header">
                        <ion-icon name="close-circle" class="back-icon"></ion-icon>
                    </div>
                    <div class="otp-body">
                        <ion-icon name="notifications" class="otp-icon"></ion-icon>
                        <h2>Verify Delivery Handover</h2>
                        <p>We have sent you a one time password to customer's mobile</p>
                        <div class="otp-timer">2:00</div>
                        <div class="otp-input">
                            <input type="tel" maxlength="1" pattern="[0-9]*">
                            <input type="tel" maxlength="1" pattern="[0-9]*">
                            <input type="tel" maxlength="1" pattern="[0-9]*">
                            <input type="tel" maxlength="1" pattern="[0-9]*">
                        </div>
                        <p>Didn't receive the OTP? <a href="#">RESEND</a></p>
                        <button class="btn-verify">Verify</button>
                    </div>
                </div>
            </div>
        </section>

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
                            <a href="./DeliveryDashboard.jsp">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>
                        <li class="li_logout">
                            <a href="../AddRestaurent/AddRestaurent.html#Signin-popup">
                                <span class="icon"><ion-icon name="power"></ion-icon></span>
                                <span>Logout</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

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

                    <div class="order-list" id="order-list">
                        <%        // Assuming location_id has already been set
                            PreparedStatement ordersPstmt = null;
                            ResultSet ordersRs = null;

                            // Query to fetch all orders with the same location
                            conn = Database.getConnection();
                            String ordersSql = "SELECT * FROM orders WHERE location=? AND order_status='Pending'";
                            ordersPstmt = conn.prepareStatement(ordersSql);
                            ordersPstmt.setInt(1, location_id); // location_id already available

                            try {
                                ordersRs = ordersPstmt.executeQuery();

                                // Check if orders exist
                                boolean hasOrders = false;

                                while (ordersRs.next()) {
                                    hasOrders = true;

                                    // Fetch order details from result set
                                    int order_id = ordersRs.getInt("order_id");
                                    int customer_id = ordersRs.getInt("customer_id");
                                    String order_date = ordersRs.getString("order_date");
                                    double total_amount = ordersRs.getDouble("total_amount");
                                    String address = ordersRs.getString("address");

                                    // Display order details within the loop
                        %>
                        <!-- Order List Item -->
                        <div class="order-item">
                            <p>Order #<%= order_id%></p>
                            <!-- Trigger Button to Open Order Details Popup -->
                            <button class="view-details-btn" onclick="showOrderDetails(<%= order_id%>)">View Details</button>
                        </div>

                        <!-- Order Details Popup Section (Hidden by default) -->
                        <section class="delivery-order" id="order-<%= order_id%>" style="display: none;">
                            <div class="order-header">
                                <h1>Order Details</h1>
                            </div>

                            <div class="order-container">

                                <div class="order-info">
                                    <div class="order-number">
                                        <h3>Order #<%= order_id%></h3>
                                        <p>Order</p>
                                    </div>
                                    <div class="customer-info">
                                        <img src="https://t4.ftcdn.net/jpg/03/68/89/07/360_F_368890785_yPhrRtWYi0eRQkTaehpyAxytx0yX8Arx.jpg" alt="Customer">
                                        <div>
                                            <h4>Rubina Shah</h4>
                                            <p>User since 2020</p>
                                        </div>
                                    </div>
                                </div><hr>

                                <div class="order-dettails">
                                    <div class="delivery-address">
                                        <p>Delivery Address</p>
                                        <p><span class="icon ico">📍</span><strong style="font-size: 15px;"><%= address%></strong></p>
                                    </div>
                                    <div class="detail-grid">
                                        <div class="estimation-info">
                                            <p>Estimation Time</p>
                                            <p><strong>10 Min</strong></p>
                                        </div>
                                        <div class="payment-info">
                                            <p>Payment</p>
                                            <p><strong>E-Wallet</strong></p>
                                        </div>
                                        <div class="distance-info">
                                            <p>Distance</p>
                                            <p><strong>2.5 Km</strong></p>
                                        </div>
                                        <div class="payment-status">
                                            <p>Payment Status</p>
                                            <p><strong>Completed</strong></p>
                                        </div>
                                    </div>
                                </div> <hr>

                                <div class="order-items">
                                    <div class="order-item">
                                        <img src="https://cdn.shopify.com/s/files/1/0274/9503/9079/files/20220211142754-margherita-9920_5a73220e-4a1a-4d33-b38f-26e98e3cd986.jpg?v=1723650067" alt="Pizza" />
                                        <div>
                                            <p><strong>Pepperoni Pizza</strong></p>
                                            <p>x1</p>
                                        </div>
                                        <div class="item-price">
                                            <p>+₹230</p>
                                        </div>
                                    </div>
                                    <div class="order-item">
                                        <img src="https://www.sargento.com/assets/Uploads/Recipe/Image/GreatAmericanBurger__FillWzExNzAsNTgzXQ.jpg" alt="Cheese Burger" />
                                        <div>
                                            <p><strong>Cheese Burger</strong></p>
                                            <p>x1</p>
                                        </div>
                                        <div class="item-price">
                                            <p>+₹220</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="order-total">
                                    <p>Total</p>
                                    <p class="total-amount">₹<%= total_amount%></p>
                                </div>

                                <div class="order-actions">
                                    <button class="reject-order">Reject Order</button>
                                    <button class="accept-order">Accept Order</button>
                                </div>

                            </div>
                        </section>
                        <%
                            }

                            // If no orders were found for the given location
                            if (!hasOrders) {
                        %>
                        <p>No pending orders available for this location.</p>
                        <%
                                }
                            } catch (SQLException e) {
                                out.println("Error fetching orders: " + e.getMessage());
                                e.printStackTrace();
                            }
                        %>
                    </div>

                    <script>
                        // JavaScript function to display order details on button click
                        function showOrderDetails(orderId) {
                            const orderDetails = document.getElementById("order-" + orderId);
                            if (orderDetails.style.display === "none") {
                                orderDetails.style.display = "block";
                            } else {
                                orderDetails.style.display = "none";
                            }
                        }
                    </script>



            </div>
        </main>


    </div>
</div>

<!-- Scripts  -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<!-- Icon Scripts -->

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="./script.js"></script>


</body>
</html>

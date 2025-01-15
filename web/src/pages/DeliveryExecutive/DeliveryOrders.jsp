<%@page import="Utilities.DeliveryExecutiveDAO"%>
<%@page import="Utilities.DeliveryExecutive"%>
<%@page import="Utilities.OrderDetailsDAO"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="Utilities.OrderDetails"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
        <title>Platera - Delivery Orders</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="./Delivery.css">

    </head>
    <body>


        <%
            // Simulate session attributes for debugging
            int user_id = (Integer) session.getAttribute("user_id");
//            int user_id = 282;

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


        %>


        <!-- loader -->
        <div class="loader">
            <div id="pl">
                <div>
                    <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
                </div>
            </div>
        </div>

        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
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
                        <%                            if ("N".equals(executiveStatus)) {
                        %>
                        <li class="logoutOption">
                            <form action="http://localhost:8080/Platera-Main/logout" method="POST">                          
                                <button type="submit"><span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>Logout</button>
                            </form>
                        </li>
                        <%
                        } else if ("Y".equals(executiveStatus)) {
                        %>
                        <li class="logoutOption">
                            <p>Change your status</p>
                        </li>
                        <%
                            }
                        %>
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


                    <div class="social-icons">
                    </div>
                </header>

                <main>


                    <%                        if ("Y".equals(executiveStatus)) {
                    %>
                    <div class="order-list" id="order-list" style="display: block;">
                        <%
                            // Fetch the orders using OrderDetailsDAO
                            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
                            List<OrderDetails> orderDetailsList = null;

                            orderDetailsList = orderDetailsDAO.getOrdersByLocation(locationId);

                            if (orderDetailsList != null && !orderDetailsList.isEmpty()) {
                                // Loop through the list of orders
                                for (OrderDetails order : orderDetailsList) {
                        %>
                        <!-- Order List Item -->
                        <div class="order-item">
                            <p>Order #<%= order.getOrderId()%></p>
                            <button class="view-details-btn" onclick="showOrderDetails(<%= order.getOrderId()%>)">View Details</button>
                        </div>

                        <!-- Order Details Popup Section (Hidden by default) -->
                        <section class="delivery-order" id="order-<%= order.getOrderId()%>">
                            <div class="order-header">
                                <h1>Order Details</h1>
                            </div>

                            <div class="order-container">
                                <div class="order-info">
                                    <div class="order-number">
                                        <h3>Order #<%= order.getOrderId()%></h3>
                                    </div>
                                    <div class="customer-info">
                                        <img src="<%= request.getContextPath() + "/" + order.getCustomerImage()%>" alt="Customer">
                                        <div>
                                            <h4><%= order.getCustomerName()%></h4>
                                        </div>
                                    </div>
                                </div>
                                <hr>

                                <div class="order-detail">
                                    <div class="delivery-address">
                                        <p><span class="icon ico">🍴</span><strong style="font-size: 15px;"><%= order.getRestaurantAddress()%></strong></p>
                                    </div>
                                    <div class="restaurant-address">
                                        <p><span class="icon ico">📍</span><strong style="font-size: 15px;"><%= order.getCustomerAddress()%></strong></p>
                                    </div>
                                    <div class="estimation-info">
                                        <p>Estimation Time</p>
                                        <p><strong>30 Min</strong></p>
                                    </div>
                                    <div class="payment-info">
                                        <p>Payment Method</p>
                                        <p><strong><%= order.getPaymentMethod()%></strong></p>
                                    </div>
                                    <div class="distance-info">
                                        <p>Distance</p>
                                        <p><strong>2.5 Km</strong></p>
                                    </div>
                                    <div class="payment-status">
                                        <p>Payment Status</p>
                                        <p><strong><%= order.getPaymentStatus()%></strong></p>
                                    </div>
                                </div>
                                <hr>

                                <div class="order-items">
                                    <%
                                        // Display all items for the order using the items list in OrderDetails
                                        List<OrderItem> items = order.getItems(); // Assuming getItems() returns a list of OrderItem
                                        if (items != null && !items.isEmpty()) {
                                            for (OrderItem item : items) {
                                                String itemName = item.getItemName();
                                                int quantity = item.getQuantity();
                                    %>
                                    <div class="order-item">
                                        <p><img src="<%= request.getContextPath()%>/<%= item.getImage()%>" alt="<%= item.getItemName()%>"><%= itemName%> (x<%= quantity%>)</p>
                                    </div>
                                    <%
                                            }
                                        }
                                    %>
                                </div>

                                <div class="order-total">
                                    <p>Total</p>
                                    <p class="total-amount">₹<%= order.getTotalAmount()%></p>
                                </div>

                                <div class="order-actions">
                                    <form action="http://localhost:8080/Platera-Main/AcceptOrder" method="POST">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderId()%>">
                                        <input type="hidden" name="deliveryExecutiveId" value="<%= executiveId%>">
                                        <input type="hidden" name="deliveryAddress" value="<%= order.getCustomerAddress()%>">
                                        <button type="submit" class="accept-order">Accept Order</button>
                                    </form>
                                </div>
                            </div>
                        </section>
                        <%
                            }
                        } else {
                        %>
                        <p>No pending orders available for this location.</p>
                        <%
                            }
                        %>
                    </div>
                    <%
                    } else {
                    %>
                    <p>Please press on the "Ready to Deliver" button on the dashboard page to view available orders.</p>
                    <%
                        }
                    %>




                    <div id="overlay" class="overlay"></div>
            </div>
        </main>


    </div>
</div>

<!-- Scripts  -->
<script>
    // JavaScript function to display order details on button click
    function showOrderDetails(orderId) {
        const orderDetails = document.getElementById("order-" + orderId);
        const overlay = document.getElementById("overlay");

        // Check if the orderDetails div is already open
        if (orderDetails.style.right === "0px") {
            orderDetails.style.right = "-100%";  // Slide out
            overlay.style.display = "block";  // Hide overlay
        } else {
            // Hide all other open orders first
            const openOrder = document.querySelector(".delivery-order.open");
            if (openOrder) {
                openOrder.style.right = "-100%";
                openOrder.classList.remove("open");
            }

            // Open the selected order's details
            orderDetails.style.right = "0";  // Slide in
            orderDetails.classList.add("open");
            overlay.style.display = "block";  // Show overlay
        }
    }

// Close the details section if the overlay is clicked
    document.getElementById("overlay").onclick = function () {
        const openOrder = document.querySelector(".delivery-order.open");
        if (openOrder) {
            openOrder.style.right = "-100%";  // Slide out
            openOrder.classList.remove("open");
            document.getElementById("overlay").style.display = "none";  // Hide overlay
        }
    }

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<!-- Icon Scripts -->

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<!--<script src="./Delivery.js"></script>-->

<script src="../../../error.js"></script>
</body>
</html>

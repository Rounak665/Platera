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
        <title>Delivery Orders</title>       
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="./Delivery.css">

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
        %>
        
        <%
            Connection conn = null;
            PreparedStatement selectLocationDetailsPstmt = null;
            ResultSet selectLocationDetailsRs = null;
            String location_name = null;
            int location_id = 1;

            try {
                // Get connection
                conn = Database.getConnection(); // Assuming getConnection method works with Java 1.5

                try {
                    // Single query using JOIN to fetch location_name and location_id directly
                    String selectLocationDetailsSql = "SELECT l.location_id, l.location_name "
                            + "FROM delivery_executives de "
                            + "JOIN locations l ON de.location = l.location_id "
                            + "WHERE de.user_id = ?";
                    selectLocationDetailsPstmt = conn.prepareStatement(selectLocationDetailsSql);
                    selectLocationDetailsPstmt.setInt(1, user_id); // Set the user_id parameter

                    selectLocationDetailsRs = selectLocationDetailsPstmt.executeQuery(); // Execute the query

                    if (selectLocationDetailsRs.next()) {
                        location_id = selectLocationDetailsRs.getInt("location_id");
                        location_name = selectLocationDetailsRs.getString("location_name");
                    } else {
                        out.println("Unexpected Error: No location found for user.");
                        return;
                    }
                } catch (SQLException e) {
                    out.println("Error executing the query: " + e.getMessage());
                    e.printStackTrace();
                    return; // Return after logging the error
                }
            } catch (SQLException e) {
                out.println("Error connecting to the database: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources manually to avoid resource leaks
                try {
                    if (selectLocationDetailsRs != null) {
                        selectLocationDetailsRs.close();
                    }
                    if (selectLocationDetailsPstmt != null) {
                        selectLocationDetailsPstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException ex) {
                    out.println("Error closing resources: " + ex.getMessage());
                }
            }

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

                    <div class="order-list" id="order-list" style="display: block;">
                        <%        // Assuming location_id has already been set
                            PreparedStatement ordersPstmt = null;
                            ResultSet ordersRs = null;

                            // Query to fetch all orders with the same location
                            conn = Database.getConnection();
                            String ordersSql = "SELECT o.order_id, o.customer_id, u.name AS customer_name, "
                                    + "c.image AS customer_image, o.order_date, o.total_amount, "
                                    + "o.address AS customer_address, oi.item_id, m.item_name, oi.quantity, "
                                    + "o.restaurant_id, r.restaurant_name, r.address AS restaurant_address, r.image as restaurant_image, "
                                    + "p.payment_method, p.payment_status "
                                    + "FROM orders o "
                                    + "LEFT JOIN payments p ON o.order_id = p.order_id "
                                    + "JOIN customers c ON o.customer_id = c.customer_id "
                                    + "JOIN users u ON c.user_id = u.user_id "
                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                    + "JOIN menu_items m ON oi.item_id = m.item_id "
                                    + "JOIN restaurants r ON r.restaurant_id = o.restaurant_id "
                                    + "WHERE o.location = ? AND o.order_status = 'Pending'";

                            ordersPstmt = conn.prepareStatement(ordersSql);
                            ordersPstmt.setInt(1, location_id); // location_id already available

                            List<OrderDetails> orderDetailsList = new ArrayList<OrderDetails>();  // List to store OrderDetails objects
                            int currentOrderId = -1;
                            OrderDetails currentOrder = null;

                            try {
                                ordersRs = ordersPstmt.executeQuery();

                                // Check if orders exist
                                boolean hasOrders = false;

                                while (ordersRs.next()) {
                                    hasOrders = true;

                                    int orderId = ordersRs.getInt("order_id");

                                    // When a new order is encountered, save the previous order's details
                                    if (orderId != currentOrderId && currentOrderId != -1) {
                                        orderDetailsList.add(currentOrder);  // Add the completed order to the list
                                    }

                                    // Update order-level details for the current order
                                    currentOrderId = orderId;

                                    if (currentOrder == null || currentOrder.orderId != orderId) {
                                        // Create a new OrderDetails object for a new order
                                        currentOrder = new OrderDetails();
                                                currentOrder.orderId=orderId;
                                                currentOrder.restaurantId=ordersRs.getInt("restaurant_id");
                                                currentOrder.restaurantName=ordersRs.getString("restaurant_name");
                                                currentOrder.restaurantImage=ordersRs.getString("restaurant_image");
                                                currentOrder.restaurantAddress=ordersRs.getString("restaurant_address");
                                                currentOrder.customerId=ordersRs.getInt("customer_id");
                                                currentOrder.customerName=ordersRs.getString("customer_name");
                                                currentOrder.customerImage=ordersRs.getString("customer_image");;
                                                currentOrder.customerAddress=ordersRs.getString("customer_address");
                                                currentOrder.orderDate=ordersRs.getString("order_date");
                                                currentOrder.totalAmount=ordersRs.getDouble("total_amount");
                                                currentOrder.paymentMethod=ordersRs.getString("payment_method");
                                                currentOrder.paymentStatus=ordersRs.getString("payment_status");
                                    }

                                    // Add item details to the current order with quantity
                                    int itemId = ordersRs.getInt("item_id");
                                    String itemName = ordersRs.getString("item_name");
                                    int quantity = ordersRs.getInt("quantity");
                                    currentOrder.addItem(itemId, itemName, quantity);
                                }

                                // Add the last order's details to the list
                                if (currentOrder != null) {
                                    orderDetailsList.add(currentOrder);
                                }

                                // Now you can display the orders or process the orderDetailsList
                                for (OrderDetails order : orderDetailsList) {
                        %>
                        <!-- Order List Item -->
                        <div class="order-item">
                            <p>Order #<%= order.orderId%></p>
                            <button class="view-details-btn" onclick="showOrderDetails(<%= order.orderId%>)">View Details</button>
                        </div>

                        <!-- Order Details Popup Section (Hidden by default) -->
                        <section class="delivery-order" id="order-<%= order.orderId%>"  >
                            <div class="order-header">
                                <h1>Order Details</h1>
                            </div>

                            <div class="order-container">
                                <div class="order-info">
                                    <div class="order-number">
                                        <h3>Order #<%= order.orderId%></h3>
                                        <!--<p>Order</p>-->
                                    </div>
                                    <div class="customer-info">
                                        <img src="<%= request.getContextPath() + "/" + order.customerImage%>" alt="Customer">
                                        <div>
                                            <h4><%= order.customerName%></h4>
                                        </div>
                                    </div>
                                </div><hr>

                                <div class="order-detail">
                                    <!--<div class="addresses">-->
                                    <div class="delivery-address">
                                        <p><span class="icon ico">📍</span><strong style="font-size: 15px;"><%= order.customerAddress%></strong></p>
                                    </div>
                                    <div class="restaurant-address">
                                        <p><span class="icon ico">🍴</span><strong style="font-size: 15px;"><%= order.restaurantAddress%></strong></p>
                                    </div>
                                    <!--</div>-->
                                    <!--<div class="detail-grid">-->
                                    <div class="estimation-info">
                                        <p>Estimation Time</p>
                                        <p><strong>30 Min</strong></p>
                                    </div>
                                    <div class="payment-info">
                                        <p>Payment Method</p>
                                        <p><strong><%=order.paymentMethod%></strong></p>
                                    </div>
                                    <div class="distance-info">
                                        <p>Distance</p>
                                        <p><strong>2.5 Km</strong></p>
                                    </div>
                                    <div class="payment-status">
                                        <p>Payment Status</p>
                                        <p><strong><%=order.paymentStatus%></strong></p>
                                    </div>
                                    <!--</div>-->
                                </div><hr>

                                <div class="order-items">
                                    <%
                                        // Display all items for the order using the items list in OrderDetails
                                        for (OrderItem item : order.getItems()) {
                                            String itemName = item.getItemName();
                                            int quantity = item.getQuantity();
                                    %>
                                    <div class="order-item">
                                        <p><%= itemName%> (x<%= quantity%>)</p> <!-- Display item name and quantity -->
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>

                                <div class="order-total">
                                    <p>Total</p>
                                    <p class="total-amount">₹<%= order.totalAmount%></p>
                                </div>

                                <div class="order-actions">
                                    <form action="http://localhost:8080/Platera-Main/AcceptOrder" method="POST">
                                        <input type="hidden" name="orderId" value="<%=order.orderId%>">
                                        <input type="hidden" name="deliveryExecutiveId" value="<%=delivery_executive_id%>">
                                        <input type="hidden" name="deliveryAddress" value="<%=order.customerAddress%>">
                                        <button type="submit" class="accept-order">Accept Order</button>
                                    </form>                                   
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
                            } finally {
                                // Close resources
                                if (ordersRs != null) {
                                    try {
                                        ordersRs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (ordersPstmt != null) {
                                    try {
                                        ordersPstmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (conn != null) {
                                    try {
                                        conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        %>
                    </div>
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

</body>
</html>

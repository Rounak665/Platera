<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="Utilities.OrdersDAO"%>
<%@page import="Utilities.Orders"%>
<%@page import="Utilities.Orders"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Customer Dashboard</title>
        <link rel="shortcut icon" href="../../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="Customer_Dashboard.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    </head>
    <body>
        <%
            // Retrieve user_id from the session
//            Integer user_id = (Integer)session.getAttribute("user_id");

            int user_id = 201;

            // Initialize necessary variables
            String name = "";
            String email = "";
            int customer_id = 0;
            String image = "";
            String imagepath = "";
            int location_id = 0;
            String location = "";
            String address = "";
            String phone = "";
            boolean twoFA;

            Customer customer = CustomerDAO.getCustomerByUserId(user_id);
            if (customer != null) {
                customer_id = customer.getCustomerId();
                name = customer.getFullName();
                email = customer.getEmail();
                image = customer.getImage();
                location_id = customer.getLocationId();
                location = customer.getLocation();
                address = customer.getAddress();
                phone = customer.getPhone();
                twoFA = customer.isTwoStepVerification();
            }

            // Create image path based on the image file path retrieved
            imagepath = request.getContextPath() + '/' + image;

        %>
        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>




        <div class="dashboard-container">
            <aside class="sidebar">
                <div class="sidebar-toggle menu" id="menu">
                    <ion-icon name="menu"></ion-icon>
                </div>
                <div class="sidebar-toggle close-btn">
                    <ion-icon name="close-outline" class="ico"></ion-icon>
                </div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="<%=request.getContextPath()%>/Public/images/logo.png" alt="Logo">
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="./CustomerProfile.jsp">
                                <span class="icon"><ion-icon name="person"></ion-icon></span>
                                <span>Account</span>
                            </a>
                        </li>
                        <li>
                            <a href="./CustomerOrder.jsp">
                                <span class="icon"><ion-icon name="receipt-outline"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>


                    </ul>
                </div>
            </aside>

            <div class="content">
                <div class="profile-header">
                    <div class="headerLogo">
                        <div class="logo">
                            <img src="../../../Public/images/logo.png" alt="Logo">
                        </div>
                    </div>
                    <h1>Welcome, <%=name%>!</h1>
                    <button class="edit_btn">Edit Profile</button>
                </div>
                <main class="main-content">
                    <section class="dashboard-section" id="orders">
                        <h2 id="OrderHeader">Your Orders</h2>



                        <div class="order-container">
                            <%
                                // Fetch the orders for the given customer using the customer ID
                                OrdersDAO ordersDAO = new OrdersDAO();
                                List<Orders> orders = ordersDAO.getOrdersByCustomerId(customer_id);

                                // Loop through each order and display it in the table
                                for (Orders currentOrder : orders) {
                                    int restaurantId = currentOrder.getRestaurantId();
                                    RestaurantDAO restaurantDAO = new RestaurantDAO();
                                    Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId); // Fetch restaurant details
                                    double rating = restaurant.getRating(); // Get the rating from the Restaurant object
                            %>

                            <div class="order-card">
                                <h2>Order #<%= currentOrder.getOrderId()%></h2>
                                <p><%= currentOrder.getOrderDate()%></p>
                                <hr>
                                <div class="restaurant-name"><%= currentOrder.getRestaurantName()%></div>
                                <div class="rating">&#9733; <%= rating%></div>
                                <p>Date Paid:<%= currentOrder.getPaymentDate()%></p>
                                <hr>
                                <div class="info">
                                    <div>
                                        <span>Delivery Time</span>
                                        <span><strong>30 Min</strong></span>
                                    </div>
                                    <div>
                                        <span>Distance</span>
                                        <span><strong>2.5 Km</strong></span>
                                    </div>
                                </div>
                                <hr>
                                <div class="order-menu1">
                                    <%
                                        // Loop through each order item and display it
                                        for (OrderItem item : currentOrder.getOrderItems()) {
                                    %>
                                    <div class="item">
                                        <img src="<%= request.getContextPath() + "/" + item.getImage()%>" alt="<%= item.getItemName()%>" class="cart-item-image">
                                        <div class="details"><%= item.getItemName()%><br>x<%= item.getQuantity()%></div>
                                        <div class="price">$300</div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <hr>
                                <div class="total">Total: $<%= currentOrder.getTotalAmount()%></div>
                                <div class="status <%= currentOrder.getOrderStatus().toLowerCase()%>"><%= currentOrder.getOrderStatus()%></div>
                            </div>
                            <%
                                }
                            %>

                        </div>

                    </section>
                </main>
            </div>
        </div>
        <script src="script.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    </body>
</html>

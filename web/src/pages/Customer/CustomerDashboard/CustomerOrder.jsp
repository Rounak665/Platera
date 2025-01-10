<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="Utilities.OrdersDAO"%>
<%@page import="Utilities.Orders"%>
<%@page import="Utilities.Orders"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Customer Dashboard</title>
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
                        <h2>Your Orders</h2>

                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Menu</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Address</th>
                                        <th>Total</th>
                                        <th>Payment Method</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
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
                                    <tr class="order-row" onclick="toggleDetails(this)">
                                        <td class="menu">Order #<%= currentOrder.getOrderId()%></td>
                                        <td><span class="status <%= currentOrder.getOrderStatus().toLowerCase()%>"><%= currentOrder.getOrderStatus()%></span></td>
                                        <td class="date"><%= currentOrder.getOrderDate()%></td>
                                        <td class="address"><i class="fas fa-map-marker-alt"></i> <%= currentOrder.getCustomerAddress()%></td>
                                        <td class="total"><span>$ <%= currentOrder.getTotalAmount()%></span></td>
                                        <td class="payment-method"><%= currentOrder.getPaymentMethod()%></td>
                                        <td class="arrow"><i class="fas fa-chevron-down dropdown"></i></td>
                                    </tr>
                                    <tr class="details-row">
                                        <td colspan="7">
                                            <div class="details-container">
                                                <div class="order-menu">
                                                    <h4>Order Menu</h4>
                                                    <%
                                                        // Loop through each order item and display it
                                                        for (OrderItem item : currentOrder.getOrderItems()) {
                                                    %>
                                                    <p><img src="<%= request.getContextPath() + "/" + item.getImage()%>" alt="<%= item.getItemName()%>"> <%= item.getItemName()%> (x<%= item.getQuantity()%>)</p>
                                                        <%
                                                            }
                                                        %>
                                                </div>
                                                <div class="restaurant-info">
                                                    <h4><%= currentOrder.getRestaurantName()%></h4>
                                                    <!-- Displaying dynamic restaurant rating -->
                                                    <p><i class="fas fa-star"></i> <%= rating%> </p>
                                                    <p>Delivery Time: <strong>10 Min</strong></p>
                                                    <p>Distance: <strong>2.5 Km</strong></p>
                                                </div>
                                                <div class="order-summary">
                                                    <div class="order-summary-details">
                                                        <span>
                                                            <h4>Status</h4>
                                                            <p><%= currentOrder.getOrderStatus()%></p>
                                                        </span>
                                                        <span>
                                                            <h4>Date</h4>
                                                            <p><%= currentOrder.getOrderDate()%></p>
                                                        </span>
                                                    </div>
                                                    <div class="order-summary-details">
                                                        <span>
                                                            <h4>Bills</h4>
                                                            <p>Order #<%= currentOrder.getOrderId()%></p>
                                                        </span>
                                                        <span>
                                                            <h4>Date Paid</h4>
                                                            <p><%= currentOrder.getPaymentDate()%></p>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="order-amt">
                                                    <h4>Total</h4>
                                                    <p class="total-amount">$<%= currentOrder.getTotalAmount()%></p>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>


                            </table>

                        </div>
                    </section>


                    <!-- <section class="dashboard-section" id="membership">
                        <h2>Platera Membership</h2>
                        <div class="content">
                            <p>Become a premium member to enjoy exclusive discounts and perks!</p>
                        </div>
                    </section>
        
                    <section class="dashboard-section" id="favorites">
                        <h2>Your Favorites</h2>
                        <div class="content">
                            <p>Save your favorite dishes and restaurants here for quick access!</p>
                        </div>
                    </section>
        
                    <section class="dashboard-section" id="payments">
                        <h2>Payment Methods</h2>
                        <div class="content">
                            <p>Manage your payment methods for seamless checkout experiences.</p>
                        </div>
                    </section>
        
                    <section class="dashboard-section" id="addresses">
                        <h2>Saved Addresses</h2>
                        <div class="content">
                            <p>Add and manage your delivery addresses here.</p>
                        </div>
                    </section>
        
                    <section class="dashboard-section" id="settings">
                        <h2>Account Settings</h2>
                        <div class="content">
                            <p>Update your personal information, password, and preferences here.</p>
                        </div>
                    </section> -->
                </main>
            </div>
        </div>
        <script src="script.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    </body>
</html>

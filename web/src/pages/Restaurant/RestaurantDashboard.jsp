<%@page import="Utilities.OrderItem"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="Utilities.OrderDetails"%>
<%@page import="Utilities.OrderDetails"%>
<%@page import="Utilities.OrderDetailsDAO"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.Restaurant"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.Database"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Restaurant Dashboard Overview</title>
        <link rel="stylesheet" href="./RestaurantDashboard.css"> <!-- Link to your CSS -->
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

        <!-- loader -->
        <div class="loader">
            <div id="pl">
                <div>
                    <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
                </div>
            </div>
        </div>

        <div>
            <div class="sidebar">
                <div class="sidebar-toggle menu" id="menu">
                    <ion-icon name="menu"></ion-icon>
                </div>
                <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="icon"></ion-icon></div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="">
                    </div>
                </div>

                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="./RestaurantDashboard.jsp">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantCategory.jsp">
                                <span class="icon"><ion-icon name="grid"></ion-icon></span>
                                <span>Categories</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantMenu.jsp">
                                <span class="icon"><ion-icon name="book"></ion-icon></span>
                                <span>Menu</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantOrders.jsp">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="main-content">
                <header>
                    <div class="search-wrapper">
                        <span class="icon"><ion-icon name="search"></ion-icon></span>
                        <input type="search" placeholder="Search">
                    </div>
                    <div class="social-icons">
                        <a href="http://localhost:8080/Platera-Main/logout" class="logout-link">
                            <div class="logout_btn">
                                <span class="logout">Logout</span>
                                <span class="icon"><ion-icon name="power"></ion-icon></span>
                            </div>
                        </a>
                    </div>
                </header>

                <main>
                    <h2 class="dash-title">Overview</h2>

                    <div class="dash-cards">
                        <div class="card-single">
                            <div class="card-body">
                                <span class="icon"><ion-icon name="card"></ion-icon></span>
                                <div>
                                    <h5>Account Balance</h5>
                                    <h4>₹30,659.45</h4>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="">View all</a>
                            </div>
                        </div>

                        <div class="card-single">
                            <div class="card-body">
                                <span class="icon"><ion-icon name="sync"></ion-icon></span>
                                <div>
                                    <h5>Pending</h5>
                                    <h4>₹19,500.45</h4>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="">View all</a>
                            </div>
                        </div>

                        <div class="card-single">
                            <div class="card-body">
                                <span class="icon"><ion-icon name="checkbox"></ion-icon></span>
                                <div>
                                    <h5>Processed</h5>
                                    <h4>₹20,659</h4>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="">View all</a>
                            </div>
                        </div>
                    </div>
                    <%
                        // Simulate session attributes for debugging
                        // int user_id = (Integer) session.getAttribute("user_id");
                        int user_id = 185;

                        int restaurantId = 0; // Default value for int
                        String name = null;
                        String address = null;
                        String phone = null;
                        String locationName = null;
                        double minPrice = 0.0; // Default value for double
                        double maxPrice = 0.0; // Default value for double
                        double avgRating = 0.0; // Default value for double
                        String category1 = null;
                        String category2 = null;
                        String category3 = null;
                        String imagePath = null;

                        // Owner details
                        String ownerPhone = null;
                        String ownerAddress = null;
                        String ownerEmail = null;
                        boolean twoFA = false; // Default value for boolean

                        Restaurant restaurant = null;

                        RestaurantDAO restaurantDAO = new RestaurantDAO();
                        restaurant = restaurantDAO.getRestaurantByUserId(user_id);

                        if (restaurant != null) {
                            restaurantId = restaurant.getRestaurantId();
                            name = restaurant.getName();
                            address = restaurant.getAddress();
                            phone = restaurant.getPhone();
                            locationName = restaurant.getLocation();
                            minPrice = restaurant.getMinPrice();
                            maxPrice = restaurant.getMaxPrice();
                            avgRating = restaurant.getRating();
                            category1 = restaurant.getCategory1();
                            category2 = restaurant.getCategory2();
                            category3 = restaurant.getCategory3();
                            imagePath = request.getContextPath() + '/' + restaurant.getImage();

                            // Owner details
                            ownerPhone = restaurant.getOwnerPhone();
                            ownerAddress = restaurant.getOwnerAddress();
                            ownerEmail = restaurant.getOwnerEmail();
                            twoFA = restaurant.isTwoStepVerification();
                        }
                    %>

                    <section class="recent">
                        <div class="activity-card">
                            <h3>Recent Orders</h3>
                            <div class="table-responsive">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Customer Name</th>
                                            <th>Order Date</th>
                                            <th>Items</th>
                                            <th>Total Amount</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            // Initialize DAO and fetch order details
                                            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
                                            List<OrderDetails> recentOrders = orderDetailsDAO.getOrderDetailsByRestaurantId(restaurantId); // Fetch data dynamically

                                            // Loop through fetched orders and display them
                                            if (recentOrders != null && !recentOrders.isEmpty()) {
                                                for (OrderDetails order : recentOrders) {
                                        %>
                                        <tr>
                                            <td><%= order.getOrderId()%></td>
                                            <td><%= order.getCustomerName()%></td>
                                            <td><%= order.getOrderDate()%></td>
                                            <td>
                                                <div class="order-items">
                                                    <%
                                                        // Display all items for the current order
                                                        List<OrderItem> items = order.getItems(); // Assuming getItems() returns a list of OrderItem
                                                        if (items != null && !items.isEmpty()) {
                                                            for (OrderItem item : items) {
                                                                String itemName = item.getItemName();
                                                                int quantity = item.getQuantity();
                                                                String itemImage = item.getImage(); // Assuming this returns the image path
                                                    %>
                                                    <div class="order-item">
                                                        <p>
                                                            <%= itemName%> (x<%= quantity%>)
                                                        </p>
                                                    </div>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </div>
                                            </td>
                                            <td><%= order.getTotalAmount()%></td>
                                            <td><%= order.getOrderStatus()%></td>
                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <tr>
                                            <td colspan="6">No recent orders available.</td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>

                </main>
            </div>
        </div>

        <!-- Scripts  -->

        <!-- Icon Scripts -->

        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <!-- main scripts -->

        <script>
            document.querySelector("#menu").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.add("activate");
            });

            document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.remove("activate");
            });
        </script>



    </body>
</html>

<%@page import="Utilities.OrderDetailsDAO"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="Utilities.OrderDetails"%>
<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Utilities.Database"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Restaurant Orders</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="RestaurantDashboard.css"> <!-- Link to your CSS -->
        <style>
            /* Styling for the button */
            .food-ready-btn {
                background-color: #4CAF50; /* Green background */
                color: white; /* White text */
                border: none; /* No border */
                padding: 10px 20px; /* Padding inside the button */
                font-size: 16px; /* Text size */
                cursor: pointer; /* Cursor on hover */
                border-radius: 5px; /* Rounded corners */
                transition: background-color 0.3s; /* Smooth transition for background color */
            }

            /* Hover effect */
            .food-ready-btn:hover {
                background-color: #45a049; /* Slightly darker green */
            }

            /* Active state */
            .food-ready-btn:active {
                background-color: #388e3c; /* Even darker green when clicked */
            }

            /* Optional: Add some margin between the button and the cell */
            td button {
                margin: 5px;
            }
        </style>

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
                <%

                    // Simulate session attributes for debugging
                    //int user_id = (Integer) session.getAttribute("user_id");
                    int user_id = 311;

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
                    String restaurantImagePath = null;

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
                        restaurantImagePath = request.getContextPath() + '/' + restaurant.getImage();

                        // Owner details
                        ownerPhone = restaurant.getOwnerPhone();
                        ownerAddress = restaurant.getOwnerAddress();
                        ownerEmail = restaurant.getOwnerEmail();
                        twoFA = restaurant.isTwoStepVerification();
                    }
                %>
                <main>
                    <h2 class="dash-title">Orders</h2>

                    <!-- Orders Section -->
                    <section id="orders-section" class="recent">
                        <div class="activity-card">
                            <h3>Order History</h3>
                            <div class="table-responsive">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                            <th>Order Date</th>
                                            <th>Payment Method</th>
                                            <th>Payment Status</th>
                                            <th>Items</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            // Create an instance of OrderDetailsDAO to call the non-static method
                                            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

                                            // Fetch order details by restaurant ID using the function
                                            List<OrderDetails> orderDetailsList = orderDetailsDAO.getOrderDetailsByRestaurantId(restaurantId); // Assuming restaurantId is available

                                            // Loop through the orders and display each order's details
                                            for (OrderDetails orderDetails : orderDetailsList) {
                                                StringBuilder itemsOrdered = new StringBuilder();

                                                // Build item string for this order
                                                for (OrderItem item : orderDetails.getItems()) {
                                                    if (itemsOrdered.length() > 0) {
                                                        itemsOrdered.append(", ");
                                                    }
                                                    itemsOrdered.append(item.getQuantity()).append("x ").append(item.getItemName());
                                                }
                                        %>
                                        <tr>
                                            <td><%= orderDetails.getOrderId()%></td>
                                            <td><%= orderDetails.getTotalAmount()%></td>
                                            <td><%= orderDetails.getOrderStatus()%></td>
                                            <td><%=orderDetails.getOrderDate()%></td>
                                            <td><%= orderDetails.getPaymentMethod()%></td>
                                            <td><%= orderDetails.getPaymentStatus()%></td>
                                            <td><%= itemsOrdered.toString()%></td> <!-- Display ordered items -->
                                            <td>
                                                <%
                                                    // Display button for "Food Ready" if the status is "Pending"
                                                    if ("Pending".equals(orderDetails.getOrderStatus())) {
                                                %>
                                                <form action="http://localhost:8080/Platera-Main/UpdateOrderStatus" method="POST">
                                                    <input type="hidden" name="order_id" value="<%= orderDetails.getOrderId()%>">
                                                    <input type="hidden" name="order_status" value="Ready">
                                                    <button type="submit" class="food-ready-btn">Food Ready</button>
                                                </form>
                                                <%
                                                    } else {
                                                        // Display current status if not "Pending"
                                                        out.print("<span>" + orderDetails.getOrderStatus() + "</span>");
                                                    }
                                                %>
                                            </td>
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

        <!-- Main JavaScript -->
        <script>
            document.querySelector("#menu").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.add("activate");
            });

            document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.remove("activate");
            });


        </script>
        <script src="../../../error.js"></script>
    </body>
</html>

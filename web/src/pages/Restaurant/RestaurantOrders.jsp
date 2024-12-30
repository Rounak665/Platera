<%@page import="java.sql.SQLException"%>
<%@page import="Utilities.Database"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Orders</title>
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
                                            // Assuming restaurantId is passed dynamically from session or request
                                            int restaurantId = 101; // For debugging

                                            Connection conn = null;
                                            PreparedStatement stmt = null;
                                            ResultSet rs = null;

                                            // SQL Query to fetch orders with additional payment information and items ordered
                                            String orderSql = "SELECT o.order_id, "
                                                    + "o.total_amount, "
                                                    + "o.order_status, "
                                                    + "o.order_date, "
                                                    + "p.payment_method, "
                                                    + "p.payment_status, "
                                                    + "mi.item_name, "
                                                    + "oi.quantity "
                                                    + "FROM orders o "
                                                    + "LEFT JOIN payments p ON o.order_id = p.order_id "
                                                    + "LEFT JOIN order_items oi ON o.order_id = oi.order_id "
                                                    + "LEFT JOIN menu_items mi ON oi.item_id = mi.item_id "
                                                    + "WHERE o.restaurant_id = ?";

                                            List<String[]> orderDetailsList = new ArrayList<String[]>();  // List to store order details
                                            int currentOrderId = -1;
                                            StringBuilder itemsOrdered = new StringBuilder();
                                            String orderStatus = "";
                                            double totalAmount = 0;
                                            java.sql.Timestamp orderDate = null;
                                            String paymentMethod = "";
                                            String paymentStatus = "";

                                            try {
                                                conn = Database.getConnection();
                                                stmt = conn.prepareStatement(orderSql);
                                                stmt.setInt(1, restaurantId); // Set the restaurantId dynamically
                                                rs = stmt.executeQuery();

                                                // Process the result set and populate orderDetailsList
                                                while (rs.next()) {
                                                    int orderId = rs.getInt("order_id");

                                                    // When a new order is encountered, save the previous order's details
                                                    if (orderId != currentOrderId && currentOrderId != -1) {
                                                        orderDetailsList.add(new String[]{
                                                            String.valueOf(currentOrderId),
                                                            String.valueOf(totalAmount),
                                                            orderStatus,
                                                            new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(orderDate),
                                                            paymentMethod,
                                                            paymentStatus,
                                                            itemsOrdered.toString()
                                                        });
                                                        itemsOrdered.setLength(0); // Clear the StringBuilder for the next order
                                                    }

                                                    // Update order-level details
                                                    currentOrderId = orderId;
                                                    totalAmount = rs.getDouble("total_amount");
                                                    orderStatus = rs.getString("order_status");
                                                    orderDate = rs.getTimestamp("order_date");
                                                    paymentMethod = rs.getString("payment_method");
                                                    paymentStatus = rs.getString("payment_status");

                                                    // Append item details for the current order
                                                    if (itemsOrdered.length() > 0) {
                                                        itemsOrdered.append(", ");
                                                    }
                                                    itemsOrdered.append(rs.getInt("quantity")).append("x ").append(rs.getString("item_name"));
                                                }

                                                // Add the last order's details to the list
                                                if (currentOrderId != -1) {
                                                    orderDetailsList.add(new String[]{
                                                        String.valueOf(currentOrderId),
                                                        String.valueOf(totalAmount),
                                                        orderStatus,
                                                        new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(orderDate),
                                                        paymentMethod,
                                                        paymentStatus,
                                                        itemsOrdered.toString()
                                                    });
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            } finally {
                                                // Close resources
                                                try {
                                                    if (rs != null) {
                                                        rs.close();
                                                    }
                                                    if (stmt != null) {
                                                        stmt.close();
                                                    }
                                                    if (conn != null) {
                                                        conn.close();
                                                    }
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        %>

                                        <%
                                            // Loop through the orders and display each order's details
                                            for (String[] orderDetails : orderDetailsList) {
                                        %>
                                        <tr>
                                            <td><%= orderDetails[0]%></td>
                                            <td><%= orderDetails[1]%></td>
                                            <td><%= orderDetails[2]%></td>
                                            <td><%= orderDetails[3]%></td>
                                            <td><%= orderDetails[4]%></td>
                                            <td><%= orderDetails[5]%></td>
                                            <td><%= orderDetails[6]%></td> <!-- Display ordered items -->
                                            <td>
                                                <%
                                                    // Display button for "Food Ready" if the status is "Pending"
                                                    if ("Pending".equals(orderDetails[2])) {
                                                %>
                                                <form action="http://localhost:8080/Platera-Main/UpdateOrderStatus" method="POST">
                                                    <input type="hidden" name="order_id" value="<%= orderDetails[0]%>">
                                                     <input type="hidden" name="order_status" value="Ready">
                                                    <button type="submit" class="food-ready-btn">Food Ready</button>
                                                </form>
                                                <%
                                                    } else {
                                                        // Display current status if not "Pending"
                                                        out.print("<span>" + orderDetails[2] + "</span>");
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

    </body>
</html>

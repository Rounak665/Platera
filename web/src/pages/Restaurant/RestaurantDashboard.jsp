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
                            <a href="">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Category.jsp">
                                <span class="icon"><ion-icon name="grid"></ion-icon></span>
                                <span>Categories</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Menu.jsp">
                                <span class="icon"><ion-icon name="book"></ion-icon></span>
                                <span>Menu</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Orders.jsp">
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
                                            // Assuming the restaurantId is 101 (this can be dynamic or fetched from session/request)
                                            
//                                            Integer restaurantId = (Integer) session.getAttribute("restaurant_id");
                                            int restaurantId = 101;  // Replace with dynamic value (from session/request)

                                            // Initialize database variables
                                            Connection conn = null;
                                            PreparedStatement stmt = null;
                                            ResultSet rs = null;
                                            String recentOrderSql = "SELECT o.order_id, "
                                                    + "u.name AS customer_name, "
                                                    + "o.order_date, "
                                                    + "mi.item_name, "
                                                    + "oi.quantity, "
                                                    + "oi.price, "
                                                    + "o.total_amount, "
                                                    + "o.order_status "
                                                    + "FROM orders o "
                                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                                    + "JOIN menu_items mi ON oi.item_id = mi.item_id "
                                                    + "JOIN customers c ON o.customer_id = c.customer_id "
                                                    + "JOIN users u ON c.user_id = u.user_id "
                                                    + "WHERE mi.restaurant_id = ?";

                                            List<String[]> recentOrderDetailsList = new ArrayList<String[]>(); // List to store order details
                                            int currentOrderId = -1;
                                            StringBuilder itemsOrdered = new StringBuilder();
                                            String customerName = "";
                                            double totalAmount = 0;
                                            String orderStatus = "";
                                            java.sql.Timestamp orderDate = null;

                                            try {
                                                conn = Database.getConnection();
                                                stmt = conn.prepareStatement(recentOrderSql);
                                                stmt.setInt(1, restaurantId); // Set the restaurantId dynamically
                                                rs = stmt.executeQuery();

                                                // Process the result set
                                                while (rs.next()) {
                                                    int orderId = rs.getInt("order_id");

                                                    // When a new order is encountered, save the previous order's details
                                                    if (orderId != currentOrderId && currentOrderId != -1) {
                                                        recentOrderDetailsList.add(new String[]{
                                                            String.valueOf(currentOrderId),
                                                            customerName,
                                                            new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(orderDate),
                                                            itemsOrdered.toString(),
                                                            String.valueOf(totalAmount),
                                                            orderStatus
                                                        });
                                                        itemsOrdered.setLength(0); // Clear the StringBuilder for the next order
                                                    }

                                                    // Update order-level details
                                                    currentOrderId = orderId;
                                                    customerName = rs.getString("customer_name");
                                                    orderDate = rs.getTimestamp("order_date");
                                                    totalAmount = rs.getDouble("total_amount");
                                                    orderStatus = rs.getString("order_status");

                                                    // Append item details for the current order
                                                    if (itemsOrdered.length() > 0) {
                                                        itemsOrdered.append(", ");
                                                    }
                                                    itemsOrdered.append(rs.getInt("quantity")).append("x ").append(rs.getString("item_name"));
                                                }

                                                // Add the last order's details to the list
                                                if (currentOrderId != -1) {
                                                    recentOrderDetailsList.add(new String[]{
                                                        String.valueOf(currentOrderId),
                                                        customerName,
                                                        new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(orderDate),
                                                        itemsOrdered.toString(),
                                                        String.valueOf(totalAmount),
                                                        orderStatus
                                                    });
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            } finally {
                                                // Close database resources
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
                                            // Loop through recent orders and display them in the table
                                            for (String[] orderDetails : recentOrderDetailsList) {
                                        %>
                                        <tr>
                                            <td><%= orderDetails[0]%></td>
                                            <td><%= orderDetails[1]%></td>
                                            <td><%= orderDetails[2]%></td>
                                            <td><%= orderDetails[3]%></td>
                                            <td><%= orderDetails[4]%></td>
                                            <td><%= orderDetails[5]%></td>
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

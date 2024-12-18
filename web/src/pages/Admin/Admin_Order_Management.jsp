<%@page import="Utilities.Database"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="Admin.css">
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
                                <span class="icon"><ion-icon name="bar-chart"></ion-icon></span>
                                <span>Dashboard Overview</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="wine"></ion-icon></span>
                                <span>Order Management</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Restaurant_Approval.jsp">
                                <span class="icon"><ion-icon name="restaurant"></ion-icon></span>
                                <span>Restaurant Approval</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Delivery_Executive_Approval.jsp">
                                <span class="icon"><ion-icon name="bicycle"></ion-icon></span>
                                <span>Delivery Executive Management</span>
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
                            <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center">
                                <button type="submit" class="btn d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                                    <path d="M7.5 1v7h1V1z"></path>
                                    <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                                    </svg>
                                    <span class="ml-2">Logout</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </header>

                <main>
                    <h2 class="dash-title">Order Management</h2>

                    <!-- Pending Orders Section -->


                    <section id="pending-orders">
                        <h2>Pending Orders</h2>

                        <%
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;
                            String orderSql = "SELECT o.order_id, "
                                    + "r.restaurant_name AS restaurant_name, "
                                    + "u.name AS customer_name, "
                                    + "mi.item_name, "
                                    + "oi.quantity, "
                                    + "oi.price, "
                                    + "o.total_amount, "
                                    + "o.order_status "
                                    + "FROM orders o "
                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                    + "JOIN menu_items mi ON oi.item_id = mi.item_id "
                                    + "JOIN restaurants r ON mi.restaurant_id = r.restaurant_id "
                                    + "JOIN customers c ON o.customer_id = c.customer_id "
                                    + "JOIN users u ON c.user_id = u.user_id "
                                    + "WHERE o.order_status = 'Pending' "
                                    + "ORDER BY o.order_id";

                            List<String[]> orderDetailsList = new ArrayList<String[]>();  // List to store order details for each order
                            int currentOrderId = -1;
                            StringBuilder itemsOrdered = new StringBuilder();
                            String restaurantName = "";
                            String customerName = "";
                            double totalAmount = 0;
                            String orderStatus = "";

                            try {
                                conn = Database.getConnection();
                                stmt = conn.prepareStatement(orderSql);
                                rs = stmt.executeQuery();

                                // Process the result set
                                while (rs.next()) {
                                    int orderId = rs.getInt("order_id");

                                    // When a new order is encountered, save the previous order's details
                                    if (orderId != currentOrderId && currentOrderId != -1) {
                                        orderDetailsList.add(new String[]{
                                            String.valueOf(currentOrderId),
                                            restaurantName,
                                            customerName,
                                            itemsOrdered.toString(),
                                            String.valueOf(totalAmount),
                                            orderStatus
                                        });
                                        itemsOrdered.setLength(0); // Clear the StringBuilder for the next order
                                    }

                                    // Update order-level details
                                    currentOrderId = orderId;
                                    restaurantName = rs.getString("restaurant_name");
                                    customerName = rs.getString("customer_name");
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
                                    orderDetailsList.add(new String[]{
                                        String.valueOf(currentOrderId),
                                        restaurantName,
                                        customerName,
                                        itemsOrdered.toString(),
                                        String.valueOf(totalAmount),
                                        orderStatus
                                    });
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (rs != null) {
                                    try {
                                        rs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (stmt != null) {
                                    try {
                                        stmt.close();
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

                        <!-- HTML table to display the order details -->
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Restaurant Name</th>
                                    <th>Customer Name</th>
                                    <th>Items Ordered</th>
                                    <th>Total Amount</th>
                                    <th>Order Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < orderDetailsList.size(); i++) {
                                        String[] orderDetails = (String[]) orderDetailsList.get(i);
                                %>
                                <tr>
                                    <td><%= orderDetails[0]%></td>
                                    <td><%= orderDetails[1]%></td>
                                    <td><%= orderDetails[2]%></td>
                                    <td><%= orderDetails[3]%></td>
                                    <td><%= orderDetails[4]%></td>
                                    <td><%= orderDetails[5]%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>

                    </section>




                    <!-- Pending Delivery Section -->
                    <section id="pending-delivery">
                        <h2>Pending Delivery Orders</h2>

                        <%
                            Connection deliveryConn = null;
                            PreparedStatement deliveryStmt = null;
                            ResultSet deliveryRs = null;
                            String deliveryOrderSql = "SELECT o.order_id, "
                                    + "r.restaurant_name AS restaurant_name, "
                                    + "u.name AS customer_name, "
                                    + "mi.item_name, "
                                    + "oi.quantity, "
                                    + "oi.price, "
                                    + "o.total_amount, "
                                    + "o.order_status "
                                    + "FROM orders o "
                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                    + "JOIN menu_items mi ON oi.item_id = mi.item_id "
                                    + "JOIN restaurants r ON mi.restaurant_id = r.restaurant_id "
                                    + "JOIN customers c ON o.customer_id = c.customer_id "
                                    + "JOIN users u ON c.user_id = u.user_id "
                                    + "WHERE o.order_status = 'Picked Up' "
                                    + "ORDER BY o.order_id";

                            List<String[]> deliveryOrderList = new ArrayList<String[]>();  // List to store delivery order details
                            int currentDeliveryOrderId = -1;
                            StringBuilder deliveryItemsOrdered = new StringBuilder();
                            String deliveryRestaurantName = "";
                            String deliveryCustomerName = "";
                            double deliveryTotalAmount = 0;
                            String deliveryOrderStatus = "";

                            try {
                                deliveryConn = Database.getConnection();
                                deliveryStmt = deliveryConn.prepareStatement(deliveryOrderSql);
                                deliveryRs = deliveryStmt.executeQuery();

                                // Process the result set
                                while (deliveryRs.next()) {
                                    int deliveryOrderId = deliveryRs.getInt("order_id");

                                    // When a new order is encountered, save the previous order's details
                                    if (deliveryOrderId != currentDeliveryOrderId && currentDeliveryOrderId != -1) {
                                        deliveryOrderList.add(new String[]{
                                            String.valueOf(currentDeliveryOrderId),
                                            deliveryRestaurantName,
                                            deliveryCustomerName,
                                            deliveryItemsOrdered.toString(),
                                            String.valueOf(deliveryTotalAmount),
                                            deliveryOrderStatus
                                        });
                                        deliveryItemsOrdered.setLength(0); // Clear the StringBuilder for the next order
                                    }

                                    // Update order-level details
                                    currentDeliveryOrderId = deliveryOrderId;
                                    deliveryRestaurantName = deliveryRs.getString("restaurant_name");
                                    deliveryCustomerName = deliveryRs.getString("customer_name");
                                    deliveryTotalAmount = deliveryRs.getDouble("total_amount");
                                    deliveryOrderStatus = deliveryRs.getString("order_status");

                                    // Append item details for the current order
                                    if (deliveryItemsOrdered.length() > 0) {
                                        deliveryItemsOrdered.append(", ");
                                    }
                                    deliveryItemsOrdered.append(deliveryRs.getInt("quantity")).append("x ").append(deliveryRs.getString("item_name"));
                                }

                                // Add the last order's details to the list
                                if (currentDeliveryOrderId != -1) {
                                    deliveryOrderList.add(new String[]{
                                        String.valueOf(currentDeliveryOrderId),
                                        deliveryRestaurantName,
                                        deliveryCustomerName,
                                        deliveryItemsOrdered.toString(),
                                        String.valueOf(deliveryTotalAmount),
                                        deliveryOrderStatus
                                    });
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (deliveryRs != null) {
                                    try {
                                        deliveryRs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveryStmt != null) {
                                    try {
                                        deliveryStmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveryConn != null) {
                                    try {
                                        deliveryConn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        %>

                        <!-- HTML table to display the delivery order details -->
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Restaurant Name</th>
                                    <th>Customer Name</th>
                                    <th>Items Ordered</th>
                                    <th>Total Amount</th>
                                    <th>Order Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < deliveryOrderList.size(); i++) {
                                        String[] deliveryOrderDetails = deliveryOrderList.get(i);
                                %>
                                <tr>
                                    <td><%= deliveryOrderDetails[0]%></td>
                                    <td><%= deliveryOrderDetails[1]%></td>
                                    <td><%= deliveryOrderDetails[2]%></td>
                                    <td><%= deliveryOrderDetails[3]%></td>
                                    <td><%= deliveryOrderDetails[4]%></td>
                                    <td><%= deliveryOrderDetails[5]%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>

                    </section>






                    <!-- Order History Section -->
                    <section id="order-history">
                        <h2>Delivered Orders</h2>

                        <%
                            Connection deliveredConn = null;
                            PreparedStatement deliveredStmt = null;
                            ResultSet deliveredRs = null;
                            String deliveredOrderSql = "SELECT o.order_id, r.restaurant_name AS restaurant_name, u.name AS customer_name, mi.item_name, oi.quantity, oi.price, o.total_amount, o.order_status "
                                    + "FROM orders o "
                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                    + "JOIN menu_items mi ON oi.item_id = mi.item_id "
                                    + "JOIN restaurants r ON mi.restaurant_id = r.restaurant_id "
                                    + "JOIN customers c ON o.customer_id = c.customer_id "
                                    + "JOIN users u ON c.user_id = u.user_id "
                                    + "WHERE o.order_status = 'Delivered' "
                                    + "ORDER BY o.order_id";

                            List<String[]> deliveredOrderList = new ArrayList<String[]>();
                            int currentDeliveredOrderId = -1;
                            StringBuilder deliveredItemsOrdered = new StringBuilder();
                            String deliveredRestaurantName = "";
                            String deliveredCustomerName = "";
                            double deliveredTotalAmount = 0;
                            String deliveredOrderStatus = "";

                            try {
                                deliveredConn = Database.getConnection();
                                deliveredStmt = deliveredConn.prepareStatement(deliveredOrderSql);
                                deliveredRs = deliveredStmt.executeQuery();

                                // Process the result set
                                while (deliveredRs.next()) {
                                    int deliveredOrderId = deliveredRs.getInt("order_id");

                                    // When a new order is encountered, save the previous order's details
                                    if (deliveredOrderId != currentDeliveredOrderId && currentDeliveredOrderId != -1) {
                                        deliveredOrderList.add(new String[]{
                                            String.valueOf(currentDeliveredOrderId),
                                            deliveredRestaurantName,
                                            deliveredCustomerName,
                                            deliveredItemsOrdered.toString(),
                                            String.valueOf(deliveredTotalAmount),
                                            deliveredOrderStatus
                                        });
                                        deliveredItemsOrdered.setLength(0);
                                    }

                                    // Update order-level details
                                    currentDeliveredOrderId = deliveredOrderId;
                                    deliveredRestaurantName = deliveredRs.getString("restaurant_name");
                                    deliveredCustomerName = deliveredRs.getString("customer_name");
                                    deliveredTotalAmount = deliveredRs.getDouble("total_amount");
                                    deliveredOrderStatus = deliveredRs.getString("order_status");

                                    // Append item details for the current order
                                    if (deliveredItemsOrdered.length() > 0) {
                                        deliveredItemsOrdered.append(", ");
                                    }
                                    deliveredItemsOrdered.append(deliveredRs.getInt("quantity")).append("x ").append(deliveredRs.getString("item_name"));
                                }

                                // Add the last order's details to the list
                                if (currentDeliveredOrderId != -1) {
                                    deliveredOrderList.add(new String[]{
                                        String.valueOf(currentDeliveredOrderId),
                                        deliveredRestaurantName,
                                        deliveredCustomerName,
                                        deliveredItemsOrdered.toString(),
                                        String.valueOf(deliveredTotalAmount),
                                        deliveredOrderStatus
                                    });
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (deliveredRs != null) {
                                    try {
                                        deliveredRs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveredStmt != null) {
                                    try {
                                        deliveredStmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveredConn != null) {
                                    try {
                                        deliveredConn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        %>

                        <!-- HTML table to display the delivered order details -->
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Restaurant Name</th>
                                    <th>Customer Name</th>
                                    <th>Items Ordered</th>
                                    <th>Total Amount</th>
                                    <th>Order Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < deliveredOrderList.size(); i++) {
                                        String[] deliveredOrderDetails = deliveredOrderList.get(i);
                                %>
                                <tr>
                                    <td><%= deliveredOrderDetails[0]%></td>
                                    <td><%= deliveredOrderDetails[1]%></td>
                                    <td><%= deliveredOrderDetails[2]%></td>
                                    <td><%= deliveredOrderDetails[3]%></td>
                                    <td><%= deliveredOrderDetails[4]%></td>
                                    <td><%= deliveredOrderDetails[5]%></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </section>



                </main>
            </div>
        </div>

        <!-- Scripts -->

        <!-- Icon Scripts -->
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <!--Bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

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

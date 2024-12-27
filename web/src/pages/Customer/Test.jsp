<%@page import="Utilities.Database"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.Connection, java.util.List" %>
<%@ page import="Utilities.OrdersDAO, Utilities.Orders, Utilities.OrderItem" %>

<html>
<head>
    <title>Accepted Orders for Delivery Executive</title>
    <style>
        /* Simple styling */
        .order-item {
            padding: 10px;
            border: 1px solid #ddd;
            margin: 10px;
        }

        .order-details {
            margin-top: 20px;
        }

        .order-items {
            margin-left: 20px;
        }
    </style>
</head>
<body>

    <h1>Accepted Orders for Delivery Executive</h1>

    <% 
        // Assume deliveryExecutiveId is already provided (either from session or request)
        int deliveryExecutiveId = 35;  // Example delivery executive ID
        Connection conn = Database.getConnection();
        OrdersDAO ordersDAO = new OrdersDAO();
        
        List<Orders> ordersList = null;
        try {
            ordersList = ordersDAO.getAcceptedOrdersByDeliveryExecutiveId(deliveryExecutiveId, conn);
        } catch (Exception e) {
            out.println("Error fetching orders: " + e.getMessage());
        } finally {
            // Close resources if necessary (you can use a try-with-resources block)
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        if (ordersList != null && !ordersList.isEmpty()) {
            for (Orders order : ordersList) {
    %>

    <div class="order-item">
        <h3>Order ID: <%= order.getOrderId() %></h3>
        <p>Restaurant: <%= order.getRestaurantName() %></p>
        <p>Address: <%= order.getAddress() %></p>
        <p>Total Amount: ₹<%= order.getTotalAmount() %></p>
        <p>Payment Method: <%= order.getPaymentMethod() %></p>
        <p>Payment Status: <%= order.getPaymentStatus() %></p>
        
        <div class="order-details">
            <h4>Order Items:</h4>
            <div class="order-items">
                <% 
                    // Displaying the items for the current order
                    List<OrderItem> items = order.getOrderItems();
                    for (OrderItem item : items) {
                %>
                    <p><%= item.getItemName() %> (x<%= item.getQuantity() %>)</p>
                <% 
                    }
                %>
            </div>
        </div>
    </div>

    <% 
            }
        } else {
    %>
        <p>No accepted orders found for this delivery executive.</p>
    <% 
        }
    %>

</body>
</html>

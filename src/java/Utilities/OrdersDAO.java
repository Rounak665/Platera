package Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO {

    public List<Orders> getAcceptedOrdersByDeliveryExecutiveId(int deliveryExecutiveId) throws SQLException {

        List<Orders> ordersList = new ArrayList<>();
        String query = "SELECT o.order_id, o.total_amount AS total_amount, o.address AS customer_address, o.order_status, o.order_date, "
                + "r.restaurant_id,r.restaurant_name AS restaurant_name, r.address AS restaurant_address,r.phone as restaurant_phone, "
                + "p.payment_method, p.payment_status, p.payment_date, p.amount, "
                + "oi.item_id, m.item_name, oi.quantity, m.image,o.phone as customer_phone "
                + "FROM orders o "
                + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                + "LEFT JOIN payments p ON o.order_id = p.order_id "
                + "LEFT JOIN deliveries d ON o.order_id = d.order_id "
                + "JOIN order_items oi ON o.order_id = oi.order_id "
                + "JOIN menu_items m ON oi.item_id = m.item_id "
                + "WHERE d.delivery_executive_id = ? AND o.order_status = 'Accepted' "
                + "ORDER BY o.order_id";

        try (Connection conn = Database.getConnection(); // Initialize connection locally
                PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, deliveryExecutiveId);
            ResultSet rs = pstmt.executeQuery();

            int currentOrderId = -1;
            Orders currentOrder = null;

            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                // Check if we have a new order
                if (orderId != currentOrderId) {
                    if (currentOrder != null) {
                        ordersList.add(currentOrder); // Add the previous order to the list
                    }

                    // Create a new Orders object for the new order
                    currentOrder = new Orders();
                    currentOrder.setOrderId(orderId);
                    currentOrder.setOrderStatus(rs.getString("order_status"));
                    currentOrder.setOrderDate(rs.getString("order_date"));
                    currentOrder.setTotalAmount(rs.getDouble("total_amount"));
                    currentOrder.setCustomerAddress(rs.getString("customer_address"));
                    currentOrder.setCustomerPhone(rs.getString("customer_phone"));
                    currentOrder.setRestaurantId(rs.getInt("restaurant_id"));
                    currentOrder.setRestaurantName(rs.getString("restaurant_name"));
                    currentOrder.setRestaurantAddress(rs.getString("restaurant_address"));
                    currentOrder.setRestaurantPhone(rs.getString("restaurant_phone"));
                    currentOrder.setPaymentMethod(rs.getString("payment_method"));
                    currentOrder.setPaymentStatus(rs.getString("payment_status"));
                    currentOrder.setPaymentDate(rs.getString("payment_date"));
                    currentOrder.setAmountPayable(rs.getDouble("amount"));

                    currentOrderId = orderId;  // Update current order id
                }

                // Add item details to the current order
                int itemId = rs.getInt("item_id");
                String itemName = rs.getString("item_name");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image"); // Get the image URL

                OrderItem orderItem = new OrderItem();
                orderItem.setItemId(itemId);
                orderItem.setItemName(itemName);
                orderItem.setQuantity(quantity);
                orderItem.setImage(image); // Set the image URL

                currentOrder.addOrderItem(orderItem);  // Add item to the order
            }

            // Add the last order to the list
            if (currentOrder != null) {
                ordersList.add(currentOrder);
            }
        }

        return ordersList;  // Return the list of orders with their items
    }

    public List<Orders> getOrdersByCustomerId(int customerId) throws SQLException {

        List<Orders> ordersList = new ArrayList<>();
        String query = "SELECT o.order_id, o.total_amount AS total_amount, o.address AS customer_address, o.order_status, o.order_date, "
                + "r.restaurant_id,r.restaurant_name AS restaurant_name, r.address AS restaurant_address,r.phone as restaurant_phone, "
                + "p.payment_method, p.payment_status, p.payment_date, p.amount, "
                + "oi.item_id, m.item_name, oi.quantity, m.image,o.phone as customer_phone "
                + "FROM orders o "
                + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                + "LEFT JOIN payments p ON o.order_id = p.order_id "
                + "JOIN order_items oi ON o.order_id = oi.order_id "
                + "JOIN menu_items m ON oi.item_id = m.item_id "
                + "WHERE o.customer_id = ? AND o.order_status = 'Accepted' "
                + "ORDER BY o.order_id";

        try (Connection conn = Database.getConnection(); // Initialize connection locally
                PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();

            int currentOrderId = -1;
            Orders currentOrder = null;

            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                // Check if we have a new order
                if (orderId != currentOrderId) {
                    if (currentOrder != null) {
                        ordersList.add(currentOrder); // Add the previous order to the list
                    }

                    // Create a new Orders object for the new order
                    currentOrder = new Orders();
                    currentOrder.setOrderId(orderId);
                    currentOrder.setOrderStatus(rs.getString("order_status"));
                    currentOrder.setOrderDate(rs.getString("order_date"));
                    currentOrder.setTotalAmount(rs.getDouble("total_amount"));
                    currentOrder.setCustomerAddress(rs.getString("customer_address"));
                    currentOrder.setCustomerPhone(rs.getString("customer_phone"));
                    currentOrder.setRestaurantId(rs.getInt("restaurant_id"));
                    currentOrder.setRestaurantName(rs.getString("restaurant_name"));
                    currentOrder.setRestaurantAddress(rs.getString("restaurant_address"));
                    currentOrder.setRestaurantPhone(rs.getString("restaurant_phone"));
                    currentOrder.setPaymentMethod(rs.getString("payment_method"));
                    currentOrder.setPaymentStatus(rs.getString("payment_status"));
                    currentOrder.setPaymentDate(rs.getString("payment_date"));
                    currentOrder.setAmountPayable(rs.getDouble("amount"));

                    currentOrderId = orderId;  // Update current order id
                }

                // Add item details to the current order
                int itemId = rs.getInt("item_id");
                String itemName = rs.getString("item_name");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image"); // Get the image URL

                OrderItem orderItem = new OrderItem();
                orderItem.setItemId(itemId);
                orderItem.setItemName(itemName);
                orderItem.setQuantity(quantity);
                orderItem.setImage(image); // Set the image URL

                currentOrder.addOrderItem(orderItem);  // Add item to the order
            }

            // Add the last order to the list
            if (currentOrder != null) {
                ordersList.add(currentOrder);
            }
        }

        return ordersList;  // Return the list of orders with their items
    }

    public List<Orders> getCompletedOrdersByDeliveryExecutiveId(int deliveryExecutiveId) throws SQLException {

        List<Orders> ordersList = new ArrayList<>();
        String query = "SELECT o.order_id, o.total_amount AS total_amount, o.address AS customer_address, o.order_status, o.order_date, "
                + "r.restaurant_id,r.restaurant_name AS restaurant_name, r.address AS restaurant_address,r.phone as restaurant_phone, "
                + "p.payment_method, p.payment_status, p.payment_date, p.amount, "
                + "oi.item_id, m.item_name, oi.quantity, m.image,o.phone as customer_phone "
                + "FROM orders o "
                + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                + "LEFT JOIN payments p ON o.order_id = p.order_id "
                + "LEFT JOIN deliveries d ON o.order_id = d.order_id "
                + "JOIN order_items oi ON o.order_id = oi.order_id "
                + "JOIN menu_items m ON oi.item_id = m.item_id "
                + "WHERE d.delivery_executive_id = ? AND o.order_status = 'Delivered' "
                + "ORDER BY o.order_id";

        try (Connection conn = Database.getConnection(); // Initialize connection locally
                PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, deliveryExecutiveId);
            ResultSet rs = pstmt.executeQuery();

            int currentOrderId = -1;
            Orders currentOrder = null;

            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                // Check if we have a new order
                if (orderId != currentOrderId) {
                    if (currentOrder != null) {
                        ordersList.add(currentOrder); // Add the previous order to the list
                    }

                    // Create a new Orders object for the new order
                    currentOrder = new Orders();
                    currentOrder.setOrderId(orderId);
                    currentOrder.setOrderStatus(rs.getString("order_status"));
                    currentOrder.setOrderDate(rs.getString("order_date"));
                    currentOrder.setTotalAmount(rs.getDouble("total_amount"));
                    currentOrder.setCustomerAddress(rs.getString("customer_address"));
                    currentOrder.setCustomerPhone(rs.getString("customer_phone"));
                    currentOrder.setRestaurantId(rs.getInt("restaurant_id"));
                    currentOrder.setRestaurantName(rs.getString("restaurant_name"));
                    currentOrder.setRestaurantAddress(rs.getString("restaurant_address"));
                    currentOrder.setRestaurantPhone(rs.getString("restaurant_phone"));
                    currentOrder.setPaymentMethod(rs.getString("payment_method"));
                    currentOrder.setPaymentStatus(rs.getString("payment_status"));
                    currentOrder.setPaymentDate(rs.getString("payment_date"));
                    currentOrder.setAmountPayable(rs.getDouble("amount"));

                    currentOrderId = orderId;  // Update current order id
                }

                // Add item details to the current order
                int itemId = rs.getInt("item_id");
                String itemName = rs.getString("item_name");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image"); // Get the image URL

                OrderItem orderItem = new OrderItem();
                orderItem.setItemId(itemId);
                orderItem.setItemName(itemName);
                orderItem.setQuantity(quantity);
                orderItem.setImage(image); // Set the image URL

                currentOrder.addOrderItem(orderItem);  // Add item to the order
            }

            // Add the last order to the list
            if (currentOrder != null) {
                ordersList.add(currentOrder);
            }
        }

        return ordersList;  // Return the list of orders with their items
    }
}

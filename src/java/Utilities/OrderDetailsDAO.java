package Utilities;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailsDAO {
    public List<OrderDetails> getOrdersByLocation(int location_id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        OrderDetails currentOrder = null;
        
        try {
            conn = Database.getConnection();
            String sql = "SELECT o.order_id, o.customer_id, u.name AS customer_name, "
                    + "c.image AS customer_image, o.order_date, o.total_amount, "
                    + "o.address AS customer_address, oi.item_id, m.item_name, oi.quantity, "
                    + "o.restaurant_id, r.restaurant_name, r.address AS restaurant_address, r.image as restaurant_image, "
                    + "p.payment_method, p.payment_status, m.image as item_image "
                    + "FROM orders o "
                    + "LEFT JOIN payments p ON o.order_id = p.order_id "
                    + "JOIN customers c ON o.customer_id = c.customer_id "
                    + "JOIN users u ON c.user_id = u.user_id "
                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                    + "JOIN menu_items m ON oi.item_id = m.item_id "
                    + "JOIN restaurants r ON r.restaurant_id = o.restaurant_id "
                    + "WHERE o.location = ? AND o.order_status IN ('Pending', 'Ready')";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, location_id);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                // If the currentOrder is null or the orderId is different, we create a new order
                if (currentOrder == null || currentOrder.getOrderId() != orderId) {
                    // If we already have an existing order, add it to the list
                    if (currentOrder != null) {
                        orderDetailsList.add(currentOrder);
                    }

                    // Create a new OrderDetails object for the new order
                    currentOrder = new OrderDetails();
                    currentOrder.setOrderId(orderId);
                    currentOrder.setRestaurantId(rs.getInt("restaurant_id"));
                    currentOrder.setRestaurantName(rs.getString("restaurant_name"));
                    currentOrder.setRestaurantImage(rs.getString("restaurant_image"));
                    currentOrder.setRestaurantAddress(rs.getString("restaurant_address"));
                    currentOrder.setCustomerId(rs.getInt("customer_id"));
                    currentOrder.setCustomerName(rs.getString("customer_name"));
                    currentOrder.setCustomerImage(rs.getString("customer_image"));
                    currentOrder.setCustomerAddress(rs.getString("customer_address"));
                    currentOrder.setOrderDate(rs.getString("order_date"));
                    currentOrder.setTotalAmount(rs.getDouble("total_amount"));
                    currentOrder.setPaymentMethod(rs.getString("payment_method"));
                    currentOrder.setPaymentStatus(rs.getString("payment_status"));
                }

                // Add the item to the current order
                int itemId = rs.getInt("item_id");
                String itemName = rs.getString("item_name");
                int quantity = rs.getInt("quantity");
                String itemImage = rs.getString("item_image");  // Get item image

                currentOrder.addItem(itemId, itemName, quantity, itemImage); 
            }

            // Add the last order to the list
            if (currentOrder != null) {
                orderDetailsList.add(currentOrder);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderDetailsList;
    }
}

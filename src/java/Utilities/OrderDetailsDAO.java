//package Utilities;
//
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class OrderDetailsDAO {
//
//    // Method to fetch orders based on location and order status
//    public List<OrderDetails> getOrdersByLocation(int location) {
//        List<OrderDetails> orderDetailsList = new ArrayList<>();
//        String query = "SELECT o.order_id, o.customer_id, u.name AS customer_name, "
//                     + "c.image AS customer_image, o.order_date, o.total_amount, "
//                     + "o.address AS customer_address, oi.item_id, m.item_name, oi.quantity, "
//                     + "o.restaurant_id, r.restaurant_name, r.address AS restaurant_address, r.image as restaurant_image, "
//                     + "p.payment_method, p.payment_status "
//                     + "FROM orders o "
//                     + "LEFT JOIN payments p ON o.order_id = p.order_id "
//                     + "JOIN customers c ON o.customer_id = c.customer_id "
//                     + "JOIN users u ON c.user_id = u.user_id "
//                     + "JOIN order_items oi ON o.order_id = oi.order_id "
//                     + "JOIN menu_items m ON oi.item_id = m.item_id "
//                     + "JOIN restaurants r ON r.restaurant_id = o.restaurant_id "
//                     + "WHERE o.location = ? AND o.order_status = 'Pending'";
//
//        try (Connection conn = Database.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//
//            ps.setInt(1, location);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                int orderId = rs.getInt("order_id");
//                int customerId = rs.getInt("customer_id");
//                String customerName = rs.getString("customer_name");
//                String customerImage = rs.getString("customer_image");
//                String orderDate = rs.getString("order_date");
//                double totalAmount = rs.getDouble("total_amount");
//                String customerAddress = rs.getString("customer_address");
//                int itemId = rs.getInt("item_id");
//                String itemName = rs.getString("item_name");
//                int quantity = rs.getInt("quantity");
//                int restaurantId = rs.getInt("restaurant_id");
//                String restaurantName = rs.getString("restaurant_name");
//                String restaurantAddress = rs.getString("restaurant_address");
//                String restaurantImage = rs.getString("restaurant_image");
//                String paymentMethod = rs.getString("payment_method");
//                String paymentStatus = rs.getString("payment_status");
//
//                // Creating OrderDetails object
//                OrderDetails order = new OrderDetails();
//                order.setOrderId(orderId);
//                order.setCustomerId(customerId);
//                order.setCustomerName(customerName);
//                order.setCustomerImage(customerImage);
//                order.setOrderDate(orderDate);
//                order.setTotalAmount(totalAmount);
//                order.setCustomerAddress(customerAddress);
//                order.setRestaurantId(restaurantId);
//                order.setRestaurantName(restaurantName);
//                order.setRestaurantAddress(restaurantAddress);
//                order.setRestaurantImage(restaurantImage);
//                order.setPaymentMethod(paymentMethod);
//                order.setPaymentStatus(paymentStatus);
//
//                // Adding order item (OrderItem object)
//                order.addItem(itemId, itemName, quantity);
//
//                // Adding order details to the list
//                orderDetailsList.add(order);
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return orderDetailsList;
//    }
//
//    // Method to fetch orders based on restaurant_id and order status
//    public List<OrderDetails> getOrdersByRestaurantId(int restaurantId) {
//        List<OrderDetails> orderDetailsList = new ArrayList<>();
//        String query = "SELECT o.order_id, o.customer_id, u.name AS customer_name, "
//                     + "c.image AS customer_image, o.order_date, o.total_amount, "
//                     + "o.address AS customer_address, oi.item_id, m.item_name, oi.quantity, "
//                     + "o.restaurant_id, r.restaurant_name, r.address AS restaurant_address, r.image as restaurant_image, "
//                     + "p.payment_method, p.payment_status "
//                     + "FROM orders o "
//                     + "LEFT JOIN payments p ON o.order_id = p.order_id "
//                     + "JOIN customers c ON o.customer_id = c.customer_id "
//                     + "JOIN users u ON c.user_id = u.user_id "
//                     + "JOIN order_items oi ON o.order_id = oi.order_id "
//                     + "JOIN menu_items m ON oi.item_id = m.item_id "
//                     + "JOIN restaurants r ON r.restaurant_id = o.restaurant_id "
//                     + "WHERE o.restaurant_id = ? AND o.order_status = 'Pending'";
//
//        try (Connection conn = Database.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//
//            ps.setInt(1, restaurantId);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                int orderId = rs.getInt("order_id");
//                int customerId = rs.getInt("customer_id");
//                String customerName = rs.getString("customer_name");
//                String customerImage = rs.getString("customer_image");
//                String orderDate = rs.getString("order_date");
//                double totalAmount = rs.getDouble("total_amount");
//                String customerAddress = rs.getString("customer_address");
//                int itemId = rs.getInt("item_id");
//                String itemName = rs.getString("item_name");
//                int quantity = rs.getInt("quantity");
//                String restaurantName = rs.getString("restaurant_name");
//                String restaurantAddress = rs.getString("restaurant_address");
//                String restaurantImage = rs.getString("restaurant_image");
//                String paymentMethod = rs.getString("payment_method");
//                String paymentStatus = rs.getString("payment_status");
//
//                // Creating OrderDetails object
//                OrderDetails order = new OrderDetails();
//                order.setOrderId(orderId);
//                order.setCustomerId(customerId);
//                order.setCustomerName(customerName);
//                order.setCustomerImage(customerImage);
//                order.setOrderDate(orderDate);
//                order.setTotalAmount(totalAmount);
//                order.setCustomerAddress(customerAddress);
//                order.setRestaurantName(restaurantName);
//                order.setRestaurantAddress(restaurantAddress);
//                order.setRestaurantImage(restaurantImage);
//                order.setPaymentMethod(paymentMethod);
//                order.setPaymentStatus(paymentStatus);
//
//                // Adding order item (OrderItem object)
//                order.addItem(itemId, itemName, quantity);
//
//                // Adding order details to the list
//                orderDetailsList.add(order);
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return orderDetailsList;
//    }
//}

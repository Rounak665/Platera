package Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PlaceOrder {

    private int customerId;
    private int locationId;
    private String paymentMethod;
    private String address;
    private String phone;
    private String receiverName;
    private String email;  // Added email
    private boolean emailConfirmation;  // Added email confirmation flag

    // Constructor with added email and emailConfirmation parameters
    public PlaceOrder(int customerId, int locationId, String paymentMethod, String address, String phone, String receiverName, String email, boolean emailConfirmation) {
        this.customerId = customerId;
        this.locationId = locationId;
        this.paymentMethod = paymentMethod;
        this.address = address;
        this.phone = phone;
        this.receiverName = receiverName;
        this.email = email;
        this.emailConfirmation = emailConfirmation;
    }

    public String placeOrder() {
        CartDAO cartDAO = new CartDAO();
        try {
            // Retrieve cart items
            List<Cart> cartItems = cartDAO.getCartItems(customerId);

            if (cartItems == null || cartItems.isEmpty()) {
                return "Cart is empty. Cannot place order.";
            }

            double subtotal = 0;
            int couponId = 0;
            double couponDiscount = 0;
            int restaurantId = 0;

            for (Cart cart : cartItems) {
                subtotal += cart.getItemPrice() * cart.getQuantity();
                couponId = cart.getCouponId(); // Assuming all items in the cart have the same coupon ID
                restaurantId = cart.getRestaurantId();
            }

            // Retrieve coupon discount (if applicable)
            if (couponId != 0) {
                try (Connection conn = Database.getConnection()) {
                    String couponQuery = "SELECT coupon_discount FROM coupons WHERE coupon_id = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(couponQuery)) {
                        stmt.setInt(1, couponId);
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                couponDiscount = rs.getDouble("coupon_discount");
                            }
                        }
                    }
                }
            }

            double total = subtotal - couponDiscount;
            double deliveryCharges = (total < 199) ? 30 : 0;
            total += deliveryCharges;

            int orderId = 0;
            String paymentStatus = "Pending"; // Default payment status for COD

            if (!"Cash On Delivery".equalsIgnoreCase(paymentMethod)) {
                paymentStatus = "Paid"; // Mark as Paid for card or net banking
            }

            try (Connection conn = Database.getConnection()) {
                // No need to disable autocommit, as it's true by default.

                // Insert order into the orders table, including receiver_name and phone
                String insertOrderQuery = "INSERT INTO orders (customer_id, subtotal, total_amount, order_status, coupon_id, order_date, location, restaurant_id, address, receiver_name, phone) "
                        + "VALUES (?, ?, ?, 'Pending', ?, SYSDATE, ?, ?, ?, ?, ?)";
                try (PreparedStatement orderStmt = conn.prepareStatement(insertOrderQuery)) {
                    orderStmt.setInt(1, customerId);
                    orderStmt.setDouble(2, subtotal);
                    orderStmt.setDouble(3, total);
                    if (couponId == 0) {
                        orderStmt.setNull(4, java.sql.Types.INTEGER);
                    } else {
                        orderStmt.setInt(4, couponId);
                    }
                    orderStmt.setInt(5, locationId);
                    orderStmt.setInt(6, restaurantId);
                    orderStmt.setString(7, address);
                    orderStmt.setString(8, receiverName);  // Insert receiver name
                    orderStmt.setString(9, phone);         // Insert phone number
                    int rowsAffected = orderStmt.executeUpdate();
                    if (rowsAffected == 0) {
                        return "Failed to place order. Please try again.";
                    }
                }

                // Retrieve the newly inserted order ID
                String getOrderIdQuery = "SELECT order_id FROM orders WHERE customer_id = ? AND subtotal = ? AND total_amount = ? AND ROWNUM = 1 ORDER BY order_date DESC";
                try (PreparedStatement orderIdStmt = conn.prepareStatement(getOrderIdQuery)) {
                    orderIdStmt.setInt(1, customerId);
                    orderIdStmt.setDouble(2, subtotal);
                    orderIdStmt.setDouble(3, total);
                    try (ResultSet rs = orderIdStmt.executeQuery()) {
                        if (rs.next()) {
                            orderId = rs.getInt("order_id");
                        } else {
                            return "Failed to retrieve order ID. Please try again.";
                        }
                    }
                }

                // Insert payment details into the payments table
                String insertPaymentQuery = "INSERT INTO payments (order_id, payment_method, payment_status, payment_date) VALUES (?, ?, ?, SYSDATE)";
                try (PreparedStatement paymentStmt = conn.prepareStatement(insertPaymentQuery)) {
                    paymentStmt.setInt(1, orderId);
                    paymentStmt.setString(2, paymentMethod);
                    paymentStmt.setString(3, paymentStatus);
                    paymentStmt.executeUpdate();
                }

                // Insert items into order_items table
                String insertOrderItemsQuery = "INSERT INTO order_items (order_id, item_id, quantity, price) VALUES (?, ?, ?, ?)";
                try (PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemsQuery)) {
                    for (Cart cart : cartItems) {
                        itemStmt.setInt(1, orderId);
                        itemStmt.setInt(2, cart.getItemId());
                        itemStmt.setInt(3, cart.getQuantity());
                        itemStmt.setDouble(4, cart.getItemPrice());
                        itemStmt.addBatch();
                    }
                    itemStmt.executeBatch();
                }

// Delete items from cart for the customer
                String deleteCartQuery = "DELETE FROM cart WHERE customer_id = ?";
                try (PreparedStatement deleteCartStmt = conn.prepareStatement(deleteCartQuery)) {
                    deleteCartStmt.setInt(1, customerId);
                    deleteCartStmt.executeUpdate();
                }

                conn.commit();

                // Send email if emailConfirmation is true
                if (emailConfirmation && email != null && !email.isEmpty()) {
                    String subject = "Order Confirmation";
                    String body = "Thank you for your order!\n\n"
                            + "We are happy to inform you that your order has been successfully placed.\n"
                            + "Your order ID is: " + orderId + ".\n\n"
                            + "Here are the details of your order:\n"
                            + "Total Amount: " + total + "\n"
                            + "Payment Method: " + paymentMethod + "\n\n"
                            + "Shipping Details:\n"
                            + "Receiver: " + receiverName + "\n"
                            + "Phone: " + phone + "\n"
                            + "Address: " + address + "\n\n"
                            + "We will notify you when your order is on its way.\n\n"
                            + "Thank you for choosing us! If you have any questions, feel free to reach out.";

                    boolean emailSent = EmailUtility.sendEmail(email, subject, body);
                    if (emailSent) {
                        System.out.println("Order placed successfully! A confirmation email has been sent.");
                    } else {
                        System.out.println("Order placed successfully! However, there was an issue sending the confirmation email.");
                    }

                }

                return "Order placed successfully!";
            } catch (SQLException e) {
                e.printStackTrace();
                return "Error placing order: " + e.getMessage();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "An error occurred: " + e.getMessage();
        }
    }
}

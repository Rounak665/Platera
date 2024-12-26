package Platera;

import Utilities.Cart;
import Utilities.CartDAO;
import Utilities.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer locationId=(Integer) session.getAttribute("location_id");
//        Integer customerId = (Integer) session.getAttribute("customer_id");
        Integer customerId = 30;  // Example: replace with session-based customer_id if needed

        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();

        try {
            // Retrieve cart items
            List<Cart> cartItems = cartDAO.getCartItems(customerId);

            if (cartItems == null || cartItems.isEmpty()) {
                response.getWriter().println("Cart is empty. Cannot place order.");
                return;
            }

            String address=(String) request.getParameter("address");
            double subtotal = 0;
            int couponId = 0;
            double couponDiscount = 0;
            int restaurantId = 0;

            for (Cart cart : cartItems) {
                subtotal += cart.getItemPrice() * cart.getQuantity();
                couponId = cart.getCouponId(); // Assuming all items in the cart have the same coupon ID
                restaurantId=cart.getRestaurantId();
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

            // Place the order and order items
            try (Connection conn = Database.getConnection()) {
                conn.setAutoCommit(false);

                // Insert order into orders table
                String insertOrderQuery = "INSERT INTO orders (customer_id, subtotal, total_amount, order_status, coupon_id, order_date, location, resturant_id, address) "
                        + "VALUES (?, ?, ?, 'Pending', ?, SYSDATE)";
                try (PreparedStatement stmt = conn.prepareStatement(insertOrderQuery)) {
                    stmt.setInt(1, customerId);
                    stmt.setDouble(2, subtotal);
                    stmt.setDouble(3, total);  // Corrected index for total
                    if (couponId == 0) {
                        stmt.setNull(4, java.sql.Types.INTEGER);
                    } else {
                        stmt.setInt(4, couponId);
                    }
                    stmt.setInt(5,locationId);
                    stmt.setInt(6, restaurantId);
                    stmt.setString(7, address);
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // Fetch the order_id of the newly inserted order
                        String getOrderIdQuery = "SELECT order_id "
                                + "FROM ("
                                + "    SELECT order_id "
                                + "    FROM orders "
                                + "    WHERE customer_id = ? AND subtotal = ? AND total_amount = ? "
                                + "    ORDER BY order_date DESC"
                                + ") "
                                + "WHERE ROWNUM = 1";
                        try (PreparedStatement getOrderStmt = conn.prepareStatement(getOrderIdQuery)) {
                            getOrderStmt.setInt(1, customerId);
                            getOrderStmt.setDouble(2, subtotal);
                            getOrderStmt.setDouble(3, total);
                            try (ResultSet rs = getOrderStmt.executeQuery()) {
                                if (rs.next()) {
                                    int orderId = rs.getInt("order_id");

                                    // Insert items into order_items table
                                    String insertOrderItemsQuery = "INSERT INTO order_items (order_id, item_id, quantity, price) "
                                            + "VALUES (?, ?, ?, ?)";
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

                                    // Clear the cart
//                                    String clearCartQuery = "DELETE FROM cart WHERE customer_id = ?";
//                                    try (PreparedStatement clearStmt = conn.prepareStatement(clearCartQuery)) {
//                                        clearStmt.setInt(1, customerId);
//                                        clearStmt.executeUpdate();
//                                    }
                                }
                            }
                        }
                    } else {
                        conn.rollback();
                        response.getWriter().println("Failed to place order. Please try again.");
                        return;
                    }
                }

                conn.commit();
                response.sendRedirect("orderConfirmation.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error placing order. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred. Please try again.");
        }
    }
}

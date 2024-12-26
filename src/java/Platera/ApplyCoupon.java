package Platera;

import Utilities.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ApplyCoupon")
public class ApplyCoupon extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customer_id");
//        Integer customerId = 30;

        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String couponCode = request.getParameter("coupon_code");

        try (Connection conn = Database.getConnection()) {
            // Check if coupon is valid and not expired
            String query = "SELECT coupon_id, coupon_discount FROM coupons WHERE coupon_code = ? AND expiration_date >= SYSDATE";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, couponCode);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int couponId = rs.getInt("coupon_id");
                        int discount = rs.getInt("coupon_discount");

                        // Update the cart with the coupon ID for the customer
                        String updateCartQuery = "UPDATE cart SET coupon_id = ? WHERE customer_id = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery)) {
                            updateStmt.setInt(1, couponId);
                            updateStmt.setInt(2, customerId);
                            int rowsUpdated = updateStmt.executeUpdate();

                            if (rowsUpdated > 0) {
                                response.getWriter().println("Coupon applied successfully! Discount: ₹" + discount);
                            } else {
                                response.getWriter().println("Failed to apply coupon.");
                            }
                        }
                    } else {
                        response.getWriter().println("Invalid or expired coupon.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error applying coupon. Please try again.");
        }
    }
}

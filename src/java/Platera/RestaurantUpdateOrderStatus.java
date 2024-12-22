/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Platera;

import Utilities.Database;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author rouna
 */
@WebServlet(name = "RestaurantUpdateOrderStatus", urlPatterns = {"/RestaurantUpdateOrderStatus"})

public class RestaurantUpdateOrderStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the order_id from the hidden input field in the form
        String orderId = request.getParameter("order_id");

        if (orderId != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                // Database connection
                conn = Database.getConnection();  // Assuming you have a utility class for DB connection

                // SQL query to update order status to "Ready"
                String updateSql = "UPDATE orders SET order_status = ? WHERE order_id = ?";

                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, "Ready");  // Set the order status to "Ready"
                stmt.setInt(2, Integer.parseInt(orderId));  // Set the order_id

                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    // Successfully updated the order status
                    response.getWriter().println("Order status updated to 'Ready' successfully!");
                } else {
                    // Handle the case when no rows were updated (order_id may not exist)
                    response.getWriter().println("Order not found or update failed.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error updating order status.");
            } finally {
                // Clean up database resources
                try {
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
        } else {
            response.getWriter().println("No order ID provided.");
        }
        response.sendRedirect("src/pages/Restaurant/Orders.jsp?success=StatusUpdated");
    }
}


package Platera;


import Utilities.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AcceptOrder")
public class AcceptOrder extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String deliveryExecutiveId = request.getParameter("deliveryExecutiveId");
        String deliveryAddress = request.getParameter("deliveryAddress");

        if (orderId == null || deliveryExecutiveId == null || deliveryAddress == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters.");
            return;
        }

        String insertDeliverySql = "INSERT INTO deliveries (order_id, delivery_executive_id, delivery_address) VALUES (?, ?, ?)";
        String updateOrderSql = "UPDATE orders SET order_status = 'Accepted' WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement insertStmt = conn.prepareStatement(insertDeliverySql);
             PreparedStatement updateStmt = conn.prepareStatement(updateOrderSql)) {

            // Insert into deliveries
            insertStmt.setInt(1, Integer.parseInt(orderId));
            insertStmt.setInt(2, Integer.parseInt(deliveryExecutiveId));
            insertStmt.setString(3, deliveryAddress);
            insertStmt.executeUpdate();

            // Update order status
            updateStmt.setInt(1, Integer.parseInt(orderId));
            updateStmt.executeUpdate();

            response.getWriter().println("Order accepted and delivery details saved successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while processing the request: " + e.getMessage());
        }
    }
}

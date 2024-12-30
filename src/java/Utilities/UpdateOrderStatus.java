/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateOrderStatus {

    // Method to update the order status
    public static boolean updateStatus(int orderId, String status) {
        // SQL query to update order status in the database
        String query = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        
        try (Connection conn = Utilities.Database.getConnection(); // Get database connection
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameters
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            // Execute the update
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if the status was updated successfully
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if there was an error
        }
    }
}

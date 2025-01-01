package Utilities;

import java.sql.*;
import java.util.*;

public class DeliveryExecutiveDAO {

    // Get delivery executive by executive_id
    public static DeliveryExecutive getDeliveryExecutiveById(int executiveId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT d.delivery_executive_id, u.user_id, u.name, u.email, u.phone, u.address, dd.vehicle_type, dd.vehicle_number, "
                + "d.location as location_id, l.location_name, d.image, d.status, u.two_step_verification "
                + "FROM delivery_executives d "
                + "LEFT JOIN users u ON u.user_id = d.user_id "
                + "LEFT JOIN locations l ON d.location = l.location_id "
                + "LEFT JOIN delivery_executive_documents dd ON dd.delivery_executive_id = d.delivery_executive_id "
                + "WHERE d.delivery_executive_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, executiveId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                DeliveryExecutive executive = new DeliveryExecutive();
                executive.setUserId(rs.getInt("user_id"));
                executive.setExecutiveId(rs.getInt("delivery_executive_id"));
                executive.setFullName(rs.getString("name"));
                executive.setEmail(rs.getString("email"));
                executive.setPhone(rs.getString("phone"));
                executive.setAddress(rs.getString("address"));
                executive.setVehicleType(rs.getString("vehicle_type"));
                executive.setVehicleNumber(rs.getString("vehicle_number"));
                executive.setLocationId(rs.getInt("location_id"));
                executive.setLocation(rs.getString("location_name"));
                executive.setImage(rs.getString("image"));
                executive.setStatus(rs.getString("status"));
                executive.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification"))); 
                return executive;
            }
        }
        return null;
    }

    // Get delivery executive by user_id
    public static DeliveryExecutive getDeliveryExecutiveByUserId(int userId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT d.delivery_executive_id, u.name, u.email, u.phone, u.address, dd.vehicle_type, dd.vehicle_number, "
                + "d.location as location_id, l.location_name, d.image, d.status, u.two_step_verification "
                + "FROM delivery_executives d "
                + "LEFT JOIN users u ON u.user_id = d.user_id "
                + "LEFT JOIN locations l ON d.location = l.location_id "
                + "LEFT JOIN delivery_executive_documents dd ON dd.delivery_executive_id = d.delivery_executive_id "
                + "WHERE u.user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                DeliveryExecutive executive = new DeliveryExecutive();
                executive.setExecutiveId(rs.getInt("delivery_executive_id"));
                executive.setFullName(rs.getString("name"));
                executive.setEmail(rs.getString("email"));
                executive.setPhone(rs.getString("phone"));
                executive.setAddress(rs.getString("address"));
                executive.setVehicleType(rs.getString("vehicle_type"));
                executive.setVehicleNumber(rs.getString("vehicle_number"));
                executive.setLocationId(rs.getInt("location_id"));
                executive.setLocation(rs.getString("location_name"));
                executive.setImage(rs.getString("image"));
                executive.setStatus(rs.getString("status"));
                executive.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification"))); // Map 'Y'/'N' to boolean
                return executive;
            }
        }
        return null;
    }

    // Get all delivery executives
    public static List<DeliveryExecutive> getAllDeliveryExecutives() throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT d.delivery_executive_id, u.name, u.email, u.phone, u.address, dd.vehicle_type, dd.vehicle_number, "
                + "d.location as location_id, l.location_name, d.image, d.status, u.two_step_verification "
                + "FROM delivery_executives d "
                + "LEFT JOIN users u ON u.user_id = d.user_id "
                + "LEFT JOIN locations l ON d.location = l.location_id "
                + "LEFT JOIN delivery_executive_documents dd ON dd.delivery_executive_id = d.delivery_executive_id";
        List<DeliveryExecutive> executives = new ArrayList<>();
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                DeliveryExecutive executive = new DeliveryExecutive();
                executive.setExecutiveId(rs.getInt("executive_id"));
                executive.setFullName(rs.getString("name"));
                executive.setEmail(rs.getString("email"));
                executive.setPhone(rs.getString("phone"));
                executive.setAddress(rs.getString("address"));
                executive.setVehicleType(rs.getString("vehicle_type"));
                executive.setVehicleNumber(rs.getString("vehicle_number"));
                executive.setLocationId(rs.getInt("location_id"));
                executive.setLocation(rs.getString("location_name"));
                executive.setImage(rs.getString("image"));
                executive.setStatus(rs.getString("status"));
                executive.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification"))); // Map 'Y'/'N' to boolean
                executives.add(executive);
            }
        }
        return executives;
    }


// Save a new delivery executive
public static boolean saveDeliveryExecutive(DeliveryExecutive executive) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "INSERT INTO delivery_executives (user_id, vehicle_type, location_id, image, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, executive.getUserId());
            stmt.setString(2, executive.getVehicleType());
            stmt.setInt(3, executive.getLocationId());
            stmt.setString(4, executive.getImage());
            stmt.setString(5, executive.getStatus());
            return stmt.executeUpdate() > 0;
        }
    }

    // Update delivery executive
public static boolean updateDeliveryExecutiveProfile(DeliveryExecutive executive) throws SQLException {
    Connection conn = Utilities.Database.getConnection();

    // Query to update the 'delivery_executives' table
    String query1 = "UPDATE delivery_executives "
                  + "SET image = CASE WHEN ? IS NOT NULL AND LENGTH(TRIM(?)) > 0 THEN ? ELSE image END, "
                  + "    location = ? "
                  + "WHERE delivery_executive_id = ?";

    // Query to update the 'users' table
    String query2 = "UPDATE users "
                  + "SET name = ?, phone = ?, address = ? "
                  + "WHERE user_id = ?";

    // Query to update the 'delivery_executive_documents' table
    String query3 = "UPDATE delivery_executive_documents "
                  + "SET vehicle_type = ?, vehicle_number = ? "
                  + "WHERE delivery_executive_id = ?";

    try (PreparedStatement stmt1 = conn.prepareStatement(query1);
         PreparedStatement stmt2 = conn.prepareStatement(query2);
         PreparedStatement stmt3 = conn.prepareStatement(query3)) {

        // Set parameters for the first query (delivery_executives table)
        stmt1.setString(1, executive.getImage());
        stmt1.setString(2, executive.getImage());
        stmt1.setString(3, executive.getImage());
        stmt1.setInt(4, executive.getLocationId());
        stmt1.setInt(5, executive.getExecutiveId());

        // Execute the update for the delivery_executives table
        int rowsAffected1 = stmt1.executeUpdate();

        // Set parameters for the second query (users table)
        stmt2.setString(1, executive.getFullName());
        stmt2.setString(2, executive.getPhone());
        stmt2.setString(3, executive.getAddress());
        stmt2.setInt(4, executive.getUserId());

        int rowsAffected2 = stmt2.executeUpdate();

        // Set parameters for the third query (delivery_executive_documents table)
        stmt3.setString(1, executive.getVehicleType());
        stmt3.setString(2, executive.getVehicleNumber());
        stmt3.setInt(3, executive.getExecutiveId());

        int rowsAffected3 = stmt3.executeUpdate();

        // Return true if all updates affected rows (indicating success)
        return rowsAffected1 > 0 && rowsAffected2 > 0 && rowsAffected3 > 0;
    }
}




    // Delete delivery executive
    public static boolean deleteDeliveryExecutive(int executiveId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "DELETE FROM delivery_executives WHERE executive_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, executiveId);
            return stmt.executeUpdate() > 0;
        }
    }

}

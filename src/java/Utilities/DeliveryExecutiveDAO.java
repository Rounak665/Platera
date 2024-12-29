package Utilities;

import java.sql.*;
import java.util.*;

public class DeliveryExecutiveDAO {

    // Get delivery executive by executive_id
    public static DeliveryExecutive getDeliveryExecutiveById(int executiveId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT d.executive_id, u.name, u.email, u.phone, u.address, dd.vehicle_type, dd.vehicle_number, d.location as location_id, l.location_name, d.image, d.status " +
                       "FROM delivery_executives d " +
                       "LEFT JOIN users u ON u.user_id = d.user_id " +
                       "LEFT JOIN locations l ON d.location = l.location_id " +
                       "LEFT JOIN delivery_executive_documents dd ON dd.delivery_executive_id = d.delivery_executive_id " +
                       "WHERE d.executive_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, executiveId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
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
                return executive;
            }
        }
        return null;
    }

    // Get delivery executive by user_id
    public static DeliveryExecutive getDeliveryExecutiveByUserId(int userId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT d.delivery_executive_id, u.name, u.email, u.phone, u.address, dd.vehicle_type, dd.vehicle_number, d.location as location_id, l.location_name, d.image, d.status " +
                       "FROM delivery_executives d " +
                       "LEFT JOIN users u ON u.user_id = d.user_id " +
                       "LEFT JOIN locations l ON d.location = l.location_id " +
                       "LEFT JOIN delivery_executive_documents dd ON dd.delivery_executive_id = d.delivery_executive_id " +
                       "WHERE u.user_id = ?";
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
                return executive;
            }
        }
        return null;
    }

    // Get all delivery executives
    public static List<DeliveryExecutive> getAllDeliveryExecutives() throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT d.executive_id, u.name, u.email, u.phone, u.address, dd.vehicle_type, dd.vehicle_number, d.location as location_id, l.location_name, d.image, d.status " +
                       "FROM delivery_executives d " +
                       "LEFT JOIN users u ON u.user_id = d.user_id " +
                       "LEFT JOIN locations l ON d.location = l.location_id " +
                       "LEFT JOIN delivery_executive_documents dd ON dd.delivery_executive_id = d.delivery_executive_id";
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
    public static boolean updateDeliveryExecutive(DeliveryExecutive executive) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "UPDATE delivery_executives SET vehicle_type = ?, location_id = ?, image = ?, status = ? WHERE executive_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, executive.getVehicleType());
            stmt.setInt(2, executive.getLocationId());
            stmt.setString(3, executive.getImage());
            stmt.setString(4, executive.getStatus());
            stmt.setInt(5, executive.getExecutiveId());
            return stmt.executeUpdate() > 0;
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

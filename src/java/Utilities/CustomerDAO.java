package Utilities;

import java.sql.*;
import java.util.*;

public class CustomerDAO {

    // Get customer by customer_id (including location, two-step verification, and image details)
    public static Customer getCustomerById(int customerId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT c.customer_id, u.name, u.phone, u.address, c.location_id, l.location_name, u.email, u.two_step_verification, c.image "
                + "FROM customers c "
                + "LEFT JOIN users u ON u.user_id = c.user_id "
                + "LEFT JOIN locations l ON c.location_id = l.location_id "
                + "WHERE c.customer_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFullName(rs.getString("name"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setLocationId(rs.getInt("location_id"));
                customer.setLocation(rs.getString("location_name"));
                customer.setEmail(rs.getString("email"));
                customer.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification")));
                customer.setImage(rs.getString("image")); // Set the image
                return customer;
            }
        }
        return null; // Return null if no customer found for the given customer_id
    }

    // Get customer by user_id (including location, two-step verification, and image details)
    public static Customer getCustomerByUserId(int userId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT c.customer_id, u.name, u.phone, u.address, c.location_id, l.location_name, u.email, u.two_step_verification, c.image "
                + "FROM customers c "
                + "LEFT JOIN users u ON u.user_id = c.user_id "
                + "LEFT JOIN locations l ON c.location_id = l.location_id "
                + "WHERE u.user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFullName(rs.getString("name"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setLocationId(rs.getInt("location_id"));
                customer.setLocation(rs.getString("location_name"));
                customer.setEmail(rs.getString("email"));
                customer.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification")));
                customer.setImage(rs.getString("image")); // Set the image
                return customer;
            }
        }
        return null; // Return null if no customer found for the given user_id
    }

    // Get all customers (including location, two-step verification, and image details)
    public static List<Customer> getAllCustomers() throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT c.customer_id, u.name, u.phone, u.address, c.location_id, l.location_name, u.email, u.two_step_verification, c.image "
                + "FROM customers c "
                + "LEFT JOIN users u ON u.user_id = c.user_id "
                + "LEFT JOIN locations l ON c.location_id = l.location_id";
        List<Customer> customers = new ArrayList<>();
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFullName(rs.getString("name"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setLocationId(rs.getInt("location_id"));
                customer.setLocation(rs.getString("location_name"));
                customer.setEmail(rs.getString("email"));
                customer.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification")));
                customer.setImage(rs.getString("image")); // Set the image
                customers.add(customer);
            }
        }
        return customers;
    }

    // Update an existing customer (including location_id and two-step verification)
public static boolean updateCustomerProfile(Customer customer) throws SQLException {
    Connection conn = Utilities.Database.getConnection();

    // First query to update the 'customers' table
    String query1 = "UPDATE customers c "
                    + "SET c.location_id = ?, "
                    + "    c.image = CASE WHEN ? IS NOT NULL AND LENGTH(TRIM(?)) > 0 THEN ? ELSE c.image END "
                    + "WHERE c.customer_id = ?";

    // Second query to update the 'users' table
    String query2 = "UPDATE users u "
                    + "SET u.name = ?, u.phone = ?, u.address = ? "
                    + "WHERE u.user_id = (SELECT c.user_id FROM customers c WHERE c.customer_id = ?)";

    try (PreparedStatement stmt1 = conn.prepareStatement(query1);
         PreparedStatement stmt2 = conn.prepareStatement(query2)) {
        
        // Set parameters for the first query (customers table)
        stmt1.setInt(1, customer.getLocationId());
        stmt1.setString(2, customer.getImage());
        stmt1.setString(3, customer.getImage());
        stmt1.setString(4, customer.getImage());
        stmt1.setInt(5, customer.getCustomerId());
        
        // Execute the update for the customers table
        int rowsAffected1 = stmt1.executeUpdate();
        
        // Set parameters for the second query (users table)
        stmt2.setString(1, customer.getFullName());
        stmt2.setString(2, customer.getPhone());
        stmt2.setString(3, customer.getAddress());
        stmt2.setInt(4, customer.getCustomerId());
        
        // Execute the update for the users table
        int rowsAffected2 = stmt2.executeUpdate();
        
        // Return true if both updates affected rows (meaning successful)
        return rowsAffected1 > 0 && rowsAffected2 > 0;
    }
}


    // Delete customer
    public static boolean deleteCustomer(int customerId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "DELETE FROM customers WHERE customer_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            return stmt.executeUpdate() > 0;
        }
    }
}

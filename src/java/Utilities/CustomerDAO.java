package Utilities;

import java.sql.*;
import java.util.*;

public class CustomerDAO {

    // Get customer by customer_id (including location and two-step verification details)
    public static Customer getCustomerById(int customerId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT c.customer_id, u.name, u.phone, u.address, c.location_id, l.location_name, u.email, u.two_step_verification " +
                       "FROM customers c " +
                       "LEFT JOIN users u ON u.user_id = c.user_id " +
                       "LEFT JOIN locations l ON c.location_id = l.location_id " +
                       "WHERE c.customer_id = ?";
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
                return customer;
            }
        }
        return null; // Return null if no customer found for the given customer_id
    }

    // Get customer by user_id (including location and two-step verification details)
    public static Customer getCustomerByUserId(int userId) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT c.customer_id, u.name, u.phone, u.address, c.location_id, l.location_name, u.email, u.two_step_verification " +
                       "FROM customers c " +
                       "LEFT JOIN users u ON u.user_id = c.user_id " +
                       "LEFT JOIN locations l ON c.location_id = l.location_id " +
                       "WHERE u.user_id = ?";
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
                return customer;
            }
        }
        return null; // Return null if no customer found for the given user_id
    }

    // Get all customers (including location and two-step verification details)
    public static List<Customer> getAllCustomers() throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "SELECT c.customer_id, u.name, u.phone, u.address, c.location_id, l.location_name, u.email, u.two_step_verification " +
                       "FROM customers c " +
                       "LEFT JOIN users u ON u.user_id = c.user_id " +
                       "LEFT JOIN locations l ON c.location_id = l.location_id";
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
                customers.add(customer);
            }
        }
        return customers;
    }

    // Update an existing customer (including location_id and two-step verification)
    public static boolean updateCustomer(Customer customer) throws SQLException {
        Connection conn = Utilities.Database.getConnection();
        String query = "UPDATE customers SET location_id = ?, two_step_verification = ? WHERE customer_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customer.getLocationId());
            stmt.setString(2, customer.isTwoStepVerification() ? "Y" : "N");
            stmt.setInt(3, customer.getCustomerId());
            return stmt.executeUpdate() > 0;
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

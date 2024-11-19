package Platera;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAO {

    // Method to fetch all restaurants
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String query = "SELECT r.restaurant_id, r.name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price " +
                       "FROM restaurants r " +
                       "JOIN locations l ON r.location_id = l.location_id";

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // Create a new Restaurant object using the no-argument constructor
                Restaurant restaurant = new Restaurant();

                // Populate the fields using setters
                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setName(rs.getString("name"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setPhone(rs.getString("phone"));
                restaurant.setImage(rs.getString("image"));
                restaurant.setLocation(rs.getString("location_name"));
                restaurant.setMinPrice(rs.getDouble("min_price"));
                restaurant.setMaxPrice(rs.getDouble("max_price"));

                // Add the restaurant to the list
                restaurants.add(restaurant);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurants;
    }

    // Method to get a single restaurant by ID
    public Restaurant getRestaurantById(int restaurantId) {
        String query = "SELECT r.restaurant_id, r.name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price " +
                       "FROM restaurants r " +
                       "JOIN locations l ON r.location_id = l.location_id " +
                       "WHERE r.restaurant_id = ?";
        Restaurant restaurant = null;

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, restaurantId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Create a new Restaurant object using the no-argument constructor
                    restaurant = new Restaurant();

                    // Populate the fields using setters
                    restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                    restaurant.setName(rs.getString("name"));
                    restaurant.setAddress(rs.getString("address"));
                    restaurant.setPhone(rs.getString("phone"));
                    restaurant.setImage(rs.getString("image"));
                    restaurant.setLocation(rs.getString("location_name"));
                    restaurant.setMinPrice(rs.getDouble("min_price"));
                    restaurant.setMaxPrice(rs.getDouble("max_price"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    // Method to update the price range of a restaurant
    public boolean updatePriceRange(int restaurantId, double minPrice, double maxPrice) {
        String query = "UPDATE restaurants SET min_price = ?, max_price = ? WHERE restaurant_id = ?";
        boolean updated = false;

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            ps.setInt(3, restaurantId);

            updated = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return updated;
    }
}





//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class RestaurantDAO {
//
//    public List<Restaurant> getAllRestaurants() {
//        List<Restaurant> restaurantList = new ArrayList<>();
//
//        // Establishing the database connection
//        try (Connection con = Database.getConnection()) {
//            System.out.println("Database connection established.");
//
//            // SQL query to join restaurants with locations and fetch location_name
//            String query = "SELECT r.restaurant_id, r.name, l.location_name, r.image " +
//                           "FROM restaurants r " +
//                           "JOIN locations l ON r.location_id = l.location_id";
//            PreparedStatement stmt = con.prepareStatement(query);
//            ResultSet rs = stmt.executeQuery();
//
//            // Debugging: Check if query returns any results
//            System.out.println("Query executed. Checking results...");
//
//            while (rs.next()) {
//                Restaurant restaurant = new Restaurant();
//                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
//                restaurant.setName(rs.getString("name"));
//                restaurant.setLocation(rs.getString("location_name")); // Updated to set location_name
//                restaurant.setImage(rs.getString("image"));
//
//                restaurantList.add(restaurant);
//
//                // Debugging: Print each restaurant fetched
//                System.out.println("Fetched restaurant: " + restaurant.getName() + 
//                                   " at " + restaurant.getLocation());
//            }
//
//            // Debugging: Check the size of the list before returning
//            System.out.println("Total restaurants fetched: " + restaurantList.size());
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            System.out.println("Error fetching restaurants: " + e.getMessage());
//        }
//
//        return restaurantList;
//    }
//}





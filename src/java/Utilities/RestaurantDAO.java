package Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAO {

    // Method to fetch all restaurants
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String query = "SELECT r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price " +
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
                restaurant.setName(rs.getString("restaurant_name"));
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
        String query = "SELECT r.restaurant_id, r.restaurants_name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price " +
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
                    restaurant.setName(rs.getString("restaurant_name"));
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










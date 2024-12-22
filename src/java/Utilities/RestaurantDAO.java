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
        String query = "SELECT r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price, "
              + "c1.category_name AS CATEGORY_1_NAME, c2.category_name AS CATEGORY_2_NAME, c3.category_name AS CATEGORY_3_NAME, "
              + "AVG(re.rating) AS avg_rating "
              + "FROM restaurants r "
              + "JOIN locations l ON r.location_id = l.location_id "
              + "JOIN reviews re ON re.restaurant_id = r.restaurant_id "
              + "JOIN restaurant_categories rc ON rc.restaurant_id = r.restaurant_id "
              + "JOIN categories c1 ON rc.CATEGORY_1 = c1.category_id "
              + "JOIN categories c2 ON rc.CATEGORY_2 = c2.category_id "
              + "JOIN categories c3 ON rc.CATEGORY_3 = c3.category_id "
              + "GROUP BY r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, "
              + "r.max_price, c1.category_name, c2.category_name, c3.category_name;";

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

    public List<Restaurant> getRestaurantsByLocation(int location) {
        List<Restaurant> restaurants = new ArrayList<Restaurant>();
        String query = "SELECT r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price, "
                     + "c1.category_name AS CATEGORY_1_NAME, c2.category_name AS CATEGORY_2_NAME, c3.category_name AS CATEGORY_3_NAME, "
                     + "AVG(re.rating) AS avg_rating "
                     + "FROM restaurants r "
                     + "JOIN locations l ON r.location_id = l.location_id "
                     + "JOIN reviews re ON re.restaurant_id = r.restaurant_id "
                     + "JOIN restaurant_categories rc ON rc.restaurant_id = r.restaurant_id "
                     + "JOIN categories c1 ON rc.CATEGORY_1 = c1.category_id "
                     + "JOIN categories c2 ON rc.CATEGORY_2 = c2.category_id "
                     + "JOIN categories c3 ON rc.CATEGORY_3 = c3.category_id "
                     + "WHERE l.location_id = ? "
                     + "GROUP BY r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, "
                     + "r.max_price, c1.category_name, c2.category_name, c3.category_name";


        try (Connection con = Database.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, location);

            try (ResultSet rs = ps.executeQuery()) {
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
                    restaurant.setRating(rs.getDouble("avg_rating"));
                    restaurant.setCategory1(rs.getString("category_1_name"));
                    restaurant.setCategory2(rs.getString("category_2_name"));
                    restaurant.setCategory3(rs.getString("category_3_name"));

                    // Add the restaurant to the list
                    restaurants.add(restaurant);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurants;
    }

    // Method to get a single restaurant by ID
    public Restaurant getRestaurantById(int restaurantId) {
        String query = "SELECT r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price, "
                     + "c1.category_name AS CATEGORY_1_NAME, c2.category_name AS CATEGORY_2_NAME, c3.category_name AS CATEGORY_3_NAME, "
                     + "AVG(re.rating) AS avg_rating "
                     + "FROM restaurants r "
                     + "JOIN locations l ON r.location_id = l.location_id "
                     + "JOIN reviews re ON re.restaurant_id = r.restaurant_id "
                     + "JOIN restaurant_categories rc ON rc.restaurant_id = r.restaurant_id "
                     + "JOIN categories c1 ON rc.CATEGORY_1 = c1.category_id "
                     + "JOIN categories c2 ON rc.CATEGORY_2 = c2.category_id "
                     + "JOIN categories c3 ON rc.CATEGORY_3 = c3.category_id "
                     + "WHERE r.restaurant_id = ? "
                     + "GROUP BY r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, "
                     + "r.max_price, c1.category_name, c2.category_name, c3.category_name";
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
                    restaurant.setRating(rs.getDouble("avg_rating"));
                    restaurant.setCategory1(rs.getString("category_1_name"));
                    restaurant.setCategory2(rs.getString("category_2_name"));
                    restaurant.setCategory3(rs.getString("category_3_name"));
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

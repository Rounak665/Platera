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
            + "AVG(re.rating) AS avg_rating, "
            + "u.phone AS user_phone, u.address AS user_address, u.email AS user_email, u.two_step_verification "
            + "FROM restaurants r "
            + "LEFT JOIN users u ON u.user_id = r.owner_user_id "
            + "LEFT JOIN locations l ON r.location_id = l.location_id "
            + "LEFT JOIN reviews re ON re.restaurant_id = r.restaurant_id "
            + "LEFT JOIN restaurant_categories rc ON rc.restaurant_id = r.restaurant_id "
            + "LEFT JOIN categories c1 ON rc.CATEGORY_1 = c1.category_id "
            + "LEFT JOIN categories c2 ON rc.CATEGORY_2 = c2.category_id "
            + "LEFT JOIN categories c3 ON rc.CATEGORY_3 = c3.category_id "
            + "GROUP BY r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, "
            + "r.max_price, c1.category_name, c2.category_name, c3.category_name, "
            + "u.phone, u.address, u.email, u.two_step_verification";

    try (Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
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

            // Set user details (Owner information)
            restaurant.setOwnerPhone(rs.getString("user_phone"));
            restaurant.setOwnerAddress(rs.getString("user_address"));
            restaurant.setOwnerEmail(rs.getString("user_email"));
            restaurant.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification"))); 

            restaurants.add(restaurant);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return restaurants;
}

public List<Restaurant> getRestaurantsByLocation(int location) {
    List<Restaurant> restaurants = new ArrayList<>();
    String query = "SELECT r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price, "
            + "c1.category_name AS CATEGORY_1_NAME, c2.category_name AS CATEGORY_2_NAME, c3.category_name AS CATEGORY_3_NAME, "
            + "AVG(re.rating) AS avg_rating, "
            + "u.phone AS user_phone, u.address AS user_address, u.email AS user_email, u.two_step_verification "
            + "FROM restaurants r "
            + "LEFT JOIN users u ON u.user_id = r.owner_user_id "
            + "LEFT JOIN locations l ON r.location_id = l.location_id "
            + "LEFT JOIN reviews re ON re.restaurant_id = r.restaurant_id "
            + "LEFT JOIN restaurant_categories rc ON rc.restaurant_id = r.restaurant_id "
            + "LEFT JOIN categories c1 ON rc.CATEGORY_1 = c1.category_id "
            + "LEFT JOIN categories c2 ON rc.CATEGORY_2 = c2.category_id "
            + "LEFT JOIN categories c3 ON rc.CATEGORY_3 = c3.category_id "
            + "WHERE l.location_id = ? "
            + "GROUP BY r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, "
            + "r.max_price, c1.category_name, c2.category_name, c3.category_name, "
            + "u.phone, u.address, u.email, u.two_step_verification";

    try (Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement(query)) {

        ps.setInt(1, location);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
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

                // Set user details (Owner information)
                restaurant.setOwnerPhone(rs.getString("user_phone"));
                restaurant.setOwnerAddress(rs.getString("user_address"));
                restaurant.setOwnerEmail(rs.getString("user_email"));
                restaurant.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification"))); 

                restaurants.add(restaurant);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return restaurants;
}

public Restaurant getRestaurantById(int restaurantId) {
    String query = "SELECT r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, r.max_price, "
            + "c1.category_name AS CATEGORY_1_NAME, c2.category_name AS CATEGORY_2_NAME, c3.category_name AS CATEGORY_3_NAME, "
            + "AVG(re.rating) AS avg_rating, "
            + "u.phone AS user_phone, u.address AS user_address, u.email AS user_email, u.two_step_verification "
            + "FROM restaurants r "
            + "LEFT JOIN users u ON u.user_id = r.owner_user_id "
            + "LEFT JOIN locations l ON r.location_id = l.location_id "
            + "LEFT JOIN reviews re ON re.restaurant_id = r.restaurant_id "
            + "LEFT JOIN restaurant_categories rc ON rc.restaurant_id = r.restaurant_id "
            + "LEFT JOIN categories c1 ON rc.CATEGORY_1 = c1.category_id "
            + "LEFT JOIN categories c2 ON rc.CATEGORY_2 = c2.category_id "
            + "LEFT JOIN categories c3 ON rc.CATEGORY_3 = c3.category_id "
            + "WHERE r.restaurant_id = ? "
            + "GROUP BY r.restaurant_id, r.restaurant_name, r.address, r.phone, r.image, l.location_name, r.min_price, "
            + "r.max_price, c1.category_name, c2.category_name, c3.category_name, "
            + "u.phone, u.address, u.email, u.two_step_verification";

    Restaurant restaurant = null;

    try (Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement(query)) {

        ps.setInt(1, restaurantId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                // Create a new Restaurant object
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

                // Set user details (Owner information)
                restaurant.setOwnerPhone(rs.getString("user_phone"));
                restaurant.setOwnerAddress(rs.getString("user_address"));
                restaurant.setOwnerEmail(rs.getString("user_email"));
                restaurant.setTwoStepVerification("Y".equalsIgnoreCase(rs.getString("two_step_verification"))); 
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

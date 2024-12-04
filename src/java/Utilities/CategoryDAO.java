package Utilities;

import java.sql.*;
import java.util.*;

public class CategoryDAO {
    // Method to fetch all categories from the categories table
    public List<Category> getCategories() {
        List<Category> categories = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String query = "SELECT * FROM categories";  
            PreparedStatement stmt = conn.prepareStatement(query);  
            ResultSet rs = stmt.executeQuery();  

            // Loop through the result set
            while (rs.next()) {
                
                int categoryId = rs.getInt("category_id");  
                String categoryName = rs.getString("category_name");  

                // Create Category object with the fetched data
                Category category = new Category(categoryId, categoryName);

                // Add Category object to the list
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Handle any SQL exceptions
        }
        return categories;  // Return the list of Category objects
    }
}

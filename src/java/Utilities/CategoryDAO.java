package Utilities;

import java.sql.*;
import java.util.*;

public class CategoryDAO {

    public List<Category> getCategories() {
        List<Category> categories = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String query = "SELECT * FROM categories";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int categoryId = rs.getInt("category_id");
                String categoryName = rs.getString("category_name");

                Category category = new Category();
                category.setId(categoryId);
                category.setName(categoryName);

                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String query = "SELECT category_id, category_name, image FROM categories";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int categoryId = rs.getInt("category_id");
                String categoryName = rs.getString("category_name");
                String image = rs.getString("image");

                Category category = new Category();
                category.setId(categoryId);
                category.setName(categoryName);
                category.setImage(image);

                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
}

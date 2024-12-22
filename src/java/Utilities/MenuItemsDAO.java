package Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MenuItemsDAO {

    // Method to get all menu items for a restaurant with category name and availability
    public List<MenuItems> getMenuItemsByRestaurant(int restaurantId) {
        List<MenuItems> menuItems = new ArrayList<>();
        String query = "SELECT mi.item_id, mi.item_name, mi.price, mi.image, c.category_name, mi.availability " +
                       "FROM menu_items mi " +
                       "JOIN categories c ON c.category_id = mi.category_id " +
                       "WHERE mi.restaurant_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, restaurantId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MenuItems item = new MenuItems();

                    item.setItemId(rs.getInt("item_id"));
                    item.setItemName(rs.getString("item_name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setImage(rs.getString("image"));
                    item.setCategoryName(rs.getString("category_name"));

                    // Set the availability based on 'Y' or 'N'
                    String availability = rs.getString("availability");
                    item.setAvailability("Y".equals(availability)); // Set true for 'Y', false for 'N'

                    item.setRestaurantId(restaurantId);

                    menuItems.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menuItems;
    }

    // Method to get a single menu item by its ID, with category name and availability
    public MenuItems getMenuItemById(int itemId) {
        MenuItems item = null;
        String query = "SELECT mi.item_id, mi.item_name, mi.price, mi.image, c.category_name, mi.availability, mi.restaurant_id " +
                       "FROM menu_items mi " +
                       "JOIN categories c ON c.category_id = mi.category_id " +
                       "WHERE mi.item_id = ?";

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, itemId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    item = new MenuItems();
                    item.setItemId(rs.getInt("item_id"));
                    item.setItemName(rs.getString("item_name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setImage(rs.getString("image"));
                    item.setCategoryName(rs.getString("category_name"));

                    // Set the availability based on 'Y' or 'N'
                    String availability = rs.getString("availability");
                    item.setAvailability("Y".equals(availability)); // Set true for 'Y', false for 'N'

                    item.setRestaurantId(rs.getInt("restaurant_id"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return item;
    }
}

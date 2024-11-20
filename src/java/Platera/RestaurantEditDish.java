package Platera;

import FetchingClasses.Database;
import FetchingClasses.Category;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RestaurantEditDish")
public class RestaurantEditDish extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemId = request.getParameter("id");

        // Initialize variables to hold dish data
        String itemName = null;
        int categoryId = 0;
        double price = 0.0;
        String availability = null;
        String imagePath = null;

        // Initialize a list to hold categories
        ArrayList<Category> categories = new ArrayList<>();

        // Database connection and queries
        String queryMenuItem = "SELECT * FROM menu_items WHERE item_id = ?";
        String queryCategories = "SELECT * FROM categories";  // Update the table name to 'category'

        try (Connection connection = Database.getConnection();
             PreparedStatement statementMenuItem = connection.prepareStatement(queryMenuItem);
             PreparedStatement statementCategories = connection.prepareStatement(queryCategories)) {

            // Set the parameter in the query for menu item
            statementMenuItem.setInt(1, Integer.parseInt(itemId));

            // Execute the query and process the result for menu item
            ResultSet resultSetMenuItem = statementMenuItem.executeQuery();
            if (resultSetMenuItem.next()) {
                itemName = resultSetMenuItem.getString("item_name");
                categoryId = resultSetMenuItem.getInt("category_id");
                price = resultSetMenuItem.getDouble("price");
                availability = resultSetMenuItem.getString("availability");
                imagePath = resultSetMenuItem.getString("image");
            } else {
                response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=Dish not found");
                return;
            }

            // Execute the query to get categories and populate the list
            ResultSet resultSetCategories = statementCategories.executeQuery();
            while (resultSetCategories.next()) {
                Category category = new Category(resultSetCategories.getInt("category_id"), resultSetCategories.getString("category_name"));
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=Database error");
            return;
        }

        // Set the dish details and categories as session attributes
        request.getSession().setAttribute("itemId", itemId);
        request.getSession().setAttribute("itemName", itemName);
        request.getSession().setAttribute("categoryId", categoryId);
        request.getSession().setAttribute("price", price);
        request.getSession().setAttribute("availability", availability);
        request.getSession().setAttribute("imagePath", imagePath);
        request.getSession().setAttribute("categories", categories);

        // Redirect to the JSP page with the updated dish details
        response.sendRedirect("src/pages/Restaurant/EditDish.jsp");
    }
}

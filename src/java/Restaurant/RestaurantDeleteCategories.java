package Restaurant;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "RestaurantDeleteCategories", urlPatterns = {"/RestaurantDeleteCategories"})
public class RestaurantDeleteCategories extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the restaurant ID from the form inputs
        String restaurantIdParam = request.getParameter("restaurant_id");

        // Validate the restaurant ID
        if (restaurantIdParam == null || restaurantIdParam.isEmpty()) {
            response.setContentType("text/html");
            response.getWriter().println("<h3>Invalid restaurant ID provided.</h3>");
            return;
        }

        // Parse the restaurant ID to an integer
        int restaurantId = Integer.parseInt(restaurantIdParam);

        // Get the category ID from the form inputs (already an integer)
        int categoryId;
        try {
            categoryId = Integer.parseInt(request.getParameter("category_id"));
        } catch (NumberFormatException e) {
            response.setContentType("text/html");
            response.getWriter().println("<h3>Invalid category ID provided. It must be an integer.</h3>");
            return;
        }

        // Query to remove the category from restaurant_categories
        String updateQuery = "UPDATE restaurant_categories SET "
                + "category_1 = CASE WHEN category_1 = ? THEN NULL ELSE category_1 END, "
                + "category_2 = CASE WHEN category_2 = ? THEN NULL ELSE category_2 END, "
                + "category_3 = CASE WHEN category_3 = ? THEN NULL ELSE category_3 END "
                + "WHERE restaurant_id = ?";

        try (Connection conn = Utilities.Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(updateQuery)) {

            // Set query parameters
            ps.setInt(1, categoryId);
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, restaurantId);

            // Execute the update
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("src/pages/Restaurant/RestaurantMenu.jsp#errorPopup");
            } else {
                response.sendRedirect("src/pages/Restaurant/RestaurantMenu.jsp#errorPopup");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}

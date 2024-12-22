package Platera;

import java.io.IOException;
import static java.lang.System.out;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet(name = "RestaurantUpdateCategories", urlPatterns = {"/RestaurantUpdateCategories"})
public class RestaurantUpdateCategories extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch the restaurantId from session
        HttpSession session = request.getSession();
//        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
        Integer restaurantId=101;

        // If restaurantId is not found in session, redirect to login or an error page
        if (restaurantId == null) {
            response.sendRedirect("login.jsp"); // Or any appropriate redirect
            return;
        }

        // Fetch the selected categories from the form
        int category1Id = Integer.parseInt(request.getParameter("category-1"));
        int category2Id = Integer.parseInt(request.getParameter("category-2"));
        int category3Id = Integer.parseInt(request.getParameter("category-3"));

        // Update the restaurant_categories table
        try (Connection connection = Utilities.Database.getConnection()) {
            // SQL query to update the categories for the restaurant
            String updateQuery = "UPDATE restaurant_categories " +
                                 "SET category_1 = ?, category_2 = ?, category_3 = ? " +
                                 "WHERE restaurant_id = ?";

            try (PreparedStatement ps = connection.prepareStatement(updateQuery)) {
                // Set the parameters for the prepared statement
                ps.setInt(1, category1Id);
                ps.setInt(2, category2Id);
                ps.setInt(3, category3Id);
                ps.setInt(4, restaurantId);

                // Execute the update query
                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    // Successfully updated the categories
                    out.println("<h3>Categories updated successfully for Restaurant ID: " + restaurantId + ".</h3>");
                } else {
                    // If no rows were updated, maybe show an error
                    out.println("<h3>Error: No changes made. Please try again.</h3>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

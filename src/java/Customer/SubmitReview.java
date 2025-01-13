package Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SubmitReview")
public class SubmitReview extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Fetch form parameters
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String reviewText = request.getParameter("reviewText");
        int rating = Integer.parseInt(request.getParameter("rating"));

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Establish database connection
            con = Utilities.Database.getConnection();

            // SQL query to insert a new review
            String insertQuery = "INSERT INTO reviews (restaurant_id, customer_id, review_text, rating, review_date) " +
                                 "VALUES (?, ?, ?, ?, SYSDATE)";

            ps = con.prepareStatement(insertQuery);
            ps.setInt(1, restaurantId);
            ps.setInt(2, customerId);
            ps.setString(3, reviewText);
            ps.setInt(4, rating);

            // Execute the query
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                // Redirect to the restaurant page with a success message
                response.sendRedirect("src/pages/Customer/RestaurantDetails/RestaurantDetails.jsp?restaurantId=" + restaurantId + "&message=Review Submitted Successfully");
            } else {
                // Redirect with an error message
                response.sendRedirect("src/pages/Customer/RestaurantDetails/RestaurantDetails.jsp?restaurantId=" + restaurantId + "&error=Failed to Submit Review");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect with an error message in case of exception
            response.sendRedirect("src/pages/Customer/RestaurantDetails/RestaurantDetails.jsp?restaurantId=" + restaurantId + "&error=Something Went Wrong");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

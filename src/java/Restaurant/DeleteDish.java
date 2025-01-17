package Restaurant;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utilities.Database;

@WebServlet("/DeleteDish")
public class DeleteDish extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int itemId = Integer.parseInt(request.getParameter("id"));

        String deleteQuery = "DELETE FROM menu_items WHERE item_id = ?";

        try (Connection conn = Database.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(deleteQuery)) {
            
            pstmt.setInt(1, itemId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("src/pages/Restaurant/RestaurantMenu.jsp?success=DishRemoved");
            } else {
                response.sendRedirect("src/pages/Restaurant/RestaurantMenu.jsp#errorPopup");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}

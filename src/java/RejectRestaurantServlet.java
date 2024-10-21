import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/rejectRestaurant")
public class RejectRestaurantServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("request_id"));

        try (Connection conn = Database.getConnection()) {
            // Delete the request directly
            String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
            PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
            deletePstmt.setInt(1, requestId);
            deletePstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
            return;
        }

//        response.sendRedirect("adminRejectionSuccess.html"); 
    }
}

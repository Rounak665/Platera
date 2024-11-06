package Platera;

import Platera.Database;
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
        int request_id = Integer.parseInt(request.getParameter("request_id"));

        try (Connection conn = Database.getConnection()) {
            // Delete the request directly
            String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
            PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
            deletePstmt.setInt(1, request_id);
            deletePstmt.executeUpdate();
            response.setContentType("text/html");
            response.getWriter().println("<h2>Restaurant has been rejected successfully</h2>");
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred."+ e.getMessage());
        }

//        response.sendRedirect("adminRejectionSuccess.html"); 
    }
}

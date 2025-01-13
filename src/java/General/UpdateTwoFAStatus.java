package General;

import Utilities.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateTwoFAStatus", urlPatterns = {"/UpdateTwoFAStatus"})
public class UpdateTwoFAStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String twoStepStatus = request.getParameter("twoFA");

        if (twoStepStatus == null) {
            twoStepStatus = "N";
        } else {
            twoStepStatus = "Y";
        }

        String query = "UPDATE users SET two_step_verification = ? WHERE user_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Update the two-step verification status
            stmt.setString(1, twoStepStatus);
            stmt.setInt(2, userId);

            int rowsUpdated = stmt.executeUpdate();

            // Fetch the user_role_id after updating the table
            String roleQuery = "SELECT user_role_id FROM users WHERE user_id = ?";
            try (PreparedStatement roleStmt = conn.prepareStatement(roleQuery)) {
                roleStmt.setInt(1, userId);
                ResultSet rs = roleStmt.executeQuery();

                if (rs.next()) {
                    int userRoleId = rs.getInt("user_role_id");

                    // Redirect to different pages based on the user_role_id value
                    String redirectUrl = "";

                    switch (userRoleId) {
                        case 2:
                            redirectUrl = "src/pages/Customer/CustomerDashboard/CustomerProfile.jsp";  // Page for role 2
                            break;
                        case 3:
                            redirectUrl = "src/pages/DeliveryExecutive/DeliveryDashboard.jsp";  // Page for role 3
                            break;
                        case 4:
                            redirectUrl = "src/pages/Restaurant/RestaurantDashboard.jsp";  // Page for role 4
                            break;
                        default:
                            redirectUrl = "index.html";  // Default page for other roles
                            break;
                    }

                    // Redirect to the appropriate page
                    response.sendRedirect(redirectUrl);

                } else {
                    // If the user is not found
                    response.getWriter().println("<html><body><h3>User not found.</h3></body></html>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<html><body><h3>Error: " + e.getMessage() + "</h3></body></html>");
        }
    }
}

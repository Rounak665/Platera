package DeliveryExecutive;


import Utilities.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateExecutiveStatus")
public class UpdateExecutiveStatus extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int executiveId = Integer.parseInt(request.getParameter("executive_id"));
        String executiveStatus = request.getParameter("executive_status");
        
        try (Connection conn = Database.getConnection()) {
            String updateQuery = "UPDATE delivery_executives SET status = ? WHERE delivery_executive_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                stmt.setString(1, executiveStatus);
                stmt.setInt(2, executiveId);
                
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("src/pages/DeliveryExecutive/DeliveryDashboard.jsp"); 
                } else {
                    response.sendRedirect("src/pages/DeliveryExecutive/DeliveryExecutiveDashboard.jsp#errorPopup");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}

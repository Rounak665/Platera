
package General;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/UpdateOrderStatus")
public class UpdateOrderStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("order_id");
        String status = request.getParameter("order_status");

        if (orderIdStr == null || orderIdStr.isEmpty() || status == null || status.isEmpty()) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                orderIdStr = (String) session.getAttribute("order_id");
                status = (String) session.getAttribute("order_status");
            }
        }

        if (orderIdStr == null || orderIdStr.isEmpty() || status == null || status.isEmpty()) {
            response.sendRedirect("/errorPage.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            String query = "UPDATE orders SET order_status = ? WHERE order_id = ?";

            try (Connection conn = Utilities.Database.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, status);
                stmt.setInt(2, orderId);

                if (stmt.executeUpdate() > 0) {
                    response.sendRedirect(getRedirectPage(status));
                } else {
                    response.sendRedirect("/errorPage.jsp");
                }
            }

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("/errorPage.jsp");
        }
    }

    private String getRedirectPage(String status) {
        switch (status) {
            case "Ready":
                return "src/pages/Restaurant/RestaurantDashboard.jsp";
            case "Picked Up":
                return "src/pages/DeliveryExecutive/DeliveryDashboard.jsp";
            case "Delivered":
                return "src/pages/DeliveryExecutive/DeliveryDashboard.jsp";
            default:
                return "/defaultPage.jsp";
        }
    }
}


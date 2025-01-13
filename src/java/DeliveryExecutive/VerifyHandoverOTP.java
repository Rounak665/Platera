package DeliveryExecutive;

import Utilities.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VerifyHandoverOTP")
public class VerifyHandoverOTP extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the OTP entered by the user
        String enteredOTP = request.getParameter("otp");
        String orderId = request.getParameter("order_id");
        
        // Fetch the stored OTP from the session
        String storedOTP = (String) request.getSession().getAttribute("handoverOTP");

        // Check if the entered OTP matches the stored OTP
        if (storedOTP != null && storedOTP.equals(enteredOTP)) {
            // OTP matches, proceed to update order status to 'Delivered'
            updateOrderStatus(orderId);

            // Redirect to success page
            response.sendRedirect("src/pages/DeliveryExecutive/DeliveryDashboard.jsp#orderDelivered");
        } else {
            // OTP does not match, redirect to error page
            response.sendRedirect("src/pages/Error/WrongOTP.jsp#errorPopup");
        }
    }

    // Method to update the order status to 'Delivered'
    private void updateOrderStatus(String orderId) {
        // SQL query to update the order status
        String updateOrderStatusQuery = "UPDATE orders SET order_status = 'Delivered' WHERE order_id = ?";

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateOrderStatusQuery)) {

            // Set the order_id parameter
            statement.setString(1, orderId);

            // Execute the update
            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle error (e.g., log or send an error response)
        }
    }
}

package DeliveryExecutive;

import Utilities.EmailUtility;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.SecureRandom;

@WebServlet("/GenerateHandoverOTP")
public class GenerateHandoverOTP extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the email address from the form
        String email = request.getParameter("email");
        
        if (email == null || email.isEmpty()) {
            response.sendRedirect("src/pages/DeliveryExecutive/DeliveryDashboard.jsp#errorPopup");
            return;
        }

        // Generate a 6-digit OTP
        String otp = generateOTP();
        
        // Send the OTP to the customer's email using EmailUtility
        String subject = "OTP for Handover Verification - Platera Delivery";
        String body = "Dear Customer,\n\n"
                + "Thank you for using Platera. To verify your handover with the delivery executive, please provide the following OTP:\n\n"
                + "OTP: " + otp + "\n\n"
                + "Please give this OTP to the delivery executive when accepting the order.\n\n"
                + "If you did not request this, please disregard this message.\n\n"
                + "Best regards,\n"
                + "Platera Delivery Team";

        boolean isSent = EmailUtility.sendEmail(email, subject, body);

        if (isSent) {
            // Store the OTP in session for later verification
            request.getSession().setAttribute("handoverOTP", otp);

            // Redirect to the popup or success page
            response.sendRedirect("src/pages/DeliveryExecutive/DeliveryDashboard.jsp#popupOTPContainer");
        } else {
            // Error in sending OTP, redirect to error page
            response.sendRedirect("src/pages/DeliveryExecutive/DeliveryDashboard.jsp#errorPopup");
        }
    }

    // Method to generate a random 6-digit OTP
    private String generateOTP() {
        SecureRandom random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000); // 6-digit OTP
        return String.valueOf(otp);
    }
}

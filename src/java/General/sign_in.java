package General;

import Utilities.Database;
import Utilities.EmailUtility;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  // Import for session handling

@WebServlet("/sign_in")
public class sign_in extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email_signin");
        String password = request.getParameter("password_signin");
        

        try (Connection conn = Database.getConnection()) {
            // Validate the user's credentials and get user_id, user_role_id, two_step_verification, and email
            String sql = "SELECT user_id, user_role_id, two_step_verification, email FROM USERS WHERE email = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int user_id = rs.getInt("user_id");
                        String twoStepVerification = rs.getString("two_step_verification");
                        int userRoleId = rs.getInt("user_role_id");
                        String userEmail = rs.getString("email");

                        // Create or get session, store user_id, user_role_id and welcomePopup flag
                        HttpSession session = request.getSession(true);
                        session.setAttribute("user_id", user_id);
                        session.setAttribute("welcomePopup", false);  // Set welcome popup flag
                        session.setAttribute("user_role_id", userRoleId);  // Store user role in session

                        // If two_step_verification is 'Y', generate OTP, send email, and store in session
                        if ("Y".equals(twoStepVerification)) {
                            // Generate OTP
                            String otp = generateOTP();

                            // Store OTP in session for verification on the next page
                            session.setAttribute("otp", otp);

                            // Create the subject and body for the email
                            String subject = "Platera - Two-Step Verification OTP";
                            String body = "Dear User,\n\n"
                                    + "Thank you for signing in to your Platera account. As part of our security protocol, please use the one-time passcode (OTP) below to complete your login process.\n\n"
                                    + "Your OTP is: " + otp + "\n\n"
                                    + "Please enter this code in the OTP verification page to proceed. If you did not request this OTP, please ignore this email.\n\n"
                                    + "Best regards,\n"
                                    + "The Platera Team";

                            // Send OTP to the user's email
                            boolean emailSent = EmailUtility.sendEmail(userEmail, subject, body);

                            if (emailSent) {
                                // Redirect to OTP verification page
                                response.sendRedirect("src/pages/OTPVerifications/TwoFAVerifyOTP.jsp");  // Redirect to OTP verification page
                            } else {
                                // If email sending failed, show an error
                                out.println("<h2>Error sending OTP!</h2>");
                                out.println("<p>There was an issue sending the OTP to your email. Please try again later.</p>");
                            }
                        } else {
                            // Handle redirection based on user role
                            String dashboardUrl = "";
                            switch (userRoleId) {
                                case 1:  // Admin
                                    dashboardUrl = "src/pages/Admin/Admin_Order_Management.jsp";
                                    break;
                                case 2:  // Customer
                                    dashboardUrl = "src/pages/Customer/Home.jsp";
                                    break;
                                case 3:  // Restaurant
                                    dashboardUrl = "src/pages/Restaurant/RestaurantDashboard.jsp";
                                    break;
                                case 4:  // Delivery Executive
                                    dashboardUrl = "src/pages/DeliveryExecutive/DeliveryDashboard.jsp";
                                    break;
                                default:
                                    out.println("<h2>Invalid user role!</h2>");
                                    return;  // Exit if the user role is invalid
                            }
                            // Redirect to the relevant dashboard
                            response.sendRedirect(dashboardUrl);
                        }
                    } else {
                        // Invalid credentials
                        out.println("<h2>Login Failed!</h2>");
                        out.println("<p>Invalid email or password. Please try again.</p>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h2>Something went wrong!</h2>");
        }
    }

    // Helper method to generate a random 6-digit OTP
    private String generateOTP() {
        SecureRandom random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000);  // Generates a 6-digit OTP
        return String.valueOf(otp);
    }
}

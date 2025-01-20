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
        String rememberMe = request.getParameter("rememberMe"); // Retrieve "Remember Me" checkbox

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

                        // Create or get session, store user_id, user_role_id, and welcomePopup flag
                        HttpSession session = request.getSession(true);
                        session.setAttribute("user_id", user_id);
                        session.setAttribute("welcomePopup", false);
                        session.setAttribute("user_role_id", userRoleId);


                        if ("on".equals(rememberMe)) { 

                            javax.servlet.http.Cookie emailCookie = new javax.servlet.http.Cookie("email", email);
                            javax.servlet.http.Cookie passwordCookie = new javax.servlet.http.Cookie("password", password);

                            // Set cookie expiration (e.g., 7 days)
                            emailCookie.setMaxAge(7 * 24 * 60 * 60);
                            passwordCookie.setMaxAge(7 * 24 * 60 * 60);

                            // Add cookies to the response
                            response.addCookie(emailCookie);
                            response.addCookie(passwordCookie);
                        }

                        // If two-step verification is required
                        if ("Y".equals(twoStepVerification)) {
                            String otp = generateOTP();
                            session.setAttribute("otp", otp);

                            String subject = "Platera - Two-Step Verification OTP";
                            String body = "Dear User,\n\nYour OTP is: " + otp + "\n\nBest regards,\nPlatera Team";
                            boolean emailSent = EmailUtility.sendEmail(userEmail, subject, body);

                            if (emailSent) {
                                response.sendRedirect("src/pages/OTPVerifications/TwoFAVerifyOTP.jsp");
                            } else {
                                out.println("<h2>Error sending OTP!</h2>");
                                out.println("<p>There was an issue sending the OTP to your email. Please try again later.</p>");
                            }
                        } else {
                            String dashboardUrl = getDashboardUrl(userRoleId);
                            response.sendRedirect(dashboardUrl);
                        }
                    } else {
                        response.sendRedirect("src/pages/Error/EmailPasswordChecker.html");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/OTPVerifications/CustomerVerifyOTP.jsp");
        }
    }

    private String generateOTP() {
        SecureRandom random = new SecureRandom();
        return String.valueOf(100000 + random.nextInt(900000));
    }

    private String getDashboardUrl(int userRoleId) {
        switch (userRoleId) {
            case 1:
                return "src/pages/Admin/Admin_Order_Management.jsp";
            case 2:
                return "src/pages/Customer/Home.jsp";
            case 3:
                return "src/pages/Restaurant/RestaurantDashboard.jsp";
            case 4:
                return "src/pages/DeliveryExecutive/DeliveryDashboard.jsp";
            default:
                throw new IllegalArgumentException("Invalid user role!");
        }
    }
}

package General;

import Utilities.Database;
import Utilities.EmailUtility;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Check if the email exists in the database
            if (!isEmailRegistered(email)) {
                out.println("<h1>Error: The email address is not registered.</h1>");
                return;
            }

            // Generate OTP
            Random rand = new Random();
            int otp = 100000 + rand.nextInt(900000); // Generate a 6-digit OTP

            // Store OTP in session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Send OTP to email
            String subject = "Platera OTP for Password Reset";
            String body = "Your OTP for password reset is: " + otp;

            boolean isEmailSent = EmailUtility.sendEmail(email, subject, body);

            if (isEmailSent) {
                response.sendRedirect("src/pages/ForgotPassword/ForgotPassVerifyOTP.jsp");
            } else {
                response.sendRedirect("src/pages/ForgotPassword/ForgotPassVerifyOTP.jsp#errorPopup");
            }
        }
    }

    private boolean isEmailRegistered(String email) {
        String query = "SELECT email FROM users WHERE email = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next(); // Return true if the email exists
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Log properly in production          
            return false;
        }
    }
}

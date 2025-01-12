package General;

import Utilities.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ResetPassword")
public class ResetPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve new password and confirmation from the request
        String newPassword = request.getParameter("newPassword");
        String reEnteredPassword = request.getParameter("confirmPassword");

        // Retrieve email from the session (assuming OTP verification has already been done)
        HttpSession session = request.getSession(false);
        String email = (session != null) ? (String) session.getAttribute("email") : null;

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (email == null) {
                out.println("<h1>Error: Session expired. Please try the password reset process again.</h1>");
                return;
            }

            if (!newPassword.equals(reEnteredPassword)) {
                out.println("<h1>Passwords do not match!</h1>");
                return;
            }

            // Update the password in the database
            String updateQuery = "UPDATE users SET password = ? WHERE email = ?";

            try (Connection conn = Database.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {

                pstmt.setString(1, newPassword); // Set the new password
                pstmt.setString(2, email);       // Match the user by email

                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<h1>Password updated successfully!</h1>");
                    session.invalidate();
                } else {
                    out.println("<h1>Error updating password. Please try again later.</h1>");
                }
            } catch (SQLException e) {
                e.printStackTrace();  // Log this properly using a logger in production
                out.println("<h1>Error updating password. Please try again later.</h1>");
            }
        }
    }
}

package Platera;

import Utilities.Database;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (newPassword.equals(confirmPassword)) {
            // Get the email from the session
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");
            
            // Update the password in the database
            try (Connection conn = Database.getConnection()) {
                String sql = "UPDATE users SET password = ? WHERE email = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, newPassword);
                    stmt.setString(2, email);
                    stmt.executeUpdate();
                }
                // Redirect to login page after successful password update
                response.sendRedirect("login.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error updating password.");
            }
        } else {
            // Passwords don't match
            request.setAttribute("errorMessage", "Passwords do not match. Please try again.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }
}

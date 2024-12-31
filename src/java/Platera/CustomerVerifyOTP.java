package Platera;

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
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/CustomerVerifyOTP"})
public class CustomerVerifyOTP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the OTP entered by the user
        String enteredOTP = request.getParameter("otp");

        // Get the session to retrieve stored OTP and user data
        HttpSession session = request.getSession();
        Integer sessionOTP = (Integer) session.getAttribute("otp");
        String name = (String) session.getAttribute("name");
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");

        // Handle missing email scenario
        if (email == null) {
            response.getWriter().println("Email is missing. Please sign up again.");
            return;
        }

        // Set response content type
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (sessionOTP != null && sessionOTP.equals(Integer.valueOf(enteredOTP))) {
                // OTP verified successfully
                out.println("<h1>OTP verified successfully!</h1>");

                // Database connection
                try (Connection conn = Database.getConnection()) {
                    // Insert the new user
                    String insertSql = "INSERT INTO users (name, email, password, user_role_id) VALUES (?, ?, ?, 2)";
                    try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                        stmt.setString(1, name);
                        stmt.setString(2, email);
                        stmt.setString(3, password);
                        stmt.executeUpdate();
                    }

                    // Now fetch the user_id based on email
                    String selectSql = "SELECT user_id FROM users WHERE email = ?";
                    try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                        selectStmt.setString(1, email);
                        try (ResultSet rs = selectStmt.executeQuery()) {
                            if (rs.next()) {
                                int userId = rs.getInt("user_id");

                                // Set the user_id in the session
                                session.setAttribute("user_id", userId);
                            }
                        }
                    }

                    // Redirect to the customer profile page
                    response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp");
                } catch (SQLException e) {
                    out.println("<p>Error saving data to the database: " + e.getMessage() + "</p>");
                }

                // Clear session attributes after successful signup
                session.removeAttribute("otp");
                session.removeAttribute("name");
                session.removeAttribute("email");
                session.removeAttribute("password");

            } else {
                // OTP verification failed
                out.println("<h1>Invalid OTP. Please try again.</h1>");
                out.println("<p>User: " + name + "</p>");  // Print the name for debugging
                request.setAttribute("errorMessage", "Invalid OTP. Please try again.");
            }
        }
    }
}

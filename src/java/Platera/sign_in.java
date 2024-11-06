package Platera;

import Platera.Database;
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
import javax.servlet.http.HttpSession;  // Import for session handling
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/sign_in")
public class sign_in extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(sign_in.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email_signin");
        String password = request.getParameter("password_signin");

        try (Connection conn = Database.getConnection()) {
            // First query to validate the user's credentials and get user_role_id
            String sql = "SELECT user_role_id FROM USERS WHERE email = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int user_role_id = rs.getInt("user_role_id");

                        // Second query to fetch the user's name using the email (or user_id)
                        String nameSql = "SELECT name FROM USERS WHERE email = ?";
                        try (PreparedStatement nameStmt = conn.prepareStatement(nameSql)) {
                            nameStmt.setString(1, email);
                            try (ResultSet nameRs = nameStmt.executeQuery()) {
                                if (nameRs.next()) {
                                    String name = nameRs.getString("name");

                                    // Create or get session only after user validation
                                    HttpSession session = request.getSession(true);  // Create a new session if it doesn't exist

                                    // Store user email, role, and name in session
                                    session.setAttribute("email", email);
                                    session.setAttribute("user_role_id", user_role_id);
                                    session.setAttribute("name", name);  // Set the name attribute in the session

                                    // Redirect based on user role
                                    switch (user_role_id) {
                                        case 1:
                                            response.sendRedirect("src/pages/Admin/Admin_Order_Management.html"); // Admin
                                            break;
                                        case 2:
                                            response.sendRedirect("src/pages/Home/Home.jsp"); // Customer
                                            break;
                                        case 3:
                                            response.sendRedirect("src/pages/RestaurentDashboard/RestaurantDashboard.html"); // Restaurant owner
                                            break;
                                        case 4:
                                            response.sendRedirect("src/pages/Home/Home.jsp"); // Delivery executive
                                            break;
                                        default:
                                            out.println("<h2>Invalid Role!</h2>");
                                    }
                                }
                            }
                        }
                    } else {
                        // Display error message if user not found
                        out.println("<h2>Login Failed!</h2>");
                        out.println("<p>Invalid email or password. Please try again.</p>");
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error occurred", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + e.getMessage());
        }
    }
}

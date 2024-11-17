package Platera;

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
            // First query to validate the user's credentials and get user_role_id and user_id
            String sql = "SELECT user_role_id, user_id FROM USERS WHERE email = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int user_role_id = rs.getInt("user_role_id");
                        int user_id = rs.getInt("user_id");

                        // Fetch user's name
                        String nameSql = "SELECT name FROM USERS WHERE email = ?";
                        try (PreparedStatement nameStmt = conn.prepareStatement(nameSql)) {
                            nameStmt.setString(1, email);
                            try (ResultSet nameRs = nameStmt.executeQuery()) {
                                if (nameRs.next()) {
                                    String name = nameRs.getString("name");

                                    // Create or get session
                                    HttpSession session = request.getSession(true);

                                    // Store common attributes in session
                                    session.setAttribute("user_id", user_id);
                                    session.setAttribute("email", email);
                                    session.setAttribute("user_role_id", user_role_id);
                                    session.setAttribute("name", name);
                                    session.setAttribute("welcomePopup", false);

                                    // Fetch specific IDs and redirect based on user_role_id
                                    switch (user_role_id) {
                                        case 1:
                                            response.sendRedirect("src/pages/Admin/Admin_Order_Management.jsp");
                                            break;
                                        case 2: { // Customer
                                            String customerSql = "SELECT customer_id FROM CUSTOMERS WHERE user_id = ?";
                                            try (PreparedStatement customerStmt = conn.prepareStatement(customerSql)) {
                                                customerStmt.setInt(1, user_id);
                                                try (ResultSet customerRs = customerStmt.executeQuery()) {
                                                    if (customerRs.next()) {
                                                        int customer_id = customerRs.getInt("customer_id");
                                                        session.setAttribute("customer_id", customer_id);
//                                                        out.println("<h2>"+customer_id+ "</h2>");
                                                        response.sendRedirect("src/pages/Home/Home.jsp");
                                                    } else {
                                                        out.println("<h2>Customer ID not found!</h2>");
                                                    }
                                                }
                                            }
                                            break;
                                        }
                                        case 3: { // Restaurant Owner
                                            String restaurantSql = "SELECT restaurant_id FROM RESTAURANTS WHERE owner_user_id = ?";
                                            try (PreparedStatement restaurantStmt = conn.prepareStatement(restaurantSql)) {
                                                restaurantStmt.setInt(1, user_id);
                                                try (ResultSet restaurantRs = restaurantStmt.executeQuery()) {
                                                    if (restaurantRs.next()) {
                                                        int restaurant_id = restaurantRs.getInt("restaurant_id");
                                                        session.setAttribute("restaurant_id", restaurant_id);
//                                                        out.println("<h2>"+restaurant_id+ "</h2>");
                                                        response.sendRedirect("src/pages/Restaurant/RestaurantDashboard.jsp");
                                                    } else {
                                                        out.println("<h2>Restaurant ID not found!</h2>");
                                                    }
                                                }
                                            }
                                            break;
                                        }
                                        case 4: { // Delivery Executive
                                            String deliverySql = "SELECT delivery_executive_id FROM DELIVERY_EXECUTIVES WHERE user_id = ?";
                                            try (PreparedStatement deliveryStmt = conn.prepareStatement(deliverySql)) {
                                                deliveryStmt.setInt(1, user_id);
                                                try (ResultSet deliveryRs = deliveryStmt.executeQuery()) {
                                                    if (deliveryRs.next()) {
                                                        int delivery_executive_id = deliveryRs.getInt("delivery_executive_id");
                                                        session.setAttribute("delivery_executive_id", delivery_executive_id);
//                                                        out.println("<h2>"+delivery_executive_id+ "</h2>");
                                                        response.sendRedirect("src/pages/DeliveryExecutive/DeliveryDashboard.jsp");
                                                    } else {
                                                        out.println("<h2>Delivery Executive ID not found!</h2>");
                                                    }
                                                }
                                            }
                                            break;
                                        }
                                        default:
                                            out.println("<h2>Invalid Role!</h2>");
                                    }
                                }
                            }
                        }
                    } else {
                        // Invalid credentials
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


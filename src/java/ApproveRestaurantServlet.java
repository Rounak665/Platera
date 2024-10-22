import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.pool.OracleDataSource;

@WebServlet("/approveRestaurant")
public class ApproveRestaurantServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ApproveRestaurantServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       
            try (Connection conn = Database.getConnection()) { // Using try-with-resources
            if (conn == null) {
                LOGGER.severe("Database connection failed.");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to connect to the database.");
                return;
            }

            int request_id = Integer.parseInt(request.getParameter("request_id"));
            LOGGER.info("Processing request ID: " + request_id);

            // Get the request details
            String selectSql = "SELECT * FROM restaurant_requests WHERE request_id = ?";
            try (PreparedStatement selectPstmt = conn.prepareStatement(selectSql)) {
                selectPstmt.setInt(1, request_id);
                ResultSet rs = selectPstmt.executeQuery();

                if (rs.next()) {
                    // Insert the approved restaurant into the users table
                    String insertUserSql = "INSERT INTO users (name, email, password, phone, user_role) VALUES (?, ?, ?, ?, 'restaurant_owner')";
                    try (PreparedStatement insertUserPstmt = conn.prepareStatement(insertUserSql)) {
                        insertUserPstmt.setString(1, rs.getString("owner_name"));
                        insertUserPstmt.setString(2, rs.getString("email"));
                        insertUserPstmt.setString(3, rs.getString("password")); // Ensure to hash the password
                        insertUserPstmt.setString(4, rs.getString("phone"));
                        insertUserPstmt.executeUpdate();
                    }

                    // Get the generated user_id
                    String userIdSql = "SELECT user_id FROM users WHERE email = ?";
                    try (PreparedStatement userIdPstmt = conn.prepareStatement(userIdSql)) {
                        userIdPstmt.setString(1, rs.getString("email"));
                        ResultSet userIdRs = userIdPstmt.executeQuery();
                        int userId = 0;
                        if (userIdRs.next()) {
                            userId = userIdRs.getInt("user_id");
                        }

                        // Now insert into the restaurants table
                        String insertRestaurantSql = "INSERT INTO restaurants (name, owner_user_id, phone, address, bank_acc_name, bank_acc_number, gstin_number, pan_number, fssai_lic_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement insertRestaurantPstmt = conn.prepareStatement(insertRestaurantSql)) {
                            insertRestaurantPstmt.setString(1, rs.getString("restaurant_name"));
                            insertRestaurantPstmt.setInt(2, userId);
                            insertRestaurantPstmt.setString(3, rs.getString("phone"));
                            insertRestaurantPstmt.setString(4, rs.getString("address"));
                            insertRestaurantPstmt.setString(5, rs.getString("bank_acc_name"));
                            insertRestaurantPstmt.setString(6, rs.getString("bank_acc_number"));
                            insertRestaurantPstmt.setString(7, rs.getString("gst_in"));
                            insertRestaurantPstmt.setString(8, rs.getString("pan_number"));
                            insertRestaurantPstmt.setString(9, rs.getString("fssai_lic_no"));
                            insertRestaurantPstmt.executeUpdate();
                        }

//                         Now delete the processed request
                        String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
                        try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql)) {
                            deletePstmt.setInt(1, request_id);
                            deletePstmt.executeUpdate();
                        }
                        response.setContentType("text/html");
                        response.getWriter().println("<h2>Restaurant has been approved successfully</h2>");
                    }
                } else {
                    LOGGER.warning("No request found for request ID: " + request_id);
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No request found for the given ID.");
                    return;
                }
            }
            System.out.println("Approved successfully"); 

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error occurred: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + e.getMessage());
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid request ID: " + request.getParameter("request_id"), e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request ID format.");
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Unexpected error occurred: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error occurred.");
        } finally {
            // Close the connection in the finally block
            
        }
    }
}

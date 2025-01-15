package Admin;

import Utilities.Database;
import Utilities.EmailUtility;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/approveRestaurant")
public class ApproveRestaurant extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ApproveRestaurant.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection conn = Database.getConnection()) {
            if (conn == null) {
                LOGGER.severe("Database connection failed.");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to connect to the database.");
                return;
            }

            int request_id = Integer.parseInt(request.getParameter("request_id"));
            LOGGER.info("Processing request ID: " + request_id);

            // Get the request details
            String selectSql = "SELECT * FROM restaurant_requests WHERE request_id = ?";
            String email = null;

            try (PreparedStatement selectPstmt = conn.prepareStatement(selectSql)) {
                selectPstmt.setInt(1, request_id);
                ResultSet rs = selectPstmt.executeQuery();

                if (rs.next()) {
                    email = rs.getString("email");  // Retrieve email for notification

                    // Insert the approved restaurant into the users table
                    String insertUserSql = "INSERT INTO users (name, email, password, phone, address, user_role_id) VALUES (?, ?, ?, ?, ?, '3')";
                    try (PreparedStatement insertUserPstmt = conn.prepareStatement(insertUserSql)) {
                        insertUserPstmt.setString(1, rs.getString("owner_name"));
                        insertUserPstmt.setString(2, rs.getString("email"));
                        insertUserPstmt.setString(3, rs.getString("password")); // Ensure to hash the password
                        insertUserPstmt.setString(4, rs.getString("owner_phone"));
                        insertUserPstmt.setString(5, rs.getString("owner_address"));
                        insertUserPstmt.executeUpdate();
                    }

                    // Get the generated user_id
                    String userIdSql = "SELECT user_id FROM users WHERE email = ?";
                    int userId = 0;
                    try (PreparedStatement userIdPstmt = conn.prepareStatement(userIdSql)) {
                        userIdPstmt.setString(1, rs.getString("email"));
                        ResultSet userIdRs = userIdPstmt.executeQuery();
                        if (userIdRs.next()) {
                            userId = userIdRs.getInt("user_id");
                        }

                        // Now insert into the restaurants table
                        String insertRestaurantSql = "INSERT INTO restaurants (restaurant_name, owner_user_id, phone, address, image,location_id, min_price, max_price) VALUES (?, ?, ?, ?, ?, ?, ?, ? )";
                        try (PreparedStatement insertRestaurantPstmt = conn.prepareStatement(insertRestaurantSql)) {
                            insertRestaurantPstmt.setString(1, rs.getString("restaurant_name"));
                            insertRestaurantPstmt.setInt(2, userId);
                            insertRestaurantPstmt.setString(3, rs.getString("restaurant_phone"));
                            insertRestaurantPstmt.setString(4, rs.getString("restaurant_address"));
                            insertRestaurantPstmt.setString(5, rs.getString("image"));
                            insertRestaurantPstmt.setString(6, rs.getString("location"));
                            insertRestaurantPstmt.setString(7, rs.getString("min_price"));
                            insertRestaurantPstmt.setString(8, rs.getString("max_price"));
                            insertRestaurantPstmt.executeUpdate();
                        }
                        String restaurantIdSql = "SELECT restaurant_id FROM restaurants WHERE owner_user_id = ?";
                        int restaurantId = 0;
                        try (PreparedStatement restaurantIdPstmt = conn.prepareStatement(restaurantIdSql)) {
                            restaurantIdPstmt.setInt(1, userId);
                            ResultSet restaurantIdRs = restaurantIdPstmt.executeQuery();
                            if (restaurantIdRs.next()) {
                                restaurantId = restaurantIdRs.getInt("restaurant_id");
                            }
                            response.setContentType("text/html");
                            response.getWriter().println("<h2>Restaurant Id:" + restaurantId + "</h2>");

                            String insertRestaurantDocumentsSql = "INSERT INTO restaurant_documents ( restaurant_id, gstin,bank_acc_name, bank_acc_number, fssai_lic_number, pan_number) VALUES ( ?, ?, ?, ?, ?, ?) ";
                            try (PreparedStatement insertRestaurantDocumentsPstmt = conn.prepareStatement(insertRestaurantDocumentsSql)) {
                                insertRestaurantDocumentsPstmt.setInt(1, restaurantId);
                                insertRestaurantDocumentsPstmt.setString(2, rs.getString("gst_in"));
                                insertRestaurantDocumentsPstmt.setString(3, rs.getString("bank_acc_name"));
                                insertRestaurantDocumentsPstmt.setString(4, rs.getString("bank_acc_number"));
                                insertRestaurantDocumentsPstmt.setString(5, rs.getString("fssai_lic_no"));
                                insertRestaurantDocumentsPstmt.setString(6, rs.getString("pan_number"));
                                insertRestaurantDocumentsPstmt.executeUpdate();
                            }

                            String insertRestaurantCategorySql = "INSERT INTO restaurant_categories ( restaurant_id, category_1, category_2, category_3) VALUES (?, ?, ?, ? )";
                            try (PreparedStatement insertRestaurantCategoryPstmt = conn.prepareStatement(insertRestaurantCategorySql)) {
                                insertRestaurantCategoryPstmt.setInt(1, restaurantId);
                                insertRestaurantCategoryPstmt.setInt(2, rs.getInt("category_1"));
                                insertRestaurantCategoryPstmt.setInt(3, rs.getInt("category_2"));
                                insertRestaurantCategoryPstmt.setInt(4, rs.getInt("category_3"));
                                insertRestaurantCategoryPstmt.executeUpdate();
                            }
                            // Delete the processed request
                            String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
                            try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql)) {
                                deletePstmt.setInt(1, request_id);
                                deletePstmt.executeUpdate();
                            }
                            String subject = "Approval of Your Platera Restaurant Application";
                            String body = "Dear Restaurant Owner,\n\n"
                                    + "Congratulations! Your application to register your restaurant with Platera has been approved.\n"
                                    + "Welcome to the Platera family. We look forward to working with you!\n\n"
                                    + "Best regards,\nThe Platera Team";
                            if (email != null) {
                                EmailUtility.sendEmail(email, subject, body);
                            }
                            response.sendRedirect("src/pages/Confirmations/requestApprove.html");

                        }
                    }
                } else {
                    response.sendRedirect("src/pages/Admin/Admin_Restaurant_Approval.jsp#errorPopup");
                }
            } catch (Exception ex) {
                response.sendRedirect("src/pages/Admin/Admin_Restaurant_Approval.jsp#errorPopup");
                return;
            }

        } catch (SQLException e) {
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        } catch (NumberFormatException e) {
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        } catch (IOException e) {
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}

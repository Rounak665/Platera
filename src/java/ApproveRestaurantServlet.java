//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//@WebServlet("/approveRestaurant")
//public class ApproveRestaurantServlet extends HttpServlet {
//
//    // Database connection parameters
//    private static final String DB_URL = "jdbc:oracle:thin:@//<hostname>:<port>/<service_name>";
//    private static final String DB_USER = "<username>";
//    private static final String DB_PASSWORD = "<password>";
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        // Ensure this servlet only handles POST requests (or GET as desired)
//        if (!"POST".equalsIgnoreCase(request.getMethod())) {
//            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Method not allowed");
//            return;
//        }
//
//        int requestId = Integer.parseInt(request.getParameter("request_id"));
//
//        // Debug output to log
//        System.out.println("Processing approval for request ID: " + requestId);
//
//        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
//            // Get the request details
//            String selectSql = "SELECT * FROM restaurant_requests WHERE request_id = ?";
//            PreparedStatement selectPstmt = conn.prepareStatement(selectSql);
//            selectPstmt.setInt(1, requestId);
//            ResultSet rs = selectPstmt.executeQuery();
//
//            if (rs.next()) {
//                // Insert the approved restaurant into the users table
//                String insertUserSql = "INSERT INTO users (name, email, password, phone, address, user_role) VALUES (?, ?, ?, ?, ?, 'restaurant_owner')";
//                try (PreparedStatement insertUserPstmt = conn.prepareStatement(insertUserSql)) {
//                    insertUserPstmt.setString(1, rs.getString("owner_name"));
//                    insertUserPstmt.setString(2, rs.getString("email"));
//                    insertUserPstmt.setString(3, rs.getString("password")); // Ensure to hash the password
//                    insertUserPstmt.setString(4, rs.getString("phone"));
//                    insertUserPstmt.setString(5, rs.getString("address")); // Fixed index for address
//                    insertUserPstmt.executeUpdate();
//                }
//
//                // Get the generated user_id
//                String userIdSql = "SELECT user_id FROM users WHERE email = ?";
//                try (PreparedStatement userIdPstmt = conn.prepareStatement(userIdSql)) {
//                    userIdPstmt.setString(1, rs.getString("email"));
//                    ResultSet userIdRs = userIdPstmt.executeQuery();
//                    int userId = 0;
//                    if (userIdRs.next()) {
//                        userId = userIdRs.getInt("user_id");
//                    }
//
//                    // Now insert into the restaurants table
//                    String insertRestaurantSql = "INSERT INTO restaurants (name, owner_user_id, phone, address, bank_acc_name, bank_acc_number, gstin, pan_number, fssai_lic_no) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
//                    try (PreparedStatement insertRestaurantPstmt = conn.prepareStatement(insertRestaurantSql)) {
//                        insertRestaurantPstmt.setString(1, rs.getString("restaurant_name"));
//                        insertRestaurantPstmt.setInt(2, userId);
//                        insertRestaurantPstmt.setString(3, rs.getString("phone"));
//                        insertRestaurantPstmt.setString(4, rs.getString("address"));
//                        insertRestaurantPstmt.setString(5, rs.getString("bank_acc_name"));
//                        insertRestaurantPstmt.setString(6, rs.getString("bank_acc_number"));
//                        insertRestaurantPstmt.setString(7, rs.getString("gstin"));
//                        insertRestaurantPstmt.setString(8, rs.getString("pan_number"));
//                        insertRestaurantPstmt.setString(9, rs.getString("fssai_lic_no"));
//                        insertRestaurantPstmt.executeUpdate();
//                    }
//
//                    // Now delete the processed request
//                    String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
//                    try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql)) {
//                        deletePstmt.setInt(1, requestId);
//                        deletePstmt.executeUpdate();
//                    }
//                }
//            } else {
//                System.out.println("No request found for ID: " + requestId);
//                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Request not found");
//                return;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace(); // Print the full stack trace for debugging
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
//            return;
//        }
//
//        response.sendRedirect("adminApprovalSuccess.html"); // Redirect to a success page
//    }
//}

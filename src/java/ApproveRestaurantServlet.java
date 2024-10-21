import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/approveRestaurant")
public class ApproveRestaurantServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("request_id"));

        try (Connection conn = Database.getConnection()) {
            // Get the request details
            String selectSql = "SELECT * FROM restaurant_requests WHERE request_id = ?";
            PreparedStatement selectPstmt = conn.prepareStatement(selectSql);
            selectPstmt.setInt(1, requestId);
            ResultSet rs = selectPstmt.executeQuery();

            if (rs.next()) {
                // Insert the approved restaurant into the users table
                String insertUserSql = "INSERT INTO users (name, email, password, phone, address, user_role) VALUES (?, ?, ?, ?, ?, 'restaurant_owner')";
                PreparedStatement insertUserPstmt = conn.prepareStatement(insertUserSql);
                insertUserPstmt.setString(1, rs.getString("owner_name"));
                insertUserPstmt.setString(2, rs.getString("email"));
                insertUserPstmt.setString(3, rs.getString("password")); // Ensure to hash the password
                insertUserPstmt.setString(4, rs.getString("phone"));
                insertUserPstmt.setString(5, rs.getString("address"));
                insertUserPstmt.executeUpdate();

                // Get the generated user_id
                String userIdSql = "SELECT user_id FROM users WHERE email = ?";
                PreparedStatement userIdPstmt = conn.prepareStatement(userIdSql);
                userIdPstmt.setString(1, rs.getString("email"));
                ResultSet userIdRs = userIdPstmt.executeQuery();
                int userId = 0;
                if (userIdRs.next()) {
                    userId = userIdRs.getInt("user_id");
                }

                // Now insert into the restaurants table
                String insertRestaurantSql = "INSERT INTO restaurants (name, owner_user_id, phone, address, bank_acc_name, bank_acc_number, gst_in, pan_number, fssai_lic_no) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertRestaurantPstmt = conn.prepareStatement(insertRestaurantSql);
                insertRestaurantPstmt.setString(1, rs.getString("restaurant_name"));
                insertRestaurantPstmt.setInt(2, userId);
                insertRestaurantPstmt.setString(3, rs.getString("phone"));
                insertRestaurantPstmt.setString(4, rs.getString("address"));
                insertRestaurantPstmt.setString(5, rs.getString("bank_acc_name"));
                insertRestaurantPstmt.setString(6, rs.getString("bank_acc_number"));
                insertRestaurantPstmt.setString(7, rs.getString("gstin"));
                insertRestaurantPstmt.setString(8, rs.getString("pan_number"));
                insertRestaurantPstmt.setString(9, rs.getString("fssai_lic_no"));
                insertRestaurantPstmt.executeUpdate();

                // Now delete the processed request
                String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
                PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
                deletePstmt.setInt(1, requestId);
                deletePstmt.executeUpdate();
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
            return;
        }

        response.sendRedirect("adminApprovalSuccess.html"); // Redirect to a success page
    }
}

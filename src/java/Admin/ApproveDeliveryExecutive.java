package Admin;

import Utilities.Database;
import Utilities.EmailUtility;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/ApproveDeliveryExecutive"})
public class ApproveDeliveryExecutive extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ApproveDeliveryExecutive.class.getName());
    private static final String IMAGE_DIRECTORY = "DatabaseImages/Delivery_Executives";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int request_id = Integer.parseInt(request.getParameter("request_id"));

        try (Connection conn = Database.getConnection()) {
            if (conn == null) {
                LOGGER.severe("Database connection failed.");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to connect to the database.");
                return;
            }

            String selectSql = "SELECT * FROM DELIVERY_EXECUTIVE_REQUESTS WHERE REQUEST_ID = ?";
            String email = null;

            try (PreparedStatement selectPstmt = conn.prepareStatement(selectSql)) {
                selectPstmt.setInt(1, request_id);
                ResultSet rs = selectPstmt.executeQuery();

                if (rs.next()) {
                    email = rs.getString("email"); // Retrieve email for notification

                    // Insert into the users table
                    String insertUsersSql = "INSERT INTO users(name, email, password, phone, address, user_role_id) VALUES (?, ?, ?, ?, ?, 4)";
                    try (PreparedStatement insertUsersPstmt = conn.prepareStatement(insertUsersSql)) {
                        insertUsersPstmt.setString(1, rs.getString("name"));
                        insertUsersPstmt.setString(2, rs.getString("email"));
                        insertUsersPstmt.setString(3, rs.getString("password"));
                        insertUsersPstmt.setInt(4, rs.getInt("phone"));
                        insertUsersPstmt.setString(5, rs.getString("address"));
                        insertUsersPstmt.executeUpdate();
                    }

                    // Retrieve the user_id after insertion into the users table
                    int userId = 0;
                    String userIdSql = "SELECT user_id FROM users WHERE email = ?";
                    try (PreparedStatement userIdPstmt = conn.prepareStatement(userIdSql)) {
                        userIdPstmt.setString(1, email);
                        ResultSet userIdRs = userIdPstmt.executeQuery();

                        if (userIdRs.next()) {
                            userId = userIdRs.getInt("user_id");
                        } else {
                            LOGGER.severe("User with email " + email + " does not exist in the users table.");
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "User does not exist.");
                            return;
                        }
                    }

                    // Get the real path of the servlet
                    String realPath = getServletContext().getRealPath("/");
                    String projectRoot = new File(realPath).getParentFile().getParent(); // Going back two levels
                    String imageDirectoryPath = projectRoot + File.separator + "web" + File.separator + IMAGE_DIRECTORY;

                    // Create the directory if it doesn't exist
                    File imageDirectory = new File(imageDirectoryPath);
                    if (!imageDirectory.exists()) {
                        imageDirectory.mkdirs();  
                    }

                    // Retrieve CLOB image data and decode it to save as a file
                    Clob clobImage = rs.getClob("image");
                    if (clobImage != null) {
                        String imageBase64 = clobImage.getSubString(1, (int) clobImage.length());
                        byte[] imageBytes = Base64.getDecoder().decode(imageBase64);

                        File imageFile = new File(imageDirectoryPath + File.separator + "delivery_executive_" + userId + ".jpg");

                        try (FileOutputStream fos = new FileOutputStream(imageFile)) {
                            fos.write(imageBytes);
                        } catch (IOException e) {
                            LOGGER.log(Level.SEVERE, "Error saving image file: " + e.getMessage(), e);
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving image file.");
                            return;
                        }
                    }

                    // Insert into the delivery_executives table, using the retrieved user_id
                    String insertDelExecSql = "INSERT INTO delivery_executives (user_id, image,location) VALUES (?, ?, ?)";
                    try (PreparedStatement insertDelExecPstmt = conn.prepareStatement(insertDelExecSql)) {
                        insertDelExecPstmt.setInt(1, userId);
                        insertDelExecPstmt.setString(2, IMAGE_DIRECTORY + File.separator + "delivery_executive_" + userId + ".jpg");
                        insertDelExecPstmt.setInt(3, rs.getInt("location"));   
                        insertDelExecPstmt.executeUpdate();

                        // Get the generated delivery_executive_id                       
                    }
                    
                    int deliveryExecutiveId=0;
                    String delExecIdSql = "SELECT delivery_executive_id FROM delivery_executives WHERE user_id = ?";
                    try (PreparedStatement delExecIdSqlPstmt = conn.prepareStatement(delExecIdSql)) {
                        delExecIdSqlPstmt.setInt(1, userId);
                        ResultSet delExecIdSqlRs = delExecIdSqlPstmt.executeQuery();

                        if (delExecIdSqlRs.next()) {
                            deliveryExecutiveId = delExecIdSqlRs.getInt("delivery_executive_id");
                        } else {
                            LOGGER.severe("User with email " + email + " does not exist in the users table.");
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "User does not exist.");
                            return;
                        }
                    }
                    

                    // Insert into the delivery_executive_documents table, using the retrieved delivery_executive_id
                    String insertDelExecDocsSql = "INSERT INTO delivery_executive_documents (delivery_executive_id, aadhar_number, pan_number, driving_license_number, gender, age, vehicle_type, vehicle_number, bank_account_name, bank_account_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement insertDelExecDocsPstmt = conn.prepareStatement(insertDelExecDocsSql)) {
                        insertDelExecDocsPstmt.setInt(1, deliveryExecutiveId);  // Use the generated delivery_executive_id
                        insertDelExecDocsPstmt.setInt(2, rs.getInt("aadhar_number"));
                        insertDelExecDocsPstmt.setString(3, rs.getString("pan_number"));
                        insertDelExecDocsPstmt.setString(4, rs.getString("driving_license_number"));
                        insertDelExecDocsPstmt.setString(5, rs.getString("gender"));
                        insertDelExecDocsPstmt.setInt(6, rs.getInt("age"));
                        insertDelExecDocsPstmt.setString(7, rs.getString("vehicle_type"));
                        insertDelExecDocsPstmt.setString(8, rs.getString("vehicle_number"));
                        insertDelExecDocsPstmt.setString(9, rs.getString("bank_account_name"));
                        insertDelExecDocsPstmt.setString(10, rs.getString("bank_account_number"));
                        insertDelExecDocsPstmt.executeUpdate();
                    }

                    // Delete the processed request
//                    String deleteSql = "DELETE FROM DELIVERY_EXECUTIVE_REQUESTS WHERE REQUEST_ID = ?";
//                    try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql)) {
//                        deletePstmt.setInt(1, request_id);
//                        deletePstmt.executeUpdate();
//                    }

                    response.setContentType("text/html");
                    response.getWriter().println("<h2>Delivery Executive has been approved successfully</h2>");

                    // Send approval email
                    String subject = "Approval of Your Platera Delivery Executive Application";
                    String body = "Dear Applicant,\n\n"
                            + "Congratulations! Your application to join Platera as a Delivery Executive has been approved.\n"
                            + "Welcome to the Platera team. We look forward to working with you!\n\n"
                            + "Best regards,\nThe Platera Team";
                    if (email != null) {
                        EmailUtility.sendEmail(email, subject, body);
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error occurred: " + ex.getMessage(), ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + ex.getMessage());
        }
    }
}

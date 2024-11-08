package Platera;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
                    String insertUserSql = "INSERT INTO users (name, email, password, phone, user_role_id) VALUES (?, ?, ?, ?, '3')";
                    try (PreparedStatement insertUserPstmt = conn.prepareStatement(insertUserSql)) {
                        insertUserPstmt.setString(1, rs.getString("owner_name"));
                        insertUserPstmt.setString(2, rs.getString("email"));
                        insertUserPstmt.setString(3, rs.getString("password")); // Ensure to hash the password
                        insertUserPstmt.setString(4, rs.getString("phone"));
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

                        // Delete the processed request
                        String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
                        try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql)) {
                            deletePstmt.setInt(1, request_id);
                            deletePstmt.executeUpdate();
                        }
                        response.setContentType("text/html");
                        response.getWriter().println("<h2>Restaurant has been approved successfully</h2>");

                        // Send approval email if the email was retrieved successfully
                        if (email != null) {
                            sendApprovalEmail(email);
                        }
                    }
                } else {
                    LOGGER.warning("No request found for request ID: " + request_id);
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No request found for the given ID.");
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
        }
    }

    private void sendApprovalEmail(String email) {
        String subject = "Approval of Your Platera Restaurant Application";
        String body = "Dear Restaurant Owner,\n\n" +
                      "Congratulations! Your application to register your restaurant with Platera has been approved.\n" +
                      "Welcome to the Platera family. We look forward to working with you!\n\n" +
                      "Best regards,\nThe Platera Team";

        final String username = "plateraminorproject@gmail.com";  // Use your actual Gmail account
        final String passwordEmail = "ybnwqkgdnlmlywbf"; // Use your actual Gmail App Password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, passwordEmail);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            LOGGER.log(Level.INFO, "Approval email sent to: " + email);
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Error sending approval email", e);
        }
    }
}

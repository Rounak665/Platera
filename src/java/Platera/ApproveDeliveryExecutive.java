package Platera;

import FetchingClasses.Database;
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

@WebServlet(urlPatterns = {"/ApproveDeliveryExecutive"})
public class ApproveDeliveryExecutive extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ApproveDeliveryExecutive.class.getName());

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
                    String insertUsersSql = "INSERT INTO users(name, email, password, phone, address, user_role_id) VALUES (?, ?, ?, ?,?, 4)";
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
                        userIdPstmt.setString(1, email); // Use the email from the request
                        ResultSet userIdRs = userIdPstmt.executeQuery();

                        if (userIdRs.next()) {
                            userId = userIdRs.getInt("user_id"); // Retrieve the user_id
                        } else {
                            // If user_id is not found, log an error and return
                            LOGGER.severe("User with email " + email + " does not exist in the users table.");
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "User does not exist.");
                            return;
                        }
                    }

                    // Insert into the delivery_executives table, using the retrieved user_id
                    String insertDelExecSql = "INSERT INTO delivery_executives (user_id, image) VALUES (?, ?)";
                    try (PreparedStatement insertDelExecPstmt = conn.prepareStatement(insertDelExecSql)) {
                        insertDelExecPstmt.setInt(1, userId);
                        insertDelExecPstmt.setString(2, rs.getString("image"));                      
                        insertDelExecPstmt.executeUpdate();  
                        
                    }
                    
                    int delExecId=0;
                    String DelExecIdSql = "SELECT delivery_executive_id FROM delivery_executives WHERE user_id = ?";
                    try (PreparedStatement DelExecIdPstmt = conn.prepareStatement(DelExecIdSql)) {
                        DelExecIdPstmt.setInt(1, userId); // Use the email from the request
                        ResultSet DelExecIdRs = DelExecIdPstmt.executeQuery();
                        if (DelExecIdRs.next()) {
                            delExecId = DelExecIdRs.getInt("delivery_executive_id"); // Retrieve the user_id
                        }                         
                        
                    }
                    String insertDelExecDocsSql = "INSERT INTO delivery_executive_documents (delivery_executive, aadhar_number, pan_number, driving_license_number, gender, age, vehicle_type, vehicle_number, bank_account_name, bank_account_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement insertDelExecDocsPstmt = conn.prepareStatement(insertDelExecDocsSql)) {
                        insertDelExecDocsPstmt.setInt(1, delExecId);
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

                    // Send approval email if the email was retrieved successfully
                    if (email != null) {
                        sendApprovalEmail(email);
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error occurred: " + ex.getMessage(), ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + ex.getMessage());
        }
    }

    private void sendApprovalEmail(String email) {
        String subject = "Approval of Your Platera Delivery Executive Application";
        String body = "Dear Applicant,\n\n"
                + "Congratulations! Your application to join Platera as a Delivery Executive has been approved.\n"
                + "Welcome to the Platera team. We look forward to working with you!\n\n"
                + "Best regards,\nThe Platera Team";

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

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

@WebServlet(urlPatterns = {"/RejectDeliveryExecutive"})
public class RejectDeliveryExecutive extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RejectDeliveryExecutive.class.getName());

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

            String selectSql = "SELECT email FROM DELIVERY_EXECUTIVE_REQUESTS WHERE REQUEST_ID = ?";
            String email = null;

            try (PreparedStatement selectPstmt = conn.prepareStatement(selectSql)) {
                selectPstmt.setInt(1, request_id);
                ResultSet rs = selectPstmt.executeQuery();

                if (rs.next()) {
                    email = rs.getString("email"); // Retrieve email for notification

                    // Delete the processed request
                    String deleteSql = "DELETE FROM DELIVERY_EXECUTIVE_REQUESTS WHERE REQUEST_ID = ?";
                    try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql)) {
                        deletePstmt.setInt(1, request_id);
//                        deletePstmt.executeUpdate();
                    }

                    response.setContentType("text/html");
                    response.getWriter().println("<h2>Delivery Executive application has been rejected successfully</h2>");

                    // Send rejection email if the email was retrieved successfully
                    if (email != null) {
                        sendRejectionEmail(email);
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Database error occurred: " + ex.getMessage(), ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + ex.getMessage());
        }
    }

    private void sendRejectionEmail(String email) {
        String subject = "Platera Delivery Executive Application Rejected";
        String body = "Dear Applicant,\n\n" +
                      "We regret to inform you that your application to join Platera as a Delivery Executive has not been approved at this time.\n" +
                      "Thank you for your interest in joining us, and we wish you the best in your future endeavors.\n\n" +
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
            LOGGER.log(Level.INFO, "Rejection email sent to: " + email);
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Error sending rejection email", e);
        }
    }
}

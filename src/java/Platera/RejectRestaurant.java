package Platera;

import Utilities.Database;
import Utilities.EmailUtility;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
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

@WebServlet("/rejectRestaurant")
public class RejectRestaurant extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int request_id = Integer.parseInt(request.getParameter("request_id"));
        String email = null;  // Define email variable to store the email address

        try (Connection conn = Database.getConnection()) {

            // Retrieve email from the request record before it's deleted
            String selectSql = "SELECT email FROM restaurant_requests WHERE request_id = ?";
            try (PreparedStatement selectPstmt = conn.prepareStatement(selectSql)) {
                selectPstmt.setInt(1, request_id);
                ResultSet rs = selectPstmt.executeQuery();
                if (rs.next()) {
                    email = rs.getString("email");  // Store the retrieved email
                }
            }

            String deleteSql = "DELETE FROM restaurant_requests WHERE request_id = ?";
            try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql)) {
                deletePstmt.setInt(1, request_id);
                deletePstmt.executeUpdate();
                response.setContentType("text/html");
                response.getWriter().println("<h2>Restaurant has been rejected successfully</h2>");
            }

        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + e.getMessage());
            return;
        }

        String subject = "Your Platera Restaurant Signup Rejection";
        String body = "Dear Restaurant Owner,\n\n"
                + "We regret to inform you that your restaurant registration request has been rejected.\n\n"
                + "If you have any questions, feel free to contact us.\n\n"
                + "Best regards,\nThe Platera Team";

        if (email != null) {
            EmailUtility.sendEmail(email, subject, body);
        }
    }
}

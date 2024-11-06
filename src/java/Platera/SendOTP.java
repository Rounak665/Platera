package Platera;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.mail.*;
import javax.mail.internet.*;

import java.util.Properties;

public class SendOTP extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Get form data
            String name = request.getParameter("name_signup");
            String email = request.getParameter("email_signup");
            String password = request.getParameter("password_signup");
            String repassword = request.getParameter("repassword_signup");

            // Check if passwords match
            if (!password.equals(repassword)) {
                out.println("<html><body><h2 style='color:red;'>Passwords do not match. Please try again.</h2></body></html>");
                return;
            }
            
            // Send confirmation email
            final String username = "your-email@gmail.com";
            final String passwordEmail = "your-email-password";  // Replace with actual email password

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, passwordEmail);
                }
            });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(username));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Welcome to Platera");

                // Email Body Content
                String emailBody = "Hello " + name + ",\n\n" +
                                   "Thank you for signing up on Platera. Your account has been successfully created.\n\n" +
                                   "Regards,\nPlatera Team";

                message.setText(emailBody);

                // Send email
                Transport.send(message);

                // Response message after sending email
                out.println("<html><body><h2 style='color:green;'>A confirmation email has been sent to " + email + "</h2></body></html>");
            } catch (MessagingException e) {
                out.println("<html><body><h2 style='color:red;'>Error sending email: " + e.getMessage() + "</h2></body></html>");
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling signup and sending confirmation email";
    }
}

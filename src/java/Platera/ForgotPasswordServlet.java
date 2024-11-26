package Platera;

import FetchingClasses.Database;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        // Generate OTP
        Random rand = new Random();
        int otp = rand.nextInt(999999);
        
        // Store OTP in session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);
        
        // Send OTP to email
        String subject = "Platera OTP for Password Reset";
        String messageContent = "Your OTP for password reset is: " + otp;
        
        boolean isEmailSent = sendEmail(email, subject, messageContent);
        
        if (isEmailSent) {
            response.sendRedirect("ForgotPassVerifyOTP.jsp");
        } else {
            PrintWriter out = response.getWriter();
            out.println("Error sending OTP to email.");
        }
    }
    
    private boolean sendEmail(String to, String subject, String messageContent) {
        String from = "your-email@example.com";  // Your email address
        String host = "smtp.example.com";  // SMTP server
        String password = "your-email-password";  // Email password

        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(messageContent);
            
            Transport.send(message);
            return true;
        } catch (MessagingException mex) {
            mex.printStackTrace();
            return false;
        }
    }
}
